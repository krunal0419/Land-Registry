module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "5777", // Match any network id
    },
    advanced: {
      websockets: true, // Enable EventEmitter interface for web3 (default: false)
    },
  },
  contracts_build_directory: "./src/contracts/",
  compilers: {
    solc: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
      version: "^0.6.0"
    },
  },
};