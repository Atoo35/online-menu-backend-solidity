//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract UserRoles {
    mapping(uint256 => uint256[]) userRoleMapping;

    function mapUserToRole(uint256 _user_id, uint256 _role_id) internal {
        userRoleMapping[_user_id].push(_role_id); 
    }

    function getRolesByUserId(uint256 _user_id) internal view returns(uint256[] memory){
        return userRoleMapping[_user_id];
    }
}