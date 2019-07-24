

function startApp() {
    contract = web3.eth.contract(contractABI);
    BCRiders = contract.at(contractAddress);
}

function signUpAccount() {
    var a;
    var nickname = document.getElementById("nickname").value;
    var name = document.getElementById("name").value;
    var department = document.getElementById("department").value;

    switch(department){
        case "Mathematics": a = 1;
        break;
        case  "Physics": a = 2;
        break;
        case "Chemistry": a= 3;
        break;
        case "Life Science": a = 4;
        break;
        case "Matrials Science & Engineering": a= 5;
        break;
        case "Mechanical Engineering": a = 6;
        break;
        case "Industrial and Management Engineering": a = 7;
        break;
        case "Electronic and Electric Engineering": a = 8;
        break;
        case "Computer Science and Engineering": a = 9;
        break;
        case "Chemical Engineering": a = 10;
        break;
        case "Creative IT Engineering": a = 11;
        break;
    }
    console.log(nickname, name, department, a);
    BCRiders.requestStuRegister(nickname, name, a, function(err, result) {
        if(result == true) {
            alert("Sign Up success! Hello, "+name+"!!");
        }
        else {
            alert("Failed! already signed up or didn't validated");
        }
    });
}