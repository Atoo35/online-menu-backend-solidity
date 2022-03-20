// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import './Restaurants.sol';
import './Users.sol';
import './Roles.sol';
contract OnlineMenu is Restaurants, Users, Roles{

    // Restaurant functions
    modifier RestaurantShouldExist (uint256 _id){
        require(bytes(restaurantMap[_id].name).length > 0, "Restaurant does not exist!");
        _;
    }

    function createRestaurant(string memory _name, Address memory _addr, uint256 _contact_number) public{
        Restaurants.create(_name,_addr,_contact_number);
    }
    
    function getRestaurantDetails(uint256 _id) public view returns(Restaurant memory){
        Restaurant memory restaurant = Restaurants.getRestaurant(_id);
        return restaurant;
    }

    function markRestaurantActive(uint256 _id) public {
        Restaurants.markActive(_id);
    }

    function markRestaurantInactive(uint256 _id) public {
        Restaurants.markInactive(_id);
    }

    function updateRestaurantDetails(uint256 _id, string memory _name, Address memory _addr, uint256 _contact_number) public {
        Restaurants.updateRestaurant(_id, _name, _addr, _contact_number);
    }

    // User functions
    function createNewUser(string memory _first_name, string memory _last_name, string memory _email, uint256 _restaurant_id) RestaurantShouldExist(_restaurant_id) public {
        Users.createUser(_first_name, _last_name, _email, _restaurant_id);
    }

    function getUserDetails(uint256 _id) public view returns(User memory, uint){
        User memory user;
        uint256 _restaurant_id;
        (user,_restaurant_id) = Users.getUser(_id);
        return(user,_restaurant_id);
    }
}