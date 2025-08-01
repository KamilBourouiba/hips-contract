# HIPS Protocol Smart Contract

[![Solidity](https://img.shields.io/badge/Solidity-0.8.19-blue.svg)](https://soliditylang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> **Hidden In Plain Sight** - Revolutionary encryption protocol that hides sensitive data in plain sight using dictionary-based indexing and blockchain technology.

## 📋 Overview

The HIPS Protocol Smart Contract is the core blockchain component of the HIPS (Hidden In Plain Sight) ecosystem. It enables secure, encrypted messaging by storing arrays of numerical indices that reference words in a shared dictionary, creating a unique form of "dictionary-based encryption."

### 🔐 How It Works

1. **Message Encoding**: Text messages are converted to arrays of numbers (indices) that reference words in a shared dictionary
2. **Blockchain Storage**: These arrays are stored on-chain as "encrypted" data
3. **Access Control**: Only authorized addresses can send messages
4. **Message History**: Complete conversation history is maintained with timestamps
5. **Decryption**: Recipients decode messages using the same shared dictionary

## 🚀 Features

- **🔑 Access Control**: Owner-managed authorization system
- **📝 Message Storage**: Complete message history with timestamps
- **⚡ Gas Optimized**: Efficient storage patterns and array limits
- **🔍 Transparency**: Event emission for all operations
- **🛡️ Security**: Comprehensive input validation and error handling
- **📊 Analytics**: Functions to retrieve message counts and user statistics

## 📦 Installation

### Prerequisites

- Node.js (v14 or higher)
- npm or yarn
- Hardhat development environment

### Setup

```bash
# Clone the repository
git clone https://github.com/KamilBourouiba/hips-contract.git
cd hips-contract

# Install dependencies (if using Hardhat)
npm install

# Compile the contract
npx hardhat compile
```

## 🏗️ Contract Architecture

### Core Components

- **NumberStorage.sol**: Main contract implementing the HIPS protocol
- **Access Control**: Owner and authorized address management
- **Message Storage**: User message history with timestamps
- **Event System**: Comprehensive event emission for transparency

### Key Functions

#### Access Control
- `authorizeAddress(address _user)`: Add new authorized address
- `revokeAddress(address _user)`: Remove address authorization
- `getAuthorizedAddresses()`: List all authorized addresses
- `isAddressAuthorized(address _user)`: Check authorization status

#### Message Operations
- `storeNumbers(uint256[] memory _numbers)`: Send encoded message
- `getLatestNumbers(address _user)`: Get most recent message
- `getAllUserNumbers(address _user)`: Get complete message history
- `getUserSubmissionCount(address _user)`: Get message count
- `getNumbersByIndex(address _user, uint256 _index)`: Get specific message

## 🔧 Deployment

### Base Network (Recommended)

```javascript
// Deploy with initial authorized addresses
const initialAddresses = [
    "0x2E23BCAa5eF38F0d18822C6aC348edFbC70F6a38",
    "0x251C077E254aA3e4efA862755A88A1DaB3Ca26B3"
];

const NumberStorage = await ethers.getContractFactory("NumberStorage");
const contract = await NumberStorage.deploy(initialAddresses);
await contract.deployed();

console.log("HIPS Contract deployed to:", contract.address);
```

### Constructor Parameters

- `_initialAuthorizedAddresses`: Array of addresses to authorize initially
- The deployer automatically becomes the owner and is authorized

## 📊 Usage Examples

### JavaScript/Web3.js

```javascript
// Connect to contract
const contract = new web3.eth.Contract(ABI, CONTRACT_ADDRESS);

// Send encoded message
const messageIndices = [1, 5, 12, 8, 3]; // Example indices
await contract.methods.storeNumbers(messageIndices).send({from: userAddress});

// Get latest message
const [numbers, timestamp] = await contract.methods.getLatestNumbers(userAddress).call();

// Get all messages
const allMessages = await contract.methods.getAllUserNumbers(userAddress).call();
```

### Python/Web3.py

```python
from web3 import Web3

# Connect to contract
contract = w3.eth.contract(address=contract_address, abi=contract_abi)

# Send message
message_indices = [1, 5, 12, 8, 3]
tx_hash = contract.functions.storeNumbers(message_indices).transact({'from': user_address})

# Get message history
messages = contract.functions.getAllUserNumbers(user_address).call()
```

## 🔗 Integration

### Frontend Integration

The contract is designed to work seamlessly with the [HIPS Chat Application](https://github.com/kamilbourouiba/hips-chat) and other frontend implementations.

### Supported Networks

- **Base Mainnet**: Primary deployment
- **Base Sepolia**: Testnet
- **Ethereum**: Compatible
- **Polygon**: Compatible

## 🧪 Testing

```bash
# Run tests
npx hardhat test

# Run with coverage
npx hardhat coverage
```

## 📚 Documentation

- [Contract ABI](./artifacts/contracts/NumberStorage.sol/NumberStorage.json)
- [Deployment Guide](./docs/DEPLOYMENT.md)
- [API Reference](./docs/API.md)
- [Security Considerations](./docs/SECURITY.md)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Kamil Bourouiba**
- GitHub: [@KamilBourouiba](https://github.com/KamilBourouiba)
- Project: [HIPS Protocol](https://github.com/kamilbourouiba/hips-contract)

## 🙏 Acknowledgments

- Base Network for L2 scaling
- Ethereum Foundation for blockchain infrastructure
- OpenZeppelin for security best practices

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/KamilBourouiba/hips-contract/issues)
- **Discussions**: [GitHub Discussions](https://github.com/KamilBourouiba/hips-contract/discussions)
- **Documentation**: [Wiki](https://github.com/KamilBourouiba/hips-contract/wiki)

---

**HIPS Protocol** - *Hidden In Plain Sight* 🔐✨ 