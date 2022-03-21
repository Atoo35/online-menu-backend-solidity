// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import './Structs.sol';

contract Users{
    uint256 userCount=0;
    struct User {
        string first_name;
        string last_name;
        string email;
        ActiveStatus status;
    }

    mapping(uint256 => User) userMapping;
    mapping(uint256 => uint256) userToRestaurantMapping;

    modifier firstNameIsMandatory(string memory _name) {
        require(bytes(_name).length > 0, "First name is Required!!");
        _;
    }

    function createUser(string memory _first_name, string memory _last_name, string memory _email, uint256 _restaurant_id) firstNameIsMandatory(_first_name) internal returns(uint256){
        User memory user = User(_first_name, _last_name, _email, ActiveStatus.Active);
        uint256 userId = userCount;
        userToRestaurantMapping[userId] = _restaurant_id;
        userMapping[userCount++] = user; 
        return userId;
    }

    function getUser(uint256 _id) internal view returns(User memory,uint256){
        User memory user = userMapping[_id];
        return(user, userToRestaurantMapping[_id]);
    }
}