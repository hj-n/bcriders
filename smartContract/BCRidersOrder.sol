pragma solidity ^0.4.18;

import "./BCRidersStorage.sol";


contract BCRidersOrder is BCRidersStorage {
    /* ====================================================================================== */
    // helper storage for Order
    
    struct Order {
        uint restIndex;
        uint stuIndex;
        string status;     // Pending: not treated yet, Confirm: confirmed order, Reject: rejected order
        string recievingAddress; // real address to get food
        uint[] menuIndexList;  // the list of menu Index that ordered
        uint[] menuCountList;   // the list of menu number that corresponding menu of menuIndexList has.
        uint menuNum;    // number of menus that ordered (not the total quantity of foods ordered)
        uint totalPrice;
        uint tokenUsed;
        uint actualPrice;     // real Price: totalPrice - tokenUsed / 10.
        uint orderTime;
    }
    
    Order[] Orders;
    
    // End of helper storage for Order
    /* ====================================================================================== */
    
    
    
    
    // public interface
    function orderFood(uint _restIndex, uint _stuIndex, string _recievingAddress, uint[] _menuIndexList, uint[] _menuCountList, uint _menuNum, uint _totalPrice, uint _tokenUsed, uint _actualPrice) public onlyStuAccount(_stuIndex) { 
        Orders.push(Order(_restIndex, _stuIndex, _recievingAddress,
                          "Pending", _menuIndexList,  _menuCountList, 
                          _menuNum, _totalPrice, _tokenUsed, _actualPrice, now));     // add new order to the list
    }
    
    function getRestOrderList(uint _restIndex) public view onlyRestAccount(_restIndex) returns (uint[], uint) {   // return the index array of untreated order and it's length
        uint num = 0;
        uint[] memory untreatedOrderList = new uint[](Orders.length);
        for(uint i = 0; i < Orders.length; i++){
            if(Orders[i].restIndex == _restIndex && keccak256(Orders[i].status) == keccak256("Pending")) {   // restaurant is same to msg.sender and status is sending
                untreatedOrderList[num] = i; 
                num++;
            } 
        }
        
        uint[] memory shrinkedOrderList = new uint[](num);       // shrink the size of the array ( for easy treat at the browser)
        for(uint j = 0; j < Orders.length; j++) {
            shrinkedOrderList[j] = untreatedOrderList[j];
        }
        return (shrinkedOrderList, num);
    }
    
    function getStuOrderList(uint _stuIndex) public view onlyStuAccount(_stuIndex) returns (uint[], uint) {  // for student, show the information about this week's order
        uint limit = now - 604800;  // 604800 is one week: Therefore this function only returns order after limit
        
        uint num = 0;
        uint[] memory untreatedOrderList = new uint[](Orders.length);
        for(uint i = 0; i < Orders.length; i++){
            if(Orders[i].stuIndex == _stuIndex && Orders[i].orderTime > limit) {   // limitation for the 1 week added
                untreatedOrderList[num] = i; 
                num++;
            } 
        }
        
        uint[] memory shrinkedOrderList = new uint[](num);       // shrink the size of the array ( for easy treat at the browser)
        for(uint j = 0; j < Orders.length; j++) {
            shrinkedOrderList[j] = untreatedOrderList[j];
        }
        return (shrinkedOrderList, num);
    }
    
    function getOrderInfo(uint _orderIndex) public view returns (uint, uint, string, string, uint[], uint[], uint, uint, uint, uint, uint) {   // returns all info of order
        Order memory o = Orders[_orderIndex];
        return (o.restIndex, 
                o.stuIndex, 
                o.status,
                o.recievingAddress,
                o.menuIndexList,
                o.menuCountList,
                o.menuNum,
                o.totalPrice,
                o.tokenUsed,
                o.actualPrice,
                o.orderTime);
    }
    
    function confirmOrder(uint _orderIndex, bool isAccept) public {    // isAccept is true: confirm, false: reject
        // requires for the test of error and validation
        require(msg.sender == Restaurants[Orders[_orderIndex].restIndex].Address);    // msg sender should be same to the restaurant of order
        require(keccak256(Orders[_orderIndex].status) == keccak256("Pending"));   // should be pending
        if(isAccept) {
            Orders[_orderIndex].status = "Confirm";
            Token.addressToToken[msg.sender] += Orders[_orderIndex].tokenUsed;
            Token.addressToToken[Students[Orders[_orderIndex].stuIndex].Address] -= Orders[_orderIndex].tokenUsed;
        }
        else {
            Orders[_orderIndex].status = "Reject";
        }
    }
    
    function getLastOrderTimePassed(uint _restIndex) public view returns (bool,uint) {   // returns passed time since msg.sender had ordered food from the restaurant. if bool is false, never ordered
        for(uint i = Orders.length - 1; i >= 0; i--) {
            if(Students[Orders[i].stuIndex].Address == msg.sender && Orders[i].restIndex == _restIndex) {
                return (true, now - Orders[i].orderTime);
            }
        }
        return (false, 0);  // never ordered before
    }
    
    
    
}