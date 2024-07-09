// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.22;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";


contract NFT is ERC721, Ownable{
    
     
    error NFTERC721__OnlyOwner();
    error NFTERC721__InvalidAddress();
    error NFTERC721__SameAddress();
    error ERC721__InvalidSender(address sender);
    error ERC721_AlreadyMinted();
   
    //Mapping tokenIds to owner's addresses
    mapping (uint256 => address) private _owners;
    mapping (uint256 => bool) private _tokensMinted;

    address owner;
    uint256 tokenCounter;
    address private svg1;
    address private svg2;

    enum stateOfNft{
        State1 ,
        State2       
    }

    constructor(string memory name , string memory  symbol ,address _svg1, address _svg2) ERC721("NFT-ERC721","NFT") Ownable(address(msg.sender)){
        tokenCounter = 0 ;
        svg1 = _svg1;
        svg2 = _svg2;
    }

    modifier _onlyOwner{
        require(owner == msg.sender);
        _;
    }

    function mintNft(address to,address currentOwner ,uint256 tokenId, bytes memory data) internal onlyOwner {
        if(to == address(0)) revert NFTERC721__InvalidAddress() ;
        if(currentOwner == address(0)) revert NFTERC721__InvalidAddress();
        if(to == currentOwner) revert NFTERC721__SameAddress();
        _safeMint(to,tokenId);
        if(currentOwner != address(0)){
            revert ERC721__InvalidSender(address(0));
        }
        _update(to,tokenId,currentOwner);
    }
    
    
    /**
     * 
     * @param from The current Owner
     * @param to The address to where the token will be transferred
     * @param tokenId The tokenId 
     */

    function _safeMint(address from , address to, uint256 tokenId) internal onlyOwner{
        if(_exists(tokenId)) revert ERC721_AlreadyMinted();
        _safeMint(to,tokenId);
    }
     
    

    /*
     * This function is written with the purpose of checking whether a token iss already present or not
     * @param  
     */
    function _exists(uint256 tokenId) public view returns(bool){
        return _tokensMinted[tokenId]; 
    }
   

    





    /*
     * These are getter functions intended to get the parameters token , svg
     */






}
