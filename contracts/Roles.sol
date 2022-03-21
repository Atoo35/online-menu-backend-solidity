//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import './Structs.sol';

contract Roles{
    uint roleCount = 0;
    struct Role{
        string name;
        ActiveStatus status;
    }
    mapping(uint256 => Role) public roleMapping;
    mapping(string => uint256) roleNameToKeyMapping;

    function getRoleIdByRoleName(string memory _role_name) internal view returns(uint256){
        return roleNameToKeyMapping[_role_name];
    }

    function createRole(string memory _role_name) internal {
        Role memory role = Role(_role_name, ActiveStatus.Active);
        roleNameToKeyMapping[role.name] = roleCount;
        roleMapping[roleCount++] = role;
    }
}