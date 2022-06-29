
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "https://github.com/Uniswap/v2-periphery/blob/master/contracts/interfaces/IUniswapV2Router02.sol";
import "https://github.com/Uniswap/v2-core/blob/master/contracts/interfaces/IUniswapV2Factory.sol";
import "hardhat/console.sol";

contract AddLiquidity {
  address private constant FACTORY = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
  address private constant ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
  address public constant WETH = 0xc778417E063141139Fce010982780140Aa0cD5Ab;
  event ALE(uint,uint,uint);
  event RLE(uint,uint);


  function AddLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin
    ) external payable {
    IERC20(token).transferFrom(msg.sender,address(this),amountTokenDesired);
    IERC20(token).approve(ROUTER, amountTokenDesired);

    (uint amountToken, uint amountETH, uint liquidity)=IUniswapV2Router02(ROUTER).addLiquidityETH{value: address(this).balance}(token,amountTokenDesired,amountTokenMin,amountTokenMin,address(this),block.timestamp); 
    emit ALE(amountToken,amountETH,liquidity);
  } 

  receive() external payable {
        // assert(msg.sender == WETH); // only accept ETH via fallback from the WETH contract
  }

  function removeLiquidityWithETH(address token,address to,uint deadline)external payable{
        address pair = IUniswapV2Factory(FACTORY).getPair(token, WETH);

      uint liquidity= IERC20(pair).balanceOf(address(this));
      IERC20(pair).approve(ROUTER, liquidity);

      (uint amountA, uint amountB) =
        IUniswapV2Router02(ROUTER).removeLiquidityETH(
          token,
          liquidity,
          1,
          1,
          address(this),
          block.timestamp
        );
      emit RLE(amountA,amountB);
  }

  function d() public view  returns(uint){
    return address(this).balance;
    // emit e (address(this).balance);
  }
  
  fallback() external payable{

  }
  function f() public payable{

  }
}

