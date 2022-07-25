// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC721.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract KittyContract is IERC721, Ownable {
    string public constant override name = "CryptoKitties";
    string public constant override symbol = "CRK";
    uint256 public constant CREATION_LIMIT_GEN0 = 10;

    event Birth(
        address owner,
        uint256 kittenID,
        uint256 mumID,
        uint256 dadID,
        uint256 genes
    );

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

    uint256 public gen0Counter;

    function getKitty(uint256 _id)
        external
        view
        returns (
            uint256 genes,
            uint256 birthtime,
            uint256 mumID,
            uint256 dadID,
            uint256 generation
        )
    {
        Kitty storage kitty = kitties[_id];

        birthtime = uint256(kitty.birthTime);
        mumID = uint256(kitty.mumID);
        dadID = uint256(kitty.dadID);
        generation = uint256(kitty.generation);
        genes = kitty.genes;
    }

    function createKittyGen0(uint256 _genes)
        public
        onlyOwner
        returns (uint256)
    {
        require(gen0Counter < CREATION_LIMIT_GEN0);

        gen0Counter++;

        //Gen0 have no owners, they are own by the contract
        return _createKitty(0, 0, 0, _genes, msg.sender);
    }

    function _createKitty(
        uint256 _mumID,
        uint256 _dadID,
        uint256 _generation,
        uint256 _genes,
        address _owner
    ) private returns (uint256) {
        Kitty memory _kitty = Kitty({
            genes: _genes,
            birthTime: uint64(block.timestamp),
            mumID: uint32(_mumID),
            dadID: uint32(_dadID),
            generation: uint16(_generation)
        });

        kitties.push(_kitty);

        uint256 newKittenID = kitties.length - 1;

        _transfer(address(0), _owner, newKittenID);

        emit Birth(_owner, newKittenID, _mumID, _dadID, _genes);

        return newKittenID;
    }

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
