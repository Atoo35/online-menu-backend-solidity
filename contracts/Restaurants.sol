// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import './Structs.sol';

contract Restaurants{
    uint256 restaurantCount=0;

    struct Restaurant {
        string name;
        Address addr;
        uint256 contact_number;
        ActiveStatus status;
    }
    

    mapping(uint256 => Restaurant) restaurantMap;

    modifier nameIsMandatory(string memory _name) {
        require(bytes(_name).length > 0, "Name is Required!!");
        _;
    }

    function checkRestaurantExistence (Restaurant memory rest) private pure {
        require(bytes(rest.name).length > 0, "Restaurant does not exist!");
    }

    function create(string memory _name, Address memory _addr, uint256 _contact_number)  public nameIsMandatory(_name) {
        Address memory newAddress = Address(_addr.line_1, _addr.city, _addr.state, _addr.zip);
        Restaurant memory newRestaurant = Restaurant(_name, newAddress, _contact_number, ActiveStatus.Active);
        restaurantMap[restaurantCount++] = newRestaurant;
    }

    function markInactive(uint256 _id) public {
        Restaurant storage updatedRestaurant = restaurantMap[_id];
        checkRestaurantExistence(updatedRestaurant);
        updatedRestaurant.status = ActiveStatus.InActive;
    }

    function markActive(uint256 _id) public {
        Restaurant storage updatedRestaurant = restaurantMap[_id];
        checkRestaurantExistence(updatedRestaurant);
        updatedRestaurant.status = ActiveStatus.Active;
    }

    function getRestaurant(uint256 _id) public view returns(Restaurant memory){
        Restaurant memory res = restaurantMap[_id];
        return res;
    }

    function updateRestaurant (uint256 _id, string memory _name, Address memory _addr, uint256 _contact_number) public {
        Restaurant storage updatedRestaurant = restaurantMap[_id];
        checkRestaurantExistence(updatedRestaurant);
        if(bytes(_name).length > 0){
            updatedRestaurant.name = _name;
        }
        if(bytes(_addr.line_1).length > 0){
            updatedRestaurant.addr.line_1 = _addr.line_1;
        }
        if(bytes(_addr.city).length > 0){
            updatedRestaurant.addr.city = _addr.city;
        }
        if(bytes(_addr.state).length > 0){
            updatedRestaurant.addr.state = _addr.state;
        }if(bytes(_addr.zip).length > 0){
            updatedRestaurant.addr.zip = _addr.zip;
        }
        if(_contact_number > 0){
            updatedRestaurant.contact_number = _contact_number;
        }
    }
}