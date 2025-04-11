//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

/*the upgradeable contracts can't have constructor as the constructors are called on the time of deployment, and we know proxy get the data and storage from the implementation contracts, so we can't get that*/

contract BoxV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 internal number;

    //@custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        __Ownable_init(); // as we can't use constructor, this sets owner = msg.sender
        __UUPSUpgradeable_init(); // it's a good practise to do it, it's says like "hey this contract is upgradeable tada!"
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}
