pragma solidity ^0.4.18;

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




contract BRriders {
    /* ========================================================================================================================*/
    // START of storages
    
    // basic
    address owner;
    
    
    // struct of important storages: student and restaurant
    struct Student {
        string nickName;
        string name;    // Real name
        uint8 department;  // See above to see matching of integer and department
        address Address;
    }
    
    struct Restaurant {
        string restName;  
        string phoneNumber;
        string physicalAddress;  // Real location of the restaurant
        address Address;
    }
    
    
    // arrays and mappings, variables to hold information of users
    Student[] stuCandidates;    // registers student users
    mapping (uint16 => Student) Students;    // validated student users
    mapping (address => uint16) findStuIndex;    // To find index of Students array from address
    uint16 stuNum;
    
    Restaurant[] restCandidates;   // Same for restaurants
    mapping (uint16 => Restaurant) Restaurants;
    mapping (address => uint16) findRestIndex; 
    uint16 restNum;
    
    address[] validAddress;   // account addresses which are validated
    
    
    
    
    // END of storages
    /* ========================================================================================================================*/
    
    
    
    // constructor
    function BRriders() public {
        // initialization of variables
        stuNum = 0;
        restNum = 0;
        owner = msg.sender;
    }
    
    // basic modifier
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    /* ====================================================================================== */
    // functions about signUp and Login
    // helper
    function isAddressValid(address _address) private view returns (bool) {  // function to check whether address is validated by the owner
        for(uint i = 0; i < validAddress.length; i++){
            if(validAddress[i] == _address) return true;
        }
        return false;
    }
    
    
    // interface
    function addValidAddress(address _address, bool isAccept) public onlyOwner {  // can be called only by owner
        if(isAccept){
            validAddress.push(_address);
        }
        else {
            
        }
    }
    
    function requestStuRegister(string _nickName, string _name, uint8 _department) public returns (bool){   // handle signUp of student
        require(isAddressValid(msg.sender));
        findStuIndex[msg.sender] = stuNum;
        Students[stuNum] = Student(_nickName, _name, _department, msg.sender);
        stuNum++;
    }
    
    function requestRestRegister(string _restName, string _phoneNumber, string _physicalAddress) public returns (bool) { // handle signUp of student
    
    }
    // End of functions about signUp and Login
    /* ====================================================================================== */
    
    
    
    
}