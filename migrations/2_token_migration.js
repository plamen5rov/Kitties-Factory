const KittyContract = artifacts.require("KittyContract");

module.exports = function (deployer) {
  deployer.deploy(KittyContract);
};
