const Token = artifacts.require("KittyMarketplace");

module.exports = function (deployer) {
  deployer.deploy(Token);
};
