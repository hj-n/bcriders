    
var BCRiders;

window.addEventListener('load', function() {
    // Checking if Web3 has been injected by the browser (Mist/MetaMask)
    if (typeof web3 !== 'undefined') {
      // Use MetaMask's provider
      web3js = new Web3(web3.currentProvider);
    } else {
        alert("Please install Metamask!!");
    }


       
    var contractABI = [
    {
    "constant": false,
    "inputs": [
    {
        "name": "_address",
        "type": "address"
    }
    ],
    "name": "addValidAddress",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "_restIndex",
        "type": "uint256"
    }
    ],
    "name": "isUntreatedOrderExist",
    "outputs": [
    {
        "name": "",
        "type": "bool"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "_address",
        "type": "address"
    }
    ],
    "name": "getTokenInfo",
    "outputs": [
    {
        "name": "",
        "type": "uint256"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "_stuIndex",
        "type": "uint256"
    }
    ],
    "name": "checkAlarm",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "",
        "type": "address"
    }
    ],
    "name": "findStuIndex",
    "outputs": [
    {
        "name": "",
        "type": "uint16"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [],
    "name": "distributeToken",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "_tokenAmount",
        "type": "uint256"
    },
    {
        "name": "_direction",
        "type": "bool"
    },
    {
        "name": "_restIndex",
        "type": "uint256"
    }
    ],
    "name": "requestExchange",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "_restIndex",
        "type": "uint256"
    }
    ],
    "name": "getLastOrderTimePassed",
    "outputs": [
    {
        "name": "",
        "type": "bool"
    },
    {
        "name": "",
        "type": "uint256"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "R",
        "type": "uint256"
    }
    ],
    "name": "distributeTokenRestaurant",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "_stuIndex",
        "type": "uint256"
    }
    ],
    "name": "getStuOrderList",
    "outputs": [
    {
        "name": "",
        "type": "uint256[]"
    },
    {
        "name": "",
        "type": "uint256"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "_stuIndex",
        "type": "uint256"
    }
    ],
    "name": "isOrderTreated",
    "outputs": [
    {
        "name": "",
        "type": "string"
    },
    {
        "name": "",
        "type": "bool"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "_menuIndex",
        "type": "uint256"
    }
    ],
    "name": "getMenuInfo",
    "outputs": [
    {
        "name": "",
        "type": "string"
    },
    {
        "name": "",
        "type": "uint256"
    },
    {
        "name": "",
        "type": "string"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "_stuIndex",
        "type": "uint256"
    }
    ],
    "name": "isStuOrdered",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [],
    "name": "getRequestExchange",
    "outputs": [
    {
        "name": "",
        "type": "address[]"
    },
    {
        "name": "",
        "type": "uint256[]"
    },
    {
        "name": "",
        "type": "uint256[]"
    },
    {
        "name": "",
        "type": "bool[]"
    },
    {
        "name": "",
        "type": "uint256"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "",
        "type": "address"
    }
    ],
    "name": "findRestIndex",
    "outputs": [
    {
        "name": "",
        "type": "uint16"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [],
    "name": "requestEther",
    "outputs": [
    {
        "name": "",
        "type": "bool"
    }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "_reviewIndex",
        "type": "uint256"
    },
    {
        "name": "_stuIndex",
        "type": "uint256"
    },
    {
        "name": "_reviewStar",
        "type": "uint256"
    }
    ],
    "name": "evaluateReview",
    "outputs": [
    {
        "name": "",
        "type": "bool"
    }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "_explanation",
        "type": "string"
    },
    {
        "name": "_restIndex",
        "type": "uint256"
    }
    ],
    "name": "manageRestExplanation",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "_restIndex",
        "type": "uint256"
    }
    ],
    "name": "getRestInfo",
    "outputs": [
    {
        "name": "",
        "type": "string"
    },
    {
        "name": "",
        "type": "string"
    },
    {
        "name": "",
        "type": "string"
    },
    {
        "name": "",
        "type": "string"
    },
    {
        "name": "",
        "type": "string"
    },
    {
        "name": "",
        "type": "uint256"
    },
    {
        "name": "",
        "type": "uint256"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "_reviewIndex",
        "type": "uint256"
    },
    {
        "name": "_reply",
        "type": "string"
    }
    ],
    "name": "writeReviewReply",
    "outputs": [
    {
        "name": "",
        "type": "bool"
    }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "_restIndex",
        "type": "uint256"
    },
    {
        "name": "_stuIndex",
        "type": "uint256"
    },
    {
        "name": "_recievingAddress",
        "type": "string"
    },
    {
        "name": "_menuIndexList",
        "type": "uint256[]"
    },
    {
        "name": "_menuCountList",
        "type": "uint256[]"
    },
    {
        "name": "_menuNum",
        "type": "uint256"
    },
    {
        "name": "_totalPrice",
        "type": "uint256"
    },
    {
        "name": "_tokenUsed",
        "type": "uint256"
    },
    {
        "name": "_actualPrice",
        "type": "uint256"
    }
    ],
    "name": "orderFood",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "_nickName",
        "type": "string"
    }
    ],
    "name": "isSignedUpUser",
    "outputs": [
    {
        "name": "",
        "type": "bool"
    },
    {
        "name": "",
        "type": "string"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "_restIndex",
        "type": "uint256"
    },
    {
        "name": "_stuIndex",
        "type": "uint256"
    },
    {
        "name": "_restStar",
        "type": "uint256"
    },
    {
        "name": "_title",
        "type": "string"
    },
    {
        "name": "_content",
        "type": "string"
    }
    ],
    "name": "writeReview",
    "outputs": [
    {
        "name": "",
        "type": "bool"
    }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "_stuIndex",
        "type": "uint256"
    }
    ],
    "name": "getStuReviewList",
    "outputs": [
    {
        "name": "",
        "type": "uint256[]"
    },
    {
        "name": "",
        "type": "uint256"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "_category",
        "type": "uint256"
    }
    ],
    "name": "getRestList",
    "outputs": [
    {
        "name": "",
        "type": "uint256[]"
    },
    {
        "name": "",
        "type": "uint256"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "_restName",
        "type": "string"
    },
    {
        "name": "_phoneNumber",
        "type": "string"
    },
    {
        "name": "_physicalAddress",
        "type": "string"
    },
    {
        "name": "_category",
        "type": "uint256"
    },
    {
        "name": "_restIndex",
        "type": "uint256"
    }
    ],
    "name": "manageRestInfo",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "_orderIndex",
        "type": "uint256"
    }
    ],
    "name": "getOrderInfo",
    "outputs": [
    {
        "name": "",
        "type": "uint256"
    },
    {
        "name": "",
        "type": "uint256"
    },
    {
        "name": "",
        "type": "string"
    },
    {
        "name": "",
        "type": "string"
    },
    {
        "name": "",
        "type": "uint256[]"
    },
    {
        "name": "",
        "type": "uint256[]"
    },
    {
        "name": "",
        "type": "uint256"
    },
    {
        "name": "",
        "type": "uint256"
    },
    {
        "name": "",
        "type": "uint256"
    },
    {
        "name": "",
        "type": "uint256"
    },
    {
        "name": "",
        "type": "uint256"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "_orderIndex",
        "type": "uint256"
    },
    {
        "name": "_isAccept",
        "type": "bool"
    }
    ],
    "name": "confirmOrder",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "_reviewIndex",
        "type": "uint256"
    }
    ],
    "name": "getReviewInfo",
    "outputs": [
    {
        "name": "",
        "type": "uint256"
    },
    {
        "name": "",
        "type": "uint256"
    },
    {
        "name": "",
        "type": "uint256"
    },
    {
        "name": "",
        "type": "uint256"
    },
    {
        "name": "",
        "type": "string"
    },
    {
        "name": "",
        "type": "string"
    },
    {
        "name": "",
        "type": "string"
    },
    {
        "name": "",
        "type": "bool"
    },
    {
        "name": "",
        "type": "uint256"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "_restIndex",
        "type": "uint256"
    }
    ],
    "name": "getRestOrderList",
    "outputs": [
    {
        "name": "",
        "type": "uint256[]"
    },
    {
        "name": "",
        "type": "uint256"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "_name",
        "type": "string"
    },
    {
        "name": "_price",
        "type": "uint256"
    },
    {
        "name": "_explanation",
        "type": "string"
    },
    {
        "name": "_restIndex",
        "type": "uint256"
    }
    ],
    "name": "addNewMenu",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "_restIndex",
        "type": "uint256"
    }
    ],
    "name": "getRestMenuList",
    "outputs": [
    {
        "name": "",
        "type": "uint256[]"
    },
    {
        "name": "",
        "type": "uint256"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "_nickName",
        "type": "string"
    },
    {
        "name": "_restName",
        "type": "string"
    },
    {
        "name": "_phoneNumber",
        "type": "string"
    },
    {
        "name": "_physicalAddress",
        "type": "string"
    },
    {
        "name": "_category",
        "type": "uint256"
    },
    {
        "name": "_tokenPromise",
        "type": "uint256"
    }
    ],
    "name": "requestRestRegister",
    "outputs": [
    {
        "name": "",
        "type": "bool"
    }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "_nickName",
        "type": "string"
    },
    {
        "name": "_name",
        "type": "string"
    },
    {
        "name": "_department",
        "type": "uint8"
    }
    ],
    "name": "requestStuRegister",
    "outputs": [
    {
        "name": "",
        "type": "bool"
    }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": true,
    "inputs": [
    {
        "name": "_restIndex",
        "type": "uint256"
    }
    ],
    "name": "getRestReviewList",
    "outputs": [
    {
        "name": "",
        "type": "uint256[]"
    },
    {
        "name": "",
        "type": "uint256"
    }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "_tokenPromise",
        "type": "uint256"
    },
    {
        "name": "_restIndex",
        "type": "uint256"
    }
    ],
    "name": "manageRestPromise",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "_restIndex",
        "type": "uint256"
    }
    ],
    "name": "validateExchange",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "constant": false,
    "inputs": [
    {
        "name": "S",
        "type": "uint256"
    }
    ],
    "name": "distributeTokenStudent",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
    },
    {
    "inputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "constructor"
    }
    ];
    var contractAddress = "0xa4fcc41e250e7e268bc2f0383d2c5dc276653966";
    var BCR = web3.eth.contract(contractABI);
    BCRiders = BCR.at(contractAddress);
})    
 