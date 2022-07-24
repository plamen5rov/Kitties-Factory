// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC721.sol";

contract KittyContract is IERC721 {
    string public constant override name = "CryptoKitties";
    string public constant override symbol = "CRK";

    struct Kitty {
        uint256 genes;
        uint64 birthTime;
        uint32 mumID;
        uint32 dadID;
        uint16 generation;
    }

    Kitty[] kitties;

    mapping(uint256 => address) public kittyIndexToOwner;
    mapping(address => uint256) ownershipTokenCount;

    function balanceOf(address owner)
        external
        view
        override
        returns (uint256 balance)
    {
        return ownershipTokenCount[owner];
    }

    function totalSupply() external view override returns (uint256 total) {
        return kitties.length;
    }

    // function name() external view returns (string memory tokenName) {
    //     return name;
    // }

    // function symbol() external view returns (string memory tokenSymbol) {
    //     return symbol;
    // }

    function ownerOf(uint256 _tokenId)
        external
        view
        override
        returns (address owner)
    {
        //require(kittyIndexToOwner[_tokenId], "Token does not exist!");
        return kittyIndexToOwner[_tokenId];
    }

    function transfer(address _to, uint256 _tokenId) external override {
        require(_to != address(0));
        require(_to != address(this));
        require(_owns(msg.sender, _tokenId));

        _transfer(msg.sender, _to, _tokenId);
    }

    function _transfer(
        address _from,
        address _to,
        uint256 _tokenId
    ) internal {
        ownershipTokenCount[_to]++;

        kittyIndexToOwner[_tokenId] = _to;

        //Decrease owner's kitty balance - unless it's a newly minted kitty
        if (_from != address(0)) {
            ownershipTokenCount[_from]--;
        }

        emit Transfer(_from, _to, _tokenId);
    }

    function _owns(address _claimant, uint256 _tokenId)
        internal
        view
        returns (bool)
    {
        return kittyIndexToOwner[_tokenId] == _claimant;
    }
}
