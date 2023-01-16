//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7; //Always line after license, carrot means version given or greater

contract SimpleStorage {
    //types: boolean, uint, int, address, bytes
    uint256 favoriteNumber; //Gets initialized to zero

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

}