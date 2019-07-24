function validateAddress(){
    var validAddress = document.getElementById("validation").value;
    BCRiders.addValidAddress(validAddress,function(err, result){
        if(!err) {
            alert("Validation success!!");
        }
    } );
};
