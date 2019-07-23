function validateAddress(){
    var validAddress = document.getElementById("validation").value;
    BCRiders.addValidAddress(validAddress,function(err, result){
        if(!errr) {
            alert("Validation success!!");
        }
    } );
};
