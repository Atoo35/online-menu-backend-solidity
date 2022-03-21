// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import './Restaurants.sol';
import './Users.sol';
import './Roles.sol';
import './UserRoles.sol';
contract OnlineMenu is Restaurants, Users, Roles, UserRoles{

    constructor() {
        Address memory adr = Address("","","","");
        Restaurants.create("Dummy Restaurant",adr,982313213);

        Roles.createRole("Admin");
        Roles.createRole("Restaurant Admin");
        createNewUser("Atharva","Deshpande","adrooney322@gmail.com",0,"Admin");
    }
 
    // Modifiers
    modifier RestaurantShouldExist (uint256 _id){
        require(bytes(restaurantMap[_id].name).length > 0, "Restaurant does not exist!");
        _;
    }

    modifier UserShouldExist (uint256 _id){
        require(bytes(userMapping[_id].first_name).length > 0, "User does not exist!");
        _;

    }

    // Restaurant functions
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
    function createNewUser(string memory _first_name, string memory _last_name, string memory _email, uint256 _restaurant_id, string memory _role_name)
        RestaurantShouldExist(_restaurant_id) public {
        uint256 _user_id = Users.createUser(_first_name, _last_name, _email, _restaurant_id);
        uint256 _role_id = Roles.getRoleIdByRoleName(_role_name);
        UserRoles.mapUserToRole(_user_id, _role_id);
    }

    function getUserDetails(uint256 _id) UserShouldExist(_id) public view returns(User memory, uint[] memory, uint256){
        User memory user;
        uint256 _restaurant_id;
        uint256[] memory user_roles;
        (user,_restaurant_id) = Users.getUser(_id);
        user_roles = UserRoles.getRolesByUserId(_id);
        return(user,user_roles,_restaurant_id);
    }

    function getUserRoles(uint256 _user_id) UserShouldExist(_user_id) public view returns(uint256[] memory){
        return UserRoles.getRolesByUserId(_user_id);
    }
}