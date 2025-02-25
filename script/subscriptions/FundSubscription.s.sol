// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";

import {IFunctionsSubscriptions} from "foundry-chainlink-toolkit/src/interfaces/functions/IFunctionsSubscriptions.sol";
import {ILinkToken} from "../../src/interfaces/ILinkToken.sol";
import {HelperConfig} from "../HelperConfig.s.sol";

contract FundSubscription is Script, HelperConfig {
    uint64 public subscriptionId = 1;
    uint256 public amount = 1000000000000000000;

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        IFunctionsSubscriptions functionRouter = IFunctionsSubscriptions(
            getNetworkConfig().router
        );
        ILinkToken linkToken = ILinkToken(getNetworkConfig().linkToken);
        linkToken.transferAndCall(
            getNetworkConfig().router,
            amount,
            abi.encode(subscriptionId)
        );
        vm.stopBroadcast();
    }
}
