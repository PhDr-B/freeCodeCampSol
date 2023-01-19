//Get funds from users
//Withdraw funds
//Set a minimum funding value

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FundMe {

    uint256 public minimumUsd = 50;
    
    function fund() public payable {
        //Want to be able to set a minimum fund amount
        //1. How do we send ETH to this contract?
        //Contracts can hold funds like wallets do
        require(msg.value >= minimumUsd, "Didn't send enough"); //1e18 == 1 eth in wei, also need to get ETH to USD for this (oracle)
    }

    //function withdraw(){}
}