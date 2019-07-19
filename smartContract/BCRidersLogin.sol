pragma solidity ^0.4.18;

import "./BCRidersStorage.sol";


contract BCRidersLogin is BCRidersStorage {
    /* ====================================================================================== */
    // functions about signUp and Login
    // helper
    function isAddressValid(address _address) internal view returns (bool) {  // function to check whether address is validated by the owner
        for(uint i = 0; i < validAddress.length; i++){
            if(validAddress[i] == _address) return true;
        }
        return false;
    }
    
    function isAddressSignedUp(address _address) internal view returns (bool) {  // function to check wheter address is already signed up (prevent duplicated register)
        for(uint i = 0; i < signUpAddress.length; i++){
            if(signUpAddress[i] == _address) return true;
        }
        return false;
    }
    
    // interface ( public functions)
    
    function addValidAddress(address _address, bool isAccept) public onlyOwner {  // can be called only by owner
        if(isAccept){
            validAddress.push(_address);
        }
    }
    
    function requestStuRegister(string _nickName, string _name, uint8 _department) public returns (bool){   // handle signUp of student
        if(!isAddressValid(msg.sender)) return false;
        if (isAddressSignedUp(msg.sender)) return false;     // prevent duplicated register
        findStuIndex[msg.sender] = stuNum;
        Students[stuNum] = Student(_nickName, _name, _department, msg.sender);
        stuNum++;      // increase for next register student index
        signUpAddress.push(msg.sender);
        isAddressStuOrRest[msg.sender] = true;
        return true;
    }
    
    function requestRestRegister(string _nickName, string _restName, string _phoneNumber, string _physicalAddress, uint _category, uint _tokenPromise) public returns (bool) { // handle signUp of student
        if(!isAddressValid(msg.sender)) return false;
        if (isAddressSignedUp(msg.sender)) return false;
        
        uint tokenPromiseModified;              // Set tokenPromise to certain range ( to avoid too much or less promise)
        if (_tokenPromise > 50000) {
            tokenPromiseModified = 50000;
        } 
        else if (_tokenPromise < 10000) {
            tokenPromiseModified = 10000;
        }
        else {
            tokenPromiseModified = _tokenPromise;
        }
        
        findRestIndex[msg.sender] = restNum;
        Restaurants[restNum] = Restaurant(_nickName, _restName, _phoneNumber, _physicalAddress, "", _category, tokenPromiseModified, msg.sender);
        restNum++;
        
        signUpAddress.push(msg.sender);
        isAddressStuOrRest[msg.sender] = false;
        Token.totalTokenInNetwork += 1500000;
        Token.totalTokenPublished += 1500000;
        Token.restAddressToToken[msg.sender] = 1500000;       // Give Initial Token
        return true;
    }
    
    function isSignedUpUser(string _nickName) public view returns (bool, string) {
        if(isAddressValid(msg.sender)) {
            if(isAddressSignedUp(msg.sender)){
                if(isAddressStuOrRest[msg.sender]) {    // if student
                    if(keccak256(Students[findStuIndex[msg.sender]].nickName) == keccak256(_nickName)) {
                        return (true, "Student");
                    }
                    else {
                        return (false, "WrongNickName");
                    }
                }
                else {   // if restaurant
                    if(keccak256(Restaurants[findRestIndex[msg.sender]].nickName) == keccak256(_nickName)) {
                        return (true, "Restaurant");
                    }
                    else{
                        return (false, "WrongNickName");
                    }
                }
            }
            else {
                return (false, "NotSignedUp");
            }
        }
        else {
            return (false, "NotRegistered");
        }
    }
    // End of functions about signUp and Login
    /* ====================================================================================== */

}



