//Get funds from users
//Withdraw funds
//Set a minimum funding value

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe {

    using PriceCoverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;
    
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public owner;

    //constructor immediately called on deployment
    constructor(){
        owner = msg.sender;
    }

    function fund() public payable {
        //Want to be able to set a minimum fund amount
        //1. How do we send ETH to this contract?
        //Contracts can hold funds like wallets do
        
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough"); //1e18 == 1 eth in wei, also need to get ETH to USD for this (oracle)
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }


    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // reset the array
        funders = new address[](0);
        
        //withdraw funds
        //call, no gas limit.  The recommended way to do this
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Sender is not owner!");
        _; //run the rest of the function code
    }
}