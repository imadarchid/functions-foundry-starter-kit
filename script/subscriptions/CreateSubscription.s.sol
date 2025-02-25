// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";

import {IFunctionsSubscriptions} from "foundry-chainlink-toolkit/src/interfaces/functions/IFunctionsSubscriptions.sol";
import {HelperConfig} from "../HelperConfig.s.sol";

contract CreateSubscription is Script, HelperConfig {
    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        IFunctionsSubscriptions functionRouter = IFunctionsSubscriptions(
            getNetworkConfig().router
        );
        uint64 subscriptionId = functionRouter.createSubscription();
        console.log("Subscription ID: %s", subscriptionId);
        vm.stopBroadcast();
    }
}
