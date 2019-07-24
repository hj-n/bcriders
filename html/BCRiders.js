window.addEventListener('load', async () => {
    // Modern dapp browsers...
    if (window.ethereum) {
        window.web3 = new Web3(ethereum);
        try {
            // Request account access if needed
            await ethereum.enable();

            // Acccounts now exposed
            console.log("MetaMask Interface 1");

            ethereum
            .send('eth_accounts')
            .then(accounts => {
                console.log(accounts);
            })

            startApp();

        } catch (error) {
            // User denied account access…
        }
    }
    // Legacy dapp browsers…
    else if (window.web3) {
        window.web3 = new Web3(web3.currentProvider);
        // Acccounts always exposed
        console.log("MetaMask Interface 2");
        console.log(web3);
    }
    // Non-dapp browsers…
    else {
        console.log('Non-Ethereum browser detected. You should consider trying MetaMask!');
    }
});