// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./KittyContract.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "./IKittyMarketplace.sol";

contract KittyMarketplace is Ownable, IKittyMarketplace {
    KittyContract private _kittyContract;

    struct Offer {
        address payable seller;
        uint256 price;
        uint256 index;
        uint256 tokenId;
        bool active;
    }

    Offer[] offers;

    //event MarketTransaction(string TxType, address owner, uint256 tokenId);

    mapping(uint256 => Offer) tokenIdToOffer;

    function setKittyContract(address _kittyContractAddress)
        public
        override
        onlyOwner
    {
        _kittyContract = KittyContract(_kittyContractAddress);
    }

    constructor(address _kittyContractAddress) {
        setKittyContract(_kittyContractAddress);
    }

    function getOffer(uint256 _tokenId)
        public
        view
        override
        returns (
            address sller,
            uint256 price,
            uint256 index,
            uint256 tokenId,
            bool active
        )
    {
        Offer storage offer = tokenIdToOffer[_tokenId];
        return (
            offer.seller,
            offer.price,
            offer.index,
            offer.tokenId,
            offer.active
        );
    }

    function getAllTokenOnSale()
        public
        view
        override
        returns (uint256[] memory listOfOffers)
    {
        uint256 totalOffers = offers.length;

        if (totalOffers == 0) {
            return new uint256[](0);
        } else {
            uint256[] memory result = new uint256[](totalOffers);

            uint256 offerId;

            for (offerId = 0; offerId < totalOffers; offerId++) {
                if (offers[offerId].active == true) {
                    result[offerId] = offers[offerId].tokenId;
                }
            }

            return result;
        }
    }

    function _ownsKitty(address _address, uint256 _tokenId)
        internal
        view
        returns (bool)
    {
        return (_kittyContract.ownerOf(_tokenId) == _address);
    }

    function setOffer(uint256 _price, uint256 _tokenId) public override {
        require(
            _ownsKitty(msg.sender, _tokenId),
            "You are NOT the owner of that kitty!"
        );

        require(
            tokenIdToOffer[_tokenId].active == false,
            "You can't sel twise the same offer!"
        );

        require(
            _kittyContract.isApprovedForAll(msg.sender, address(this)),
            "Contract needs to be approved to transfer the kitty in the future!"
        );

        Offer memory _offer = Offer({
            seller: payable(msg.sender),
            price: _price,
            active: true,
            tokenId: _tokenId,
            index: offers.length
        });

        tokenIdToOffer[_tokenId] = _offer;
        offers.push(_offer);

        emit MarketTransaction("Create offer", msg.sender, _tokenId);
    }

    function removeOffer(uint256 _tokenId) public override {
        Offer memory offer = tokenIdToOffer[_tokenId];

        require(
            offer.seller == msg.sender,
            "You are NOT the seller of that kitty!"
        );

        delete tokenIdToOffer[_tokenId];
        offers[offer.index].active = false;

        emit MarketTransaction("Remove offer", msg.sender, _tokenId);
    }

    function buyKitty(uint256 _tokenId) public payable override {
        Offer memory offer = tokenIdToOffer[_tokenId];

        require(msg.value == offer.price, "Incorrect price!");

        require(
            tokenIdToOffer[_tokenId].active == true,
            "No active offer present!"
        );

        //IMPORTANT: Delete the kitty from the mapping BEFORE paying out to preven reentry attack!
        delete tokenIdToOffer[_tokenId];
        offers[offer.index].active = false;

        if (offer.price > 0) {
            offer.seller.transfer(offer.price);
        }

        _kittyContract.transferFrom(offer.seller, msg.sender, _tokenId);

        emit MarketTransaction("Buy", msg.sender, _tokenId);
    }
}
