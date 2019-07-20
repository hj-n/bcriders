pragma solidity ^0.4.18;

import "./BCRidersOrder.sol";

contract BCRidersReview is BCRidersOrder {
    /* ====================================================================================== */
    // helper storage for review
    
    struct Review {
        uint restIndex;
        uint stuIndex;
        uint restStar;     // star (score) that the review gives to the restaurant (0: 0, 1: 100, 2: 200 ... 5: 500) *100한값 저장
        uint reviewStar;   // average score of the star (score) from other people to review
        uint numReviewStar;   // num of people who evaluated the review
        string title;
        string content;
        string reply;    // This is filled by rest
        bool isReply;    // false: no review reply, true: There exist review reply
        uint reviewTime;
    }
    
    Review[] Reviews;
    
    struct Evaluation {
        address stuAddress;
        uint reviewIndex;
    }
    
    Evaluation[] Evals;
    
    // end of helper storage
    /* ====================================================================================== */
    
    
    // helper functions
    
    
    

    
    // interface (public functions)
    
    function writeReview(uint _restIndex, uint _stuIndex, uint _restStar, string _title, string _content) public onlyStuAccount(_stuIndex) returns (bool) {
        uint timePassed;
        bool isThereOrder;
        (isThereOrder, timePassed) = getLastOrderTimePassed(_restIndex);
        if (!isThereOrder || timePassed > 604800) {    // if there is no order or 1 weeks had passed
            return false;
        }
        else {
            Reviews.push(Review(_restIndex, _stuIndex, _restStar, 0, 0,  _title, _content, "", false, now));
            return true;
        }
    }
    
    function getRestReviewList(uint _restIndex) public view returns (uint[], uint) {   // retrun the list of review of restaurant's index and it's length
        uint[] memory restReviewList = new uint[](Reviews.length);
        uint num = 0;
        for(uint i = Reviews.length - 1; i >= 0; i--){
            if(Reviews[i].restIndex == _restIndex) {
                restReviewList[num] = i;
                num++;
            }
        }
        
        uint[] memory shrinkedReviewList = new uint[](num);
        for(uint j = 0; j < num; j++){
            shrinkedReviewList[j] = restReviewList[j];
        }
        return (shrinkedReviewList, num);
    }
    
    function getStuReviewList(uint _stuIndex) public view returns (uint[], uint) {   // same mechanism with getRestReviewList
        uint[] memory stuReviewList = new uint[](Reviews.length);
        uint num = 0;
        for(uint i = Reviews.length - 1; i >= 0; i--){
            if(Reviews[i].stuIndex == _stuIndex) {
                stuReviewList[num] = i;
                num++;
            }
        }
        
        uint[] memory shrinkedReviewList = new uint[](num);
        for(uint j = 0; j < num; j++){
            shrinkedReviewList[j] = stuReviewList[j];
        }
        return (shrinkedReviewList, num);
    }
    
    function getReviewInfo(uint _reviewIndex) public view returns (uint, uint, uint, uint, string, string, string, bool, uint) { // returns the info of review
        Review memory r = Reviews[_reviewIndex];
        return (r.restIndex,
                r.stuIndex,
                r.restStar,
                r.reviewStar,
                r.title,
                r.content,
                r.reply,
                r.isReply,
                r.reviewTime);
    }
    
    
    function evaluateReview(uint _reviewIndex, uint _stuIndex, uint _reviewStar) public onlyStuAccount(_stuIndex) returns (bool) {  // return false if there is already an evaluation to such review
        for(uint i = 0; i < Evals.length; i++){
            if(Evals[i].reviewIndex == _reviewIndex) {
                return false;
            }
        }
        Evals.push(Evaluation(msg.sender, _reviewIndex));
        
        // update the star to review state
        uint currentReviewStar = Reviews[_reviewIndex].reviewStar;
        Reviews[_reviewIndex].numReviewStar++;
        Reviews[_reviewIndex].reviewStar = (currentReviewStar * (Reviews[_reviewIndex].numReviewStar) + _reviewStar) / Reviews[_reviewIndex].numReviewStar;
        return true;
    }
    
    function writeReviewReply(uint _reviewIndex, string _reply) public returns (bool) {  // return false if msg.sender is not the restaurant that review says about
        if(findRestIndex[msg.sender] != Reviews[_reviewIndex].restIndex) {  // check whether Restaurant is review's objective
            return false;
        }
        else {
            Reviews[_reviewIndex].isReply = true;
            Reviews[_reviewIndex].reply = _reply;
        }
    }
    
    
    
    
    
    
    
    
    
}