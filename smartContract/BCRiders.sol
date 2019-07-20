pragma solidity ^0.4.18;

import "./BCRidersLogin.sol";
import "./BCRidersRestaurant.sol";
import "./BCRidersToken.sol";

contract BCRiders is BCRidersLogin, BCRidersRestaurant {
    
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