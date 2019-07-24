pragma solidity ^0.5.10;


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
    
2. Category matching:
    0: ALL
    1. Korean
    2. Burger
    3. Chicken
    4. Pizza
    5. Chinese
    6. Snack ( Tteokbokki )
    7. Japanese
    8. Meat (gogi)
    9. Salad 
*/


contract BCRidersStorage {
    // basic
    address public owner;
    uint lastDistributedTime;    // last time "DistributeToken" has executed
    
    /* ====================================================================================== */
    // token info
    struct ridersToken {     // Riders Token info
        uint totalTokenInNetwork;     // total token inside network (Amount of token hold by users)
        uint totalTokenPublished;      // total token which is published since the network begin
        mapping (address => uint) addressToToken;
    }
    
    ridersToken Token;  // This will hold the information about token
    
    // end of token info
    /* ====================================================================================== */
    
    
    // struct and mapping of Menu
    struct Menu {
        string name;
        uint price;
        string explanation;
        uint restIndex;    // holds the information about the restaurant index holding the menu
    }
    
    Menu[] Menus;
    uint menuNum;
    
    
    // struct of important storages: student and restaurant
    struct Student {
        string nickName;
        string name;    // Real name
        uint department;  // See above "Department matching" btw integer and department
        address Address;
        
        bool hasPendingOrder; // true if the student has pending order. Otherwise, false
        bool checkedOrderAlarm; // true if the student checked treated order. Otherwise, false
    }
    
    struct Restaurant {
        string nickName;
        string restName;  
        string phoneNumber;
        string physicalAddress;  // Real location of the restaurant
        string explanation;  
        uint category; // See above "Category matching" btw int and category
        uint tokenPromise;  // promise of token that can publish a week
        address Address;
    }
    
    
    // arrays and mappings, variables to hold information of users
    Student[] stuCandidates;    // registers student users
    mapping (uint => Student)  Students;    // validated student users
    mapping (address => uint16) public findStuIndex;    // To find index of Students array from address
    uint16 stuNum;
    
    Restaurant[] restCandidates;   // Same for restaurants
    mapping (uint => Restaurant) Restaurants;
    mapping (address => uint16) public findRestIndex; 
    uint16 restNum;
    
    address[] validAddress;   // account addresses which are validated
    address[] signUpAddress;   // account addresses which are already registered
    mapping (address => bool) isAddressStuOrRest;  // true: student, false: restaurant
    
    

    // basic modifier
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    modifier onlyRestAccount(uint _restIndex) {
        require(_restIndex < restNum);
        require(msg.sender == Restaurants[_restIndex].Address);
        _;
    }
    
    modifier onlyStuAccount(uint _stuIndex) {
        require(_stuIndex < stuNum);
        require(msg.sender == Students[_stuIndex].Address);
        _;
    }
    
    
}