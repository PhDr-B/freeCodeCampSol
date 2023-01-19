//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7; //Always line after license, carrot means version given or greater

contract SimpleStorage {
    //types: boolean, uint, int, address, bytes
    uint256 favoriteNumber; //Gets initialized to zero

    mapping(string => uint256) public nameToFavoriteNumber;
    
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;

    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    //calldata, memory, storage are 3 of 6 places the EVM can store data. Storage is lasting type
    //need to be explicit about the type of arrays
    function addPerson(string memory _name, uint256 _favoriteNumber) public { //temporary data type: memory type can be reassigned, but calldata cannot
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

}