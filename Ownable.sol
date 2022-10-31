/* @title The Ownable contract has an owner address, and provides basic authorization control
functions, this simplifies the implementation of "user permissions". */
// @author Jerry Zhang

pragma solidity >=0.5.0 <0.6.0;

contract Ownable {
    address public owner;

    uint public totalLandsCounter;

    constructor() public {
        owner = msg.sender;
        totalLandsCounter = 0;
    }

    modifier isOwner 
    {
        require(msg.sender == owner);
        _;
    }
}