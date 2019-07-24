pragma solidity ^0.5.10;

import "./BCRidersLogin.sol";
import "./BCRidersStorage.sol";

contract BCRidersRestaurant is BCRidersStorage {
    /* ====================================================================================== */
    // functions about Restaurant
    
    // interface (public functions)
    
    function getRestList(uint _category) public view returns (uint[] memory, uint) {   // returns  list of "restaurant index" and length
        uint[] memory restIndexList = new uint[](restNum);    
        
        if(_category == 0) {    // request for all restaurant (for main page)
            for(uint i = 0; i < restNum; i++){
                restIndexList[i] = i;
            }
            return (restIndexList, restNum);
        }
        else {
            uint k = 0;
            for(uint j = 0; j < restNum; j++){
                if(Restaurants[j].category == _category){
                    restIndexList[k] = j;
                    k++;
                }
            }
            return (restIndexList, k);
        }
    }
    
    function getRestInfo(uint _restIndex) public view returns (string memory, string memory, string memory , string memory , string memory, uint, uint) {  //returns nickName, restName, phoneNumber, physicalAddress, explanation, category, tokenPromise
        return (Restaurants[_restIndex].nickName,
                Restaurants[_restIndex].restName,
                Restaurants[_restIndex].phoneNumber, 
                Restaurants[_restIndex].physicalAddress,
                Restaurants[_restIndex].explanation,
                Restaurants[_restIndex].category,
                Restaurants[_restIndex].tokenPromise);
    }
    
    function getRestMenuList(uint _restIndex) public view returns (uint[] memory, uint)  {   // returns index array of menu, and their length
        uint[] memory menuIndexList = new uint[](menuNum);
        
        uint restMenuNum = 0;
        for(uint i = 0; i < menuNum; i++){
            if(Menus[i].restIndex == _restIndex) {
                menuIndexList[restMenuNum] = i;
                restMenuNum++;
            }
        }

        return (menuIndexList, restMenuNum);
    }
    
    function getMenuInfo(uint _menuIndex) public view returns (string memory, uint, string memory) {    // retruns name and price of the menu
        return (Menus[_menuIndex].name, Menus[_menuIndex].price, Menus[_menuIndex].explanation);
    }
    
    function addNewMenu(string memory _name, uint _price, string memory _explanation, uint _restIndex) public onlyRestAccount(_restIndex) {
        Menus.push(Menu(_name, _price, _explanation, _restIndex));
        menuNum++;
    }
    
    function manageRestPromise(uint _tokenPromise, uint _restIndex) public onlyRestAccount(_restIndex) {
        require(Token.addressToToken[Restaurants[_restIndex].Address] > 10000);
        Restaurants[_restIndex].tokenPromise = _tokenPromise;
    }
    
    
    // End of functions about Restaurant
    /* ====================================================================================== */
    
}