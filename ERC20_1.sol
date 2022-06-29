// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract USDC is ERC20{
    constructor() ERC20("CDK","USDC_token"){
        _mint(msg.sender,5000 * 10 **9);

    }
}

