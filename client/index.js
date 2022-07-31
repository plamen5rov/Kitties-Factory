var web3 = new Web3(Web3.givenProvider);

var instance;
var user;
var contractAddress = "0xb115B9d69a27226bA67fC8A1f580dDC1e04c7d69";

$(document).ready(function () {
    window.ethereum.enable().then(function (accounts) {
        instance = new web3.eth.Contract(abi, contractAddress, { from: accounts[0] });
        user = accounts[0];

        //console.log(instance);

        instance.events.Birth().on('data', function (event) {
            console.log(event);
            let owner = event.returnValues.owner;
            let kittenID = event.returnValues.kittenID;
            let mumID = event.returnValues.mumID;
            let dadID = event.returnValues.dadID;
            let genes = event.returnValues.genes;
            $("#kittyCreation").css("display", "block");
            $("#kittyCreation").text("Owner: " + owner
                + " Kitty ID: " + kittenID
                + " Mum ID: " + mumID
                + " Dad ID: " + dadID
                + " Genes: " + genes)
        }).on('error', console.error);
    })
})


function createKitty() {
    var dnaStr = getDna();
    instance.methods.createKittyGen0(dnaStr).send({}, function (err, txHash) {
        if (err) {
            console.log(err);
        } else {
            console.log(txHash);
        }
    });
}



$('#createCatButton').click(() => {
    createKitty(getDna());
})