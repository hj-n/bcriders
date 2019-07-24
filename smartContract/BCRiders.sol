pragma solidity ^0.5.10;

import "./BCRidersRestaurant.sol";
import "./BCRidersLogin.sol";
import "./BCRidersReview.sol";

contract BCRiders is BCRidersRestaurant, BCRidersLogin, BCRidersReview {
    
    function setOwner(address _address) public {
        owner = _address;
    }
    
    // constructor
    constructor() public {
        // initialization of variables from BCRidersStorage
        stuNum = 0;
        restNum = 0;
        menuNum = 0;
        owner = msg.sender;
        Token.totalTokenPublished = 0;
        Token.totalTokenInNetwork = 0;
        lastDistributedTime = now;
    }
    
    // public function 
    function distributeToken() public onlyOwner {
        require(now > lastDistributedTime + 300);       // 1 weeks should pass after distribution// change 604800 -> 300 for demo
        
        /* ==========================================================*/
        // STEP 1
        uint T = 0;
        
        for(uint i = 0; i < restNum; i++) {
            Restaurant memory r = Restaurants[i];
            T += r.tokenPromise;
            takeTokenBack(r.tokenPromise, r.Address);   // take away promised token
        }
        uint R = (T * 4) / 10;
        R = R / restNum;
        uint S = (T * 6) / 10;
        S = S / stuNum;
        
        // STEP 2 & 3
        for(uint i=0; i < restNum; i++){
            Token.addressToToken[Restaurants[i].Address] += R;
        }
        for(uint i=0; i < stuNum; i++) {
            Token.addressToToken[Students[i].Address] += S;
        }
        
    }
    
}