//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ClassTokenSale is Ownable {
        address public tokenAddress;
        uint public tokenPrice; // 1eth = 100 CLT

        constructor(address _address, uint _tokenPrice) {
               tokenAddress = _address;
               tokenPrice = _tokenPrice;
        }

        function buy() public payable {
                require(msg.value > 0,"must supply eth");

                uint amount = msg.value * tokenPrice;
                require(IERC20(tokenAddress).balanceOf(address(this)) >= amount,"insufficient token");
                IERC20(tokenAddress).transfer(msg.sender, amount);
        }

        function withdrawAll() public 
                onlyOwner{
                payable(msg.sender).transfer(address(this).balance);
                uint amount = IERC20(tokenAddress).balanceOf(address(this));
                IERC20(tokenAddress).transfer(msg.sender, amount);
        }
}
