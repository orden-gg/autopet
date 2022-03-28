require('dotenv').config();

const AavegotchiPetting = artifacts.require("AavegotchiPetting");

const BN = require('bignumber.js');
const stkFee = process.env['STAKING_FEE'];

module.exports = function (deployer) {
  const fee = (new BN(10)).pow(new BN(18)).multipliedBy(stkFee).valueOf();
  deployer.deploy(AavegotchiPetting, fee);
};
