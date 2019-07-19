pragma solidity ^0.4.18;

contract BCRidersStorage {
    
    /* ========================================================================================================================*/
    /* ========================================================================================================================*/
    // START of storages
    
    // basic
    address owner;
    
    /* ====================================================================================== */
    // token info
    struct Token {     // Riders Token info
        uint totalTokenInNetwork;     // total token inside network (Amount of token hold by users)
        uint totalTokenPublished;      // total token which is published since the network begin
        mapping (address => uint) stuAddressToToken;
        mapping (address => uint) restAddressToToken;   // store information about token balance
    }
    
    Token RidersToken;  // This will hold the information about token
    
    // end of token info
    /* ====================================================================================== */
    
    
    // struct of important storages: student and restaurant
    struct Student {
        string nickName;
        string name;    // Real name
        uint8 department;  // See above "Department matching" btw integer and department
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
    mapping (uint16 => Student)  Students;    // validated student users
    mapping (address => uint16) findStuIndex;    // To find index of Students array from address
    uint16 stuNum;
    
    Restaurant[] restCandidates;   // Same for restaurants
    mapping (uint16 => Restaurant) Restaurants;
    mapping (address => uint16) findRestIndex; 
    uint16 restNum;
    
    address[] validAddress;   // account addresses which are validated
    address[] signUpAddress;   // account addresses which are already registered
    
    
    
    // END of storages
    /* ========================================================================================================================*/
    /* ========================================================================================================================*/
    
    

}