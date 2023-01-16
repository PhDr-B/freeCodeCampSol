//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7; //Always line after license, carrot means version given or greater

contract SimpleStorage {
    //types: boolean, uint, int, address, bytes
    uint256 favoriteNumber; //Gets initialized to zero

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
    }

}