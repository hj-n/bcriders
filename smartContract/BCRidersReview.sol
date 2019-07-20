pragma solidity ^0.4.18;

import "./BCRidersOrder.sol";

contract BCRidersReview is BCRidersOrder {
    /* ====================================================================================== */
    // helper storage for review
    
    struct Review {
        uint restIndex;
        uint stuIndex;
        uint restStar;     // star (score) that the review gives to the restaurant (0: 0, 1: 100, 2: 200 ... 5: 500) *100한값 저장
        uint reviewStar;   // average score of the star (score) from other people to review
        uint numReviewStar;   // num of people who evaluated the review
        string title;
        string content;
    }
    
    Review[] Reviews;
    
    // end of helper storage
    /* ====================================================================================== */
    
    
    // helper functions
    
    
    
    
    
    // interface (public functions)
    
    
    
    
    
}