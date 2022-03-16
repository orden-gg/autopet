const AavegotchiPetting = artifacts.require("AavegotchiPetting");

const BN = require('bignumber.js');

module.exports = function (deployer) {
  const fee = (new BN(10)).pow(new BN(18)).valueOf();
  deployer.deploy(AavegotchiPetting, fee);
};
