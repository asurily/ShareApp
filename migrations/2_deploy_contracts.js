var ShareApp = artifacts.require("./ShareApp.sol");

module.exports = function(deployer) {
  deployer.deploy(ShareApp);
};
