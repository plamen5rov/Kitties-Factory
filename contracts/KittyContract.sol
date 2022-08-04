// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC721.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "./IERC721Receiver.sol";

contract KittyContract is IERC721, Ownable {
    string public constant override name = "CryptoKitties";
    string public constant override symbol = "CRK";
    uint256 public constant CREATION_LIMIT_GEN0 = 10;
    bytes4 private constant MAGIC_ERC721_RECIEVED =
        bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));

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
    mapping(uint256 => address) public kittyIndexToApproved;

    mapping(address => mapping(address => bool)) private _operatorApprovals;

    uint256 public gen0Counter;

    function approve(address _to, uint256 _tokenId) external override {
        require(_owns(msg.sender, _tokenId));

        _approve(_tokenId, _to);
        emit Approval(msg.sender, _to, _tokenId);
    }

    function setApprovalForAll(address operator, bool approved)
        public
        override
    {
        require(operator != msg.sender);

        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function getApproved(uint256 tokenId)
        public
        view
        override
        returns (address)
    {
        require(tokenId < kitties.length); //Token must exists

        return kittyIndexToApproved[tokenId];
    }

    function isApprovedForAll(address owner, address operator)
        public
        view
        override
        returns (bool)
    {
        return _operatorApprovals[owner][operator];
    }

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
            delete kittyIndexToApproved[_tokenId];
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

    function _approve(uint256 _tokenId, address _approved) internal {
        kittyIndexToApproved[_tokenId] = _approved;
    }

    function _approvedFor(address _claimant, uint256 _tokenId)
        internal
        view
        returns (bool)
    {
        kittyIndexToApproved[_tokenId] == _claimant;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external override {
        require(_isApprovedOrOwner(msg.sender, _from, _to, _tokenId));

        _transfer(_from, _to, _tokenId);
    }

    function _safeTransfer(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes memory _data
    ) internal {
        require(
            _checkERC721Support(_from, _to, _tokenId, _data),
            "ERC721 NOT supported!"
        );

        _transfer(_from, _to, _tokenId);
    }

    function _checkERC721Support(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes memory _data
    ) internal returns (bool) {
        if (!_isContract(_to)) {
            return true;
        }

        bytes4 returnData = IERC721Receiver(_to).onERC721Received(
            msg.sender,
            _from,
            _tokenId,
            _data
        );

        return returnData == MAGIC_ERC721_RECIEVED;
    }

    function _isContract(address _to) internal view returns (bool) {
        uint32 size;
        assembly {
            size := extcodesize(_to)
        }
        return size > 0;
    }

    //safeTransferFrom without data
    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) public override {
        safeTransferFrom(_from, _to, _tokenId, "");
    }

    //safeTransferFrom with data
    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes memory _data
    ) public override {
        require(_isApprovedOrOwner(msg.sender, _from, _to, _tokenId));
        _safeTransfer(_from, _to, _tokenId, _data);
    }

    function _isApprovedOrOwner(
        address _spender,
        address _from,
        address _to,
        uint256 _tokenId
    ) internal view returns (bool) {
        require(_tokenId < kitties.length); //token must exist
        require(_to != address(0));
        require(_owns(msg.sender, _tokenId));

        return (_spender == _from ||
            _approvedFor(_spender, _tokenId) ||
            isApprovedForAll(_from, _spender));
    }
}
