// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; //npm install @openzeppelin/contracts
import "@openzeppelin/contracts/utils/Counters.sol";

contract Bridge721 is ERC721 {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    //mapping(string => uint8) hashes;
    mapping(uint256 => address) public _tokenOwners;
    mapping(address => uint256) public _tokens;

    constructor() ERC721("Bridge721", "bNFT") {
    }

    function _mint721() public payable{
        uint256 id = _tokenIds.current();
        _tokenOwners[id] = msg.sender;
        _tokens[msg.sender] = id;
        _mint(msg.sender, id);
        _tokenIds.increment();
    }
    
    function getTokens() public view returns (uint256){
        return _tokens[msg.sender];
    }
    
}