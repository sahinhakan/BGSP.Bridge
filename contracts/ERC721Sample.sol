// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; //npm install @openzeppelin/contracts
import "@openzeppelin/contracts/utils/Counters.sol";

contract Bridge721 is ERC721 {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    //mapping(uint256 => address) public _tokenOwners; ERC721'in standartında var zaten bu alan. ownerOf metodu ile de cevabı alabiliyorum
    //mapping(address => uint256) public _tokens;
    uint256 zeroPointOneAvax = (10 ** 17);
    address payable contratAddress;
    mapping(uint256 => address) private originalOwner;

    constructor() ERC721("Bridge721", "bNFT") {
        contratAddress = payable(msg.sender);
    }

    function mint721() public payable{
        uint256 id = _tokenIds.current();
        //_tokenOwners[id] = msg.sender;
        //_tokens[msg.sender] = id;
        _mint(msg.sender, id);
        _tokenIds.increment();
    }
    
    // function getTokens() public view returns (uint256){
    //     return _tokens[msg.sender];
    // }

    //ownerOf(uint256 tokenId) owner'ı buradan buluruz aslında

    function lockToken(uint256 tokenId) public payable {
        //şimdilik işlem ücreti olmasın
        //require(msg.value >= zeroPointOneAvax, "Ether value is below the lock price");
        transferFrom(msg.sender, contratAddress, tokenId);
        originalOwner[tokenId] = msg.sender;
        _approve(msg.sender, tokenId);//lock larken approve yetkisini kişiye vermek lazım yoksa daha sonrasında yapılamıyor.
    }
    
    function unlockToken(uint256 tokenId) public payable {
        require(msg.sender == originalOwner[tokenId], "This NFT is not yours");
        transferFrom(contratAddress, msg.sender, tokenId);
    }
    
}