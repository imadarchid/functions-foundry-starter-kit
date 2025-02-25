// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {IFunctionsSubscriptions} from "foundry-chainlink-toolkit/src/interfaces/functions/IFunctionsSubscriptions.sol";
import {SampleConsumer} from "../../src/SampleConsumer.sol";
import {HelperConfig} from "../HelperConfig.s.sol";

contract AddConsumerToSubscription is Script, HelperConfig {
    uint64 public subscriptionId = 1; // env

    function run() public {
        address sampleConsumerContractAddress = DevOpsTools
            .get_most_recent_deployment("SampleConsumer", block.chainid);
        vm.startBroadcast();
        IFunctionsSubscriptions functionRouter = IFunctionsSubscriptions(
            getNetworkConfig().router
        );
        functionRouter.addConsumer(
            subscriptionId,
            sampleConsumerContractAddress
        );
        vm.stopBroadcast();
    }
}
