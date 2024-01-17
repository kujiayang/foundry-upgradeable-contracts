// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
// UUPSUpgradeable is an abstract contract, has some undefined fns that requires the child class to define
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract BoxV2 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    uint256 internal number;

    // below comment lets constructor happen despite being a upgradeable contract
    // @custom: oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers(); // doesnt let any initialization happen
    }
    
    // upgradeable initializable fns have double underscore __
    // initializer fn is a contructor for proxies
    function initialize() public initializer {
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init(); // just tells reader this is a uups upgradeable contract
    }

    function setNumber (uint256 _number) external {
        number = _number;
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256){
        return 2;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}