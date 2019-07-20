pragma solidity ^0.4.18;

import "./BCRidersRestaurant.sol";
import "./BCRidersLogin.sol";
import "./BCRidersReview.sol";

contract BCRiders is BCRidersRestaurant, BCRidersLogin, BCRidersReview {
    // constructor
    function BCRiders() public {
        // initialization of variables from BCRidersStorage
        stuNum = 0;
        restNum = 0;
        menuNum = 0;
        owner = msg.sender;
        Token.totalTokenPublished = 0;
        Token.totalTokenInNetwork = 0;
    }
    
}