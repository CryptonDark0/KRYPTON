// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import OpenZeppelin's secure contracts
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/**
 * @title KryptonToken
 * @dev A secure and professional ERC20 token implementation for the Krypton project.
 */
contract KryptonToken is ERC20, Ownable, ReentrancyGuard {
    // Event to log token transfers
    event TokensTransferred(address indexed from, address indexed to, uint256 amount);

    // Event to log token minting
    event TokensMinted(address indexed to, uint256 amount);

    // Event to log token burning
    event TokensBurned(address indexed from, uint256 amount);

    /**
     * @dev Constructor to initialize the token.
     * @param initialSupply The initial supply of tokens to mint.
     */
    constructor(uint256 initialSupply) ERC20("Krypton Token", "KRY") {
        _mint(msg.sender, initialSupply * 10 ** decimals()); // Mint initial supply to the deployer
    }

    /**
     * @dev Mint new tokens. Only the owner can call this function.
     * @param to The address to mint tokens to.
     * @param amount The amount of tokens to mint.
     */
    function mint(address to, uint256 amount) external onlyOwner nonReentrant {
        require(to != address(0), "Invalid address");
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    /**
     * @dev Burn tokens. Only the owner can call this function.
     * @param amount The amount of tokens to burn.
     */
    function burn(uint256 amount) external onlyOwner nonReentrant {
        _burn(msg.sender, amount);
        emit TokensBurned(msg.sender, amount);
    }

    /**
     * @dev Transfer tokens from the caller to another address.
     * @param to The address to transfer tokens to.
     * @param amount The amount of tokens to transfer.
     */
    function transfer(address to, uint256 amount) public override nonReentrant returns (bool) {
        require(to != address(0), "Invalid address");
        require(amount > 0, "Amount must be greater than 0");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");

        _transfer(msg.sender, to, amount);
        emit TokensTransferred(msg.sender, to, amount);
        return true;
    }

    /**
     * @dev Transfer tokens on behalf of another address (requires allowance).
     * @param from The address to transfer tokens from.
     * @param to The address to transfer tokens to.
     * @param amount The amount of tokens to transfer.
     */
    function transferFrom(address from, address to, uint256 amount) public override nonReentrant returns (bool) {
        require(from != address(0), "Invalid address");
        require(to != address(0), "Invalid address");
        require(amount > 0, "Amount must be greater than 0");
        require(balanceOf(from) >= amount, "Insufficient balance");
        require(allowance(from, msg.sender) >= amount, "Allowance exceeded");

        _transfer(from, to, amount);
        _approve(from, msg.sender, allowance(from, msg.sender) - amount);
        emit TokensTransferred(from, to, amount);
        return true;
    }
}
