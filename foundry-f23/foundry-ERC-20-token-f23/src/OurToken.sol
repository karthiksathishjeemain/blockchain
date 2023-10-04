// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract OurToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("OurToken", "OT") {
        //every inherited contract should have the constructor of the parent contract
        _mint(msg.sender, initialSupply);
    }
}
