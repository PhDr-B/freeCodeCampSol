//Get funds from users
//Withdraw funds
//Set a minimum funding value

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

//Gas optimizations
//constant and immutable keywords make variables that cannot change


error NotOwner();

contract FundMe {

    using PriceCoverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;
    
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    //constructor immediately called on deployment
    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable {
        //Want to be able to set a minimum fund amount
        //1. How do we send ETH to this contract?
        //Contracts can hold funds like wallets do
        
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough"); //1e18 == 1 eth in wei, also need to get ETH to USD for this (oracle)
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
        //require(msg.sender == i_owner, NotOwner());
        if(msg.sender != i_owner) {revert NotOwner();}
        _; //run the rest of the function code
    }

    //What happens if someone sends this contract ETH without calling the fund function?

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

}