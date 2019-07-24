pragma solidity ^0.5.10;

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
    }
    
    Order[] Orders;
    
    // End of helper storage for Order
    /* ====================================================================================== */
    
    
    
    
    // public interface
    function orderFood(uint _restIndex, uint _stuIndex, string memory _recievingAddress, uint[] memory _menuIndexList, uint[] memory _menuCountList, uint _menuNum, uint _totalPrice, uint _tokenUsed, uint _actualPrice) public { 
        Orders.push(Order(_restIndex, _stuIndex, _recievingAddress,
                          "Pending", _menuIndexList,  _menuCountList, 
                          _menuNum, _totalPrice, _tokenUsed, _actualPrice));     // add new order to the list
    }
    
    function getRestOrderList(uint _restIndex) public view returns (uint[] memory, uint) {   // return the index array of untreated order and it's length
        uint num = 0;
        uint[] memory untreatedOrderList = new uint[](Orders.length);
        for(uint i = 0; i < Orders.length; i++){
            if(Orders[i].restIndex == _restIndex && keccak256(abi.encodePacked(Orders[i].status)) == keccak256(abi.encodePacked("Pending"))) {   // restaurant is same to msg.sender and status is sending
                untreatedOrderList[num] = i; 
                num++;
            } 
        }
        
        return (untreatedOrderList, num);
    }
    
    
    function getOrderInfo(uint _orderIndex) public view returns (uint, uint, string memory, string memory, uint[] memory, uint[] memory, uint, uint, uint, uint) {   // returns all info of order
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
                o.actualPrice);
    }
    
    function confirmOrder(uint _orderIndex, bool _isAccept) public {    // isAccept is true: confirm, false: reject
        // requires for the test of error and validation
        require(msg.sender == Restaurants[Orders[_orderIndex].restIndex].Address);    // msg sender should be same to the restaurant of order
        require(keccak256(abi.encodePacked(Orders[_orderIndex].status)) == keccak256(abi.encodePacked("Pending")));   // should be pending
        if(_isAccept) {
            Orders[_orderIndex].status = "Confirm";
            Token.addressToToken[msg.sender] += Orders[_orderIndex].tokenUsed;
            Token.addressToToken[Students[Orders[_orderIndex].stuIndex].Address] -= Orders[_orderIndex].tokenUsed;
        }
        else {
            Orders[_orderIndex].status = "Reject";
        }
    }
    
    
    
}