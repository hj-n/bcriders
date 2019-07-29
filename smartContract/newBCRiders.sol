pragma solidity ^0.4.18;

contract newBCRiders {
    struct User {
        bool isStudent;    // if Restaurant, false
        uint nickname;    // for optimization, used uint rather than string
        string name;
        uint depart_category;  // department or category
        uint tokenPromise;    // 0 for student
        uint token;
        uint index;
    }
    
    User[] public Users;
    mapping (address => uint) public userIndex;
    
    struct Menu {
        string menuName;
        uint restIndex;
        uint menuPrice;
        string explanation;
    }
    
    Menu[] public Menus;
    
    struct Order {
        uint restIndex;
        uint stuIndex;
        string receiveAddress;
        uint tokenUsed;
        uint actualPrice;
    }
    
    Order[] public Orders;
    
    struct Review {
        uint restIndex;
        uint stuIndex;
        string title;
        string content;
        string reply;
        bool isReply;
        uint index;
    }
    
    Review[] public Reviews;
    
    struct Exchange {
        uint userIndex;
        uint amount;
        bool isUserToOwner;  // true: token from user to owner
        bool isConfirmed;     
        uint index;
        string userName;
    }

    Exchange[] public Exchanges;
    
    function signUp(bool _isStudent, uint _nickname, string _name, uint _depart_category, uint _tokenPromise) public {
        userIndex[msg.sender] = Users.length;
        uint token = 15000;
        if(_isStudent) token = 3000;
        uint _index = Users.length;
        Users.push(User(_isStudent, _nickname, _name, _depart_category, _tokenPromise, token, _index));
    }
    
    
    function signIn(uint _nickname) public view returns (bool, bool) {   // first is for login success, second one for isStudent
        if(Users[userIndex[msg.sender]].nickname == _nickname) {
            return (true, Users[userIndex[msg.sender]].isStudent);
        }
        else {
            return (false, false);
        }
    }
    
    function isStuOrRest() public view returns (bool) { // true if student
        return Users[userIndex[msg.sender]].isStudent;
    }
    
    function getRestIndex(uint _category) public view returns (uint[], uint[], uint) {
        uint[] memory restList = new uint[](Users.length);
        uint[] memory restPromiseList = new uint[](Users.length);
        uint num = 0;
        for(uint i = 0; i < Users.length; i++) {
            if(!Users[i].isStudent) {
                if(_category != 0) {
                    if(_category == Users[i].depart_category) {
                        restList[num] = i;
                        restPromiseList[num] = Users[i].tokenPromise;
                        num++;
                    }
                }
                else {
                    restList[num] = i;
                    restPromiseList[num] = Users[i].tokenPromise;
                    num++;
                }
            }
        }
        return (restList, restPromiseList, num);
    }
    
    function addMenu(string _menuName, uint _menuPrice, string _explanation) public {
        Menus.push(Menu(_menuName, userIndex[msg.sender], _menuPrice, _explanation));
    }
    
    function getMenuIndex(uint _restIndex) public view returns (uint[], uint) {
        uint[] memory menuList = new uint[](Menus.length);
        uint num = 0;
        for(uint i = 0; i < Menus.length; i++) {
            if(Menus[i].restIndex == _restIndex) {
                menuList[num] = i;
                num++;
            }
        }
        return (menuList, num);
    }
    
    function orderFood(uint _restIndex, string _receiveAddress, uint _tokenUsed, uint _actualPrice) public {
        Orders.push(Order(_restIndex, userIndex[msg.sender], _receiveAddress, _tokenUsed, _actualPrice));
        Users[userIndex[msg.sender]].token -= _tokenUsed;
        Users[_restIndex].token += _tokenUsed;
    }
    
    function getOrderIndex(uint _userIndex) public view returns (uint[], uint) {
        uint[] memory orderList = new uint[](Orders.length);
        uint num = 0;
        if(Users[_userIndex].isStudent) {
            for(uint i = 0; i < Orders.length; i++) {
                if(Orders[i].stuIndex == _userIndex) {
                    orderList[num] = i;
                    num++;
                }
            }
        }
        else {
            for(i = 0; i < Orders.length; i++) {
                if(Orders[i].restIndex == _userIndex) {
                    orderList[num] = i;
                    num++;
                }
            }
        }
        return (orderList, num);
    }
    
    function writeReview(uint _restIndex, string _title, string _content) public {
        uint _index = Reviews.length;
        Reviews.push(Review(_restIndex, userIndex[msg.sender], _title, _content, "", false, _index));
    }
    
    function getReviewIndex(uint _userIndex) public view returns (uint[], uint) {
        uint[] memory reviewList = new uint[](Reviews.length);
        uint num = 0;
        if(Users[_userIndex].isStudent) {
            for(uint i = 0; i < Reviews.length; i++) {
                if(Reviews[i].stuIndex == _userIndex) {
                    reviewList[num] = i;
                    num++;
                }
            }
        }
        else {
            for(i = 0; i < Reviews.length; i++) {
                if(Reviews[i].restIndex == _userIndex) {
                    reviewList[num] = i;
                    num++;
                }
            }
        }
        return (reviewList, num);
    }
    
    function writeReply(uint _reviewIndex, string _reply) public {
        Reviews[_reviewIndex].reply = _reply;
        Reviews[_reviewIndex].isReply = true;
    }
    
    function reqExchange(uint _amount, bool _isUserToOwner) public {
        var _index = Exchanges.length;
        Exchanges.push(Exchange(userIndex[msg.sender], _amount, _isUserToOwner, false, _index, Users[userIndex[msg.sender]].name));
    }
    
    function getExchangeIndex() public view returns (uint[], uint) {
        uint[] memory exchangeList = new uint[](Exchanges.length);
        uint num = 0;
        for(uint i = 0; i < Exchanges.length; i++) {
            if(!Exchanges[i].isConfirmed) {
                exchangeList[num] = i;
                num++;
            }
        }
        return (exchangeList, num);
    }
    
    function confirmExchange(uint _exchangeIndex) public {
        Exchange storage e = Exchanges[_exchangeIndex];
        Exchanges[_exchangeIndex].isConfirmed = true;
        if(e.isUserToOwner) {
            Users[e.userIndex].token -= e.amount;
        }
        else {
            Users[e.userIndex].token += e.amount;
        }
    }
    
    function distributeToken() public {
        uint tokenSum = 0;
        for(uint i = 0; i < Users.length; i++){
            if(!Users[i].isStudent) {
                tokenSum += Users[i].tokenPromise;
                Users[i].token -= Users[i].tokenPromise;
            }
        }
        uint tokenDistributed = tokenSum / Users.length;
        for(i = 0; i < Users.length; i++) {
            Users[i].token += tokenDistributed;
        }
    }
    
    function changeTokenPromise(uint _tokenPromise) public {
        Users[userIndex[msg.sender]].tokenPromise = _tokenPromise;
    }
    
    
    
    
    
    
}