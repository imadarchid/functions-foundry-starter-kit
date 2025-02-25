// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {SampleConsumer} from "../../src/SampleConsumer.sol";

contract Interactions is Script {
    function sendRequest() public {
        address sampleConsumerContractAddress = DevOpsTools
            .get_most_recent_deployment("SampleConsumer", block.chainid);
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        SampleConsumer sampleConsumer = SampleConsumer(
            sampleConsumerContractAddress
        );
        sampleConsumer.sendRequest(1);

        vm.stopBroadcast();
    }

    function getLatestResponse() public returns (bytes memory) {
        address sampleConsumerContractAddress = DevOpsTools
            .get_most_recent_deployment("SampleConsumer", block.chainid);
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        SampleConsumer sampleConsumer = SampleConsumer(
            sampleConsumerContractAddress
        );
        bytes memory response = sampleConsumer.getLatestResponse();
        vm.stopBroadcast();
        console.logBytes(response);
        return response;
    }
}
