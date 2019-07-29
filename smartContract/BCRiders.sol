pragma solidity ^0.4.18;

import "./BCRidersRestaurant.sol";
import "./BCRidersLogin.sol";
import "./BCRidersReview.sol";
import "./BCRidersOrderPeriodic.sol";

contract BCRiders is BCRidersRestaurant, BCRidersLogin, BCRidersReview, BCRidersOrderPeriodic {
    
    
    
    // constructor
    function BCRiders() public {
        // initialization of variables from BCRidersStorage
        stuNum = 0;
        restNum = 0;
        menuNum = 0;
        owner = msg.sender;
        Token.totalTokenPublished = 0;
        Token.totalTokenInNetwork = 0;
        lastDistributedTime = now;
    }
    
    function distributeTokenStudent(uint S) public onlyOwner {
        uint revReward = (S * 7) / 10;
        uint evalNumReward = S / 10;
        uint orderNumReward = (S * 2) / 10;
        
        uint[] memory stuRewardList = new uint[](stuNum);
        for(uint i = 0; i < stuNum; i++) {
            stuRewardList[i] = 0;
        }
        
        // Step 2-1
        uint reviewStarSumThisWeek = 0;
        uint[] memory reviewStarSumPerStu = new uint[](stuNum);
        for(i = 0; i < stuNum; i++) {
            reviewStarSumPerStu[i] = 0;
        }
        for(i = 0; i < Reviews.length; i++) {
            reviewStarSumThisWeek += Reviews[i].reviewStar;
            reviewStarSumPerStu[Reviews[i].stuIndex] += Reviews[i].reviewStar;
        }
        if(reviewStarSumThisWeek > 0) {      // error handle - what if no review this week?
            for(i = 0; i < stuNum; i++) {
                stuRewardList[i] += (reviewStarSumPerStu[i] * revReward * 9) / (10 * reviewStarSumThisWeek);
            }
        }
        // Step 2-2
        uint evalNumThisWeek = 0;
        uint[] memory evalNumPerStu = new uint[](stuNum);
        for(i = 0; i < stuNum; i++) {
            evalNumPerStu[i] = 0;
        }
        for(i = 0; i < Evals.length; i++) {
            if(Evals[i].evaluateTime > now - 604800) {   // check one week record
                evalNumPerStu[findStuIndex[Evals[i].stuAddress]]++;
                evalNumThisWeek++;
            }
        }
        if(evalNumThisWeek > 0) {
            for(i = 0; i < stuNum; i++) {
                stuRewardList[i] += (evalNumPerStu[i] * evalNumReward) / evalNumThisWeek;
            }
        }
        // Step 2-3
        uint orderNumThisWeek = 0;
        uint[] memory orderNumPerStu = new uint[](stuNum);
        for(i = 0; i < stuNum; i++) {
            orderNumPerStu[i] = 0;
        }
        for(i = 0; i < Orders.length; i++) {
            if(Orders[i].orderTime > now - 604800) {
                orderNumPerStu[Orders[i].stuIndex]++;
                orderNumThisWeek++;
            }
        }
        if(orderNumThisWeek > 0) {
            for(i = 0; i < stuNum; i++) {
                stuRewardList[i] += (orderNumPerStu[i] * orderNumReward) / orderNumThisWeek;
            }
        }
        
        // send!!
        for(i = 0; i < stuNum; i++) {
            sendTokenToAccount(stuRewardList[i], Students[i].Address);
        }
    }
    
    function distributeTokenRestaurant(uint R) public onlyOwner {
        
        uint restEvalReward = (R * 7) / 10;
        uint restReplyNumReward = (R * 3) / 10;
        
        
        uint[] memory restReward = new uint[](restNum);
        for(uint i = 0; i < stuNum; i++) {     // initialization
            restReward[i] = 0; 
        }
        // Step 3-1
        int[] memory modifiedStarToRest = new int[](Reviews.length);
        
        uint modifiedRestStarSum = 0;
        uint[] memory modifiedRestStarSumPerStu = new uint[](restNum);
        
        for(i = 0; i < stuNum; i++) {    // initialization
            modifiedRestStarSumPerStu[i] = 0;
        }
        for(i = 0; i < Reviews.length; i++) {
            if(Reviews[i].reviewTime > now - 604800) {   // check 1 week record
                modifiedStarToRest[i] = int(Reviews[i].reviewStar) * 2 - 500;    // now range is -5 ~ 5
                modifiedStarToRest[i] = modifiedStarToRest[i] * int(Reviews[i].restStar) / 100 + 2500;   // now range is 0~20
                modifiedRestStarSumPerStu[Reviews[i].restIndex] += uint(modifiedStarToRest[i]);
                modifiedRestStarSum += uint(modifiedStarToRest[i]);
            }
        }
        if(modifiedRestStarSum > 0) {
            for(i = 0; i < stuNum; i++) {
                restReward[i] += (modifiedRestStarSumPerStu[i] * restEvalReward) / modifiedRestStarSum;
            }
        }
        
        // Step 3-2
        uint replyNumThisWeek = 0;
        uint[] memory replyNumPerRest = new uint[](restNum);
        
        for(i = 0; i < restNum; i++) {
            replyNumPerRest[i] = 0;
        }
        for(i = 0; i < Reviews.length; i++) {
            if(Reviews[i].reviewTime > now - 604800) {
                if(Reviews[i].isReply) {
                    replyNumThisWeek++;
                    replyNumPerRest[Reviews[i].restIndex]++;
                }
            }
        }
        if (replyNumThisWeek > 0) {
            for(i = 0; i < restNum; i++) {
                restReward[i] += (replyNumPerRest[i] * restReplyNumReward) / replyNumThisWeek;
            }
        }
        
        // send!!
        for(i = 0; i < restNum; i++) {
            sendTokenToAccount(restReward[i], Restaurants[i].Address);
        }

    }
    
    // public function 
    function distributeToken() public onlyOwner {
        require(now > lastDistributedTime + 604800);       // 1 weeks should pass after distribution
        
        /* ==========================================================*/
        // STEP 1
        uint T = 0;
        
        for(uint i = 0; i < restNum; i++) {
            Restaurant memory r = Restaurants[i];
            T += r.tokenPromise;
            takeTokenBack(r.tokenPromise, r.Address);   // take away promised token
        }
        uint R = (T * 4) / 10;
        uint S = (T * 6) / 10;
        
        // STEP 2 & 3
        distributeTokenStudent(S);
        distributeTokenRestaurant(R);
    }
    
}