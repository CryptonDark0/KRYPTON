// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KryptonToken {
    string public name = "Krypton Token";
    string public symbol = "KRY";
    uint256 public totalSupply = 1000000;

    mapping(address => uint256) public balances;

    constructor() {
        balances[msg.sender] = totalSupply;
    }

    function transfer(address to, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}
