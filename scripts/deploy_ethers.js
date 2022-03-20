// Right click on the script name and hit "Run" to execute
(async () => {
    try {
        console.log('Running deployWithEthers script...')
    
        const contractName = 'OnlineMenu' // Change this for other contract
        const constructorArgs = []    // Put constructor args (if any) here for your contract

        // Note that the script needs the ABI which is generated from the compilation artifact.
        // Make sure contract is compiled and artifacts are generated
        const artifactsPath = `browser/contracts/artifacts/${contractName}.json` // Change this for different path
    
        const metadata = JSON.parse(await remix.call('fileManager', 'getFile', artifactsPath))
        const provider = new ethers.providers.Web3Provider(web3Provider)
        // 'web3Provider' is a remix global variable object
        const signer = provider.getSigner()
    
        let factory = new ethers.ContractFactory(metadata.abi, metadata.data.bytecode.object, signer);
    
        let contract = await factory.deploy(...constructorArgs);
    
        console.log('Contract Address: ', contract.address);
    
        // The contract is NOT deployed yet; we must wait until it is mined
        await contract.deployed()
        // await contract.getResatuarant(0)
        console.log('Deployment successful.')

        const dat = await contract.createRestaurant("Dragon",["","","",""],982313213)
        console.log(dat)
        // await contract.markInactive(0)
        console.log(await contract.getRestaurant(0))
        await contract.createNewUser("Atharva","","adrooney@gmail.com",0)
        console.log(await contract.getUserDetails(0))
        // await contract.updateRestaurant(0,'',['','resrt','fas',''],0)
        // console.log(await contract.getRestaurant(0))
        // await contract.markActive(0)
        // console.log(await contract.getRestaurant(0))
    } catch (e) {
        console.log(e)
        console.log(e.message)
    }
})()