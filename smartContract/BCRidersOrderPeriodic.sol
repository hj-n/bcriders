pragma solidity ^0.4.18;

import "./BCRidersOrder.sol";

contract BCRidersOrderPeriodic is BCRidersOrder {
    // This contract is consists of functions which executes periodically by web for alarm service
    
    mapping (uint => uint) stuToOrderIndex;
    
    // for Restaurant
    function isUntreatedOrderExist(uint _restIndex) public view returns (bool) {   // check rest's pending orders
        for(uint i = Orders.length - 1; i >= 0; i--) {
            if(Orders[i].restIndex == _restIndex && keccak256(Orders[i].status) == keccak256("Pending")) {
                return true;
            }
        }
        return false;
    }
    
    // for Student
    function isStuOrdered(uint _stuIndex) public onlyStuAccount(_stuIndex) { // return true if there is untreated order
        require(Students[_stuIndex].hasPendingOrder == false);       // can only executed when there is found pending order. After finding it, don't needs to be executed
        for(uint i = Orders.length - 1; i >= 0; i--) {
            if(Orders[i].stuIndex == _stuIndex && keccak256(Orders[i].status) == keccak256("Pending")) {
                Students[_stuIndex].hasPendingOrder = true;
                stuToOrderIndex[_stuIndex] = i;
            }
        }
    }
    
    function isOrderTreated(uint _stuIndex) public view returns (string, bool) {   // if pending order had rejected: "Reject", confirmed: "Confirm", returns true if order treated and student didn't check it.
       // if this function's return value is "True", then alarm
       if(Students[_stuIndex].hasPendingOrder == true && keccak256(Orders[stuToOrderIndex[_stuIndex]].status) != keccak256("Pending")){
           return (Orders[stuToOrderIndex[_stuIndex]].status,true);
       }
       else {
           return ("",false);
       }
    }
    
    
    // Not periodic, but to control alarm
    function checkAlarm(uint _stuIndex) public onlyStuAccount(_stuIndex) { // check alarm, then alarm is not necessary
        Students[_stuIndex].hasPendingOrder = false;
    }
    
}