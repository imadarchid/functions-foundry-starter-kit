// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {SampleConsumer} from "../../src/SampleConsumer.sol";
import {console} from "forge-std/console.sol";
import {HelperConfig} from "../HelperConfig.s.sol";

contract DeployConsumer is Script, HelperConfig {
    function run() public {
        vm.startBroadcast();
        SampleConsumer sampleConsumer = new SampleConsumer(
            getNetworkConfig().router,
            getNetworkConfig().donId
        );
        console.log("SampleConsumer deployed at", address(sampleConsumer));
        vm.stopBroadcast();
    }
}
