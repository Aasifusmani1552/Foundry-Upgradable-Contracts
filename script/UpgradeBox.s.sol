// SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BoxV2} from "src/BoxV2.sol";
import {BoxV1} from "src/BoxV1.sol";
import {DevOpsTools} from "@foundry-devops/DevOpsTools.sol";

contract UpgradeBox is Script {
    function run() external returns (address) {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

        vm.startBroadcast();
        BoxV2 newBox = new BoxV2();
        vm.stopBroadcast();

        address proxy = upgradeBox(mostRecentlyDeployed, address(newBox));
        return proxy;
    }

    function upgradeBox(address proxyAddress, address newBox) public returns (address) {
        vm.startBroadcast();
        BoxV1 proxy = BoxV1(proxyAddress); // casting proxy to box as it now looks same(with same storage, it calls the functions with delegatecalls)
        proxy.upgradeTo(address(newBox)); // proxy now points to the newBox or the upgraded contract
        vm.stopBroadcast();

        return address(proxy);
    }
}
