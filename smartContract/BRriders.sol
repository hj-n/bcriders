pragma solidity ^0.4.18;

import "./BCRidersLogin.sol";

contract BCRiders is BCRidersLogin {
    // constructor
    function BCriders() public {
        // initialization of variables
        stuNum = 0;
        restNum = 0;
        owner = msg.sender;
        RidersToken.totalTokenPublished = 0;
        RidersToken.totalTokenInNetwork = 0;
    }
    
    
}