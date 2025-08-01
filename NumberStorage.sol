// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract NumberStorage {
    // Contract owner address
    address public owner;
    
    // Mapping for authorized addresses
    mapping(address => bool) public authorizedAddresses;
    
    // Array to track all authorized addresses
    address[] public authorizedAddressList;
    
    // Structure to store user data
    struct UserData {
        uint256[] numbers;
        uint256 timestamp;
        bool exists;
    }
    
    // Mapping to associate each address with its data
    mapping(address => UserStorage[]) private userStorages;
    
    // Structure for each submission
    struct UserStorage {
        uint256[] numbers;
        uint256 timestamp;
    }
    
    // Events
    event NumbersStored(address indexed user, uint256[] numbers, uint256 timestamp);
    event NumbersRetrieved(address indexed user, uint256[] numbers);
    event AddressAuthorized(address indexed user, address indexed authorizedBy);
    event AddressRevoked(address indexed user, address indexed revokedBy);
    
    // Modifier to verify that the caller is authorized
    modifier onlyAuthorized() {
        require(authorizedAddresses[msg.sender], "Address not authorized to send numbers");
        _;
    }
    
    // Modifier for owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    // Constructor - sets creator as owner and authorizes them automatically
    constructor(address[] memory _initialAuthorizedAddresses) {
        owner = msg.sender;
        
        // Authorize owner automatically
        authorizedAddresses[owner] = true;
        authorizedAddressList.push(owner);
        
        // Authorize initial addresses provided
        for (uint256 i = 0; i < _initialAuthorizedAddresses.length; i++) {
            address addr = _initialAuthorizedAddresses[i];
            require(addr != address(0), "Zero address not allowed");
            
            // Avoid duplicates (especially if owner address is in the list)
            if (!authorizedAddresses[addr]) {
                authorizedAddresses[addr] = true;
                authorizedAddressList.push(addr);
                emit AddressAuthorized(addr, owner);
            }
        }
    }
    
    // Function to authorize a new address (owner only)
    function authorizeAddress(address _user) public onlyOwner {
        require(_user != address(0), "Zero address not allowed");
        require(!authorizedAddresses[_user], "Address already authorized");
        
        authorizedAddresses[_user] = true;
        authorizedAddressList.push(_user);
        emit AddressAuthorized(_user, msg.sender);
    }
    
    // Function to revoke address authorization (owner only)
    function revokeAddress(address _user) public onlyOwner {
        require(_user != owner, "Cannot revoke owner");
        require(authorizedAddresses[_user], "Address not authorized");
        
        authorizedAddresses[_user] = false;
        
        // Remove from list (find and delete)
        for (uint256 i = 0; i < authorizedAddressList.length; i++) {
            if (authorizedAddressList[i] == _user) {
                authorizedAddressList[i] = authorizedAddressList[authorizedAddressList.length - 1];
                authorizedAddressList.pop();
                break;
            }
        }
        
        emit AddressRevoked(_user, msg.sender);
    }
    
    // Function to get all authorized addresses
    function getAuthorizedAddresses() public view returns (address[] memory) {
        return authorizedAddressList;
    }
    
    // Function to check if an address is authorized
    function isAddressAuthorized(address _user) public view returns (bool) {
        return authorizedAddresses[_user];
    }
    
    // Function to get the number of authorized addresses
    function getAuthorizedAddressCount() public view returns (uint256) {
        return authorizedAddressList.length;
    }
    
    // Function to send an array of numbers (authorized addresses only)
    function storeNumbers(uint256[] memory _numbers) public onlyAuthorized {
        require(_numbers.length > 0, "Array cannot be empty");
        require(_numbers.length <= 100, "Maximum 100 numbers allowed");
        
        // Create new storage entry
        UserStorage memory newStorage = UserStorage({
            numbers: _numbers,
            timestamp: block.timestamp
        });
        
        // Add to user history
        userStorages[msg.sender].push(newStorage);
        
        // Emit event
        emit NumbersStored(msg.sender, _numbers, block.timestamp);
    }
    
    // Function to retrieve the last array sent by a user
    function getLatestNumbers(address _user) public view returns (uint256[] memory, uint256) {
        require(userStorages[_user].length > 0, "No numbers stored for this user");
        
        UserStorage memory latestStorage = userStorages[_user][userStorages[_user].length - 1];
        return (latestStorage.numbers, latestStorage.timestamp);
    }
    
    // Function to retrieve all arrays sent by a user
    function getAllUserNumbers(address _user) public view returns (UserStorage[] memory) {
        return userStorages[_user];
    }
    
    // Function to retrieve the number of submissions by a user
    function getUserSubmissionCount(address _user) public view returns (uint256) {
        return userStorages[_user].length;
    }
    
    // Function to retrieve a specific array by index
    function getNumbersByIndex(address _user, uint256 _index) public view returns (uint256[] memory, uint256) {
        require(_index < userStorages[_user].length, "Invalid index");
        
        UserStorage memory storage_data = userStorages[_user][_index];
        return (storage_data.numbers, storage_data.timestamp);
    }
} 