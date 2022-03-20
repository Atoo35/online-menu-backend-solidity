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
    mapping(string => uint256) public roleNameToKeyMapping;

    constructor (){
        Role memory role = Role("Admin", ActiveStatus.Active);
        roleNameToKeyMapping[role.name] = roleCount;
        roleMapping[roleCount++] = role;

        Role memory role2 = Role("Restaurant Admin", ActiveStatus.Active);
        roleNameToKeyMapping[role2.name] = roleCount;
        roleMapping[roleCount++] = role2;
    }
}