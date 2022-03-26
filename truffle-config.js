require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');

const MainProvider = new HDWalletProvider({
  privateKeys: [process.env['MAIN_NET_PRIVATE_KEY']],
  providerOrUrl: 'https://polygon-rpc.com',
});

module.exports = {
  api_keys: {
    etherscan: ''
  },
  plugins: [
    'truffle-plugin-verify'
  ],
  mocha: {
    timeout: 100000
  },
  compilers: {
    solc: {
      version: '0.8.13',
      settings: {
        optimizer: {
          enabled: true,
          runs: 9999
        }
      }
    },
  },
  networks: {
    development: {
      host: 'localhost',
      port: 7545,
      network_id: "*"
    },
    live: {
      gas: 7900000,
      provider: MainProvider,
      from: MainProvider.address,
      network_id: 137
    }
  }
};
