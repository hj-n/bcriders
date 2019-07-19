pragma solidity ^0.4.18;

import "./BCRidersStorage.sol";

// basic promises
/*
1. Department matching:
    1: Mathematics
    2: Physics
    3: Chemistry
    4: Life Science
    5: Matrials Science & Engineering
    6: Mechanical Engineering
    7: Industrial and Management Engineering
    8: Electronic and Electric Engineering
    9: Computer Science and Engineering
    10: Chemical Engineering
    11: Creative IT Engineering
*/



contract BCRidersLogin is BCRidersStorage {
    
    
    // basic modifier
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
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
    
    // interface
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
        return true;
    }
    
    function requestRestRegister(string _restName, string _phoneNumber, string _physicalAddress) public returns (bool) { // handle signUp of student
        if(!isAddressValid(msg.sender)) return false;
        if (isAddressSignedUp(msg.sender)) return false;
        findRestIndex[msg.sender] = restNum;
        Restaurants[restNum] = Restaurant(_restName, _phoneNumber, _physicalAddress, msg.sender);
        restNum++;
        signUpAddress.push(msg.sender);
        return true;
    }
    // End of functions about signUp and Login
    /* ====================================================================================== */
    
    
}



