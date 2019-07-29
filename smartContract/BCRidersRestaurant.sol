pragma solidity ^0.4.18;

import "./BCRidersLogin.sol";
import "./BCRidersStorage.sol";

contract BCRidersRestaurant is BCRidersStorage {
    /* ====================================================================================== */
    // functions about Restaurant
    
    // interface (public functions)
    
    function getRestList(uint _category) public view returns (uint[], uint) {   // returns  list of "restaurant index" and length
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
            uint[] memory shrinkedIndexList = new uint[](k);   // now we know the number of rests in certain category, so shrink!!
            for(uint l = 0; l < k; l++){
                shrinkedIndexList[l] = restIndexList[l];
            }
            return (restIndexList, k);
        }
    }
    
    function getRestInfo(uint _restIndex) public view returns (string, string, string, string, string, uint, uint) {  //returns nickName, restName, phoneNumber, physicalAddress, explanation, category, tokenPromise
        return (Restaurants[_restIndex].nickName,
                Restaurants[_restIndex].restName,
                Restaurants[_restIndex].phoneNumber, 
                Restaurants[_restIndex].physicalAddress,
                Restaurants[_restIndex].explanation,
                Restaurants[_restIndex].category,
                Restaurants[_restIndex].tokenPromise);
    }
    
    function getRestMenuList(uint _restIndex) public view returns (uint[], uint)  {   // returns index array of menu, and their length
        uint[] memory menuIndexList = new uint[](menuNum);
        
        uint restMenuNum = 0;
        for(uint i = 0; i < menuNum; i++){
            if(Menus[i].restIndex == _restIndex) {
                menuIndexList[restMenuNum] = i;
                restMenuNum++;
            }
        }
        
    // similar to getRestList function (shrink the size of output)
        uint[] memory shrinkedIndexList = new uint[](restMenuNum);   
        for(uint j = 0; j < restMenuNum; j++){
            shrinkedIndexList[j] = menuIndexList[j];
        }
        return (shrinkedIndexList, restMenuNum);
    }
    
    function getMenuInfo(uint _menuIndex) public view returns (string, uint, string) {    // retruns name and price of the menu
        return (Menus[_menuIndex].name, Menus[_menuIndex].price, Menus[_menuIndex].explanation);
    }
    
    function addNewMenu(string _name, uint _price, string _explanation, uint _restIndex) public onlyRestAccount(_restIndex) {
        Menus.push(Menu(_name, _price, _explanation, _restIndex));
        menuNum++;
    }
    
    function manageRestInfo(string _restName, string _phoneNumber, string _physicalAddress, uint _category, uint _restIndex) public onlyRestAccount(_restIndex)  {
        Restaurants[_restIndex].restName = _restName;
        Restaurants[_restIndex].phoneNumber = _phoneNumber;
        Restaurants[_restIndex].physicalAddress = _physicalAddress;
        Restaurants[_restIndex].category = _category;
    }
    
    function manageRestExplanation(string _explanation, uint _restIndex) public onlyRestAccount(_restIndex) {
        Restaurants[_restIndex].explanation = _explanation;
    }
    
    function manageRestPromise(uint _tokenPromise, uint _restIndex) public onlyRestAccount(_restIndex) {
        require(Token.addressToToken[Restaurants[_restIndex].Address] > 10000);
        if(_tokenPromise < 10000) {
            Restaurants[_restIndex].tokenPromise = 10000;
        }
        else if(_tokenPromise > 50000) {
            Restaurants[_restIndex].tokenPromise = 50000;
        }
        else {
            Restaurants[_restIndex].tokenPromise = _tokenPromise;
        }
    }
    
    
    // End of functions about Restaurant
    /* ====================================================================================== */
    
}