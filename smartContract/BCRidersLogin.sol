pragma solidity ^0.5.10;

import "./BCRidersToken.sol";


contract BCRidersLogin is BCRidersToken {
    /* ====================================================================================== */
    // functions about signUp and Login
    // helper
    function isAddressValid(address _address) public view returns (bool) {  // function to check whether address is validated by the owner
        for(uint i = 0; i < validAddress.length; i++){
            if(validAddress[i] == _address) return true;
        }
        return false;
    }
    
    function isAddressSignedUp(address _address) public view returns (bool) {  // function to check wheter address is already signed up (prevent duplicated register)
        for(uint i = 0; i < signUpAddress.length; i++){
            if(signUpAddress[i] == _address) return true;
        }
        return false;
    }
    
    // interface ( public functions)
    
    function addValidAddress(address _address) public {  // can be called only by owner
            validAddress.push(_address);
    }
    
    function requestStuRegister(string memory _nickName, string memory _name, uint8 _department) public {   // handle signUp of student
        require(isAddressValid(msg.sender));
        require(!isAddressSignedUp(msg.sender));     // prevent duplicated register
        findStuIndex[msg.sender] = stuNum;
        Students[stuNum] = Student(_nickName, _name, _department, msg.sender, false, true);
        stuNum++;      // increase for next register student index
        signUpAddress.push(msg.sender);
        isAddressStuOrRest[msg.sender] = true;
    }
    
    function requestRestRegister(string memory _nickName, string memory _restName, string memory _phoneNumber, string memory _physicalAddress, uint _category, uint _tokenPromise) public { // handle signUp of student
        require(isAddressValid(msg.sender));
        require(!isAddressSignedUp(msg.sender));
        
        findRestIndex[msg.sender] = restNum;
        Restaurants[restNum] = Restaurant(_nickName, _restName, _phoneNumber, _physicalAddress, "", _category, _tokenPromise, msg.sender);
        restNum++;
        
        signUpAddress.push(msg.sender);
        isAddressStuOrRest[msg.sender] = false;
        Token.totalTokenInNetwork += 1500000;
        Token.totalTokenPublished += 1500000;
        Token.addressToToken[msg.sender] = 1500000;       // Give Initial Token
        Exchanges[msg.sender] = Exchange(0, true, true);     // set Default to use in exchange request
    }
    
    function isSignedUpUser() public view returns (bool) {
        if(isAddressValid(msg.sender)) {
            if(isAddressSignedUp(msg.sender)){
                if(isAddressStuOrRest[msg.sender]) {    // if student
                    return true;
                }
            }
        }
        else {
            return false;
        }
    }
    // End of functions about signUp and Login
    /* ====================================================================================== */

}



