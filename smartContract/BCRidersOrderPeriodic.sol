pragma solidity ^0.5.10;

import "./BCRidersOrder.sol";

contract BCRidersOrderPeriodic is BCRidersOrder {
    // This contract is consists of functions which executes periodically by web for alarm service
    
    mapping (uint => uint) stuToOrderIndex;
    
    // for Restaurant
    function isUntreatedOrderExist(uint _restIndex) public view returns (bool) {   // check rest's pending orders
        for(uint i = Orders.length - 1; i >= 0; i--) {
            if(Orders[i].restIndex == _restIndex && keccak256(abi.encodePacked(Orders[i].status)) == keccak256(abi.encodePacked("Pending"))) {
                return true;
            }
        }
        return false;
    }
   
    
}