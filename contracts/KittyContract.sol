// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC721.sol";

contract KittyContract is IERC721 {
    mapping(address => uint256) ownershipTokenCount;

    function balanceOf(address owner) external view returns (uint256 balance) {
        return ownershipTokenCount[owner];
    }

    function totalSupply() external view returns (uint256 total) {
        return total;
    }

    function name() external view returns (string memory tokenName) {
        return tokenName;
    }

    function symbol() external view returns (string memory tokenSymbol) {
        return tokenSymbol;
    }

    function ownerOf(uint256 tokenId) external view returns (address owner) {
        require(tokenId);
        return owner;
    }

    function transfer(address to, uint256 tokenId) external {}
}
