//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeMathTester {
    uint8 public bigNumber =255; // unchecked, number would wrap back to zero

    function add() public {
        unchecked {bigNumber = bigNumber +1;}
    }
}