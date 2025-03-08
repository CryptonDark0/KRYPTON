const KryptonToken = artifacts.require("KryptonToken");

module.exports = function (deployer) {
  deployer.deploy(KryptonToken);
};
