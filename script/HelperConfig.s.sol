// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

contract HelperConfig is Script {
    uint256 public constant ETH_SEPOLIA_CHAIN_ID = 11155111;

    struct NetworkConfig {
        address linkToken;
        address usdToken;
        bytes32 donId;
        address router;
    }

    NetworkConfig public activeNetworkConfig;
    mapping(uint256 chainId => NetworkConfig) public networkConfig;

    constructor() {
        if (block.chainid == ETH_SEPOLIA_CHAIN_ID) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else {
            activeNetworkConfig = getAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig()
        public
        pure
        returns (NetworkConfig memory sepoliaConfig)
    {
        sepoliaConfig = NetworkConfig({
            linkToken: address(0x779877A7B0D9E8603169DdbD7836e478b4624789),
            usdToken: address(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419),
            donId: stringToBytes32("fun-ethereum-sepolia-1"),
            router: address(0xb83E47C2bC239B3bf370bc41e1459A34b41238D0)
        });

        return sepoliaConfig;
    }

    function getAnvilEthConfig()
        public
        view
        returns (NetworkConfig memory anvilConfig)
    {
        anvilConfig = NetworkConfig({
            linkToken: vm.envAddress("LINK_TOKEN_ADDRESS"),
            usdToken: address(0),
            donId: stringToBytes32(vm.envString("DON_ID")),
            router: vm.envAddress("FUNCTIONS_ROUTER_ADDRESS")
        });

        return anvilConfig;
    }

    function getNetworkConfig() public view returns (NetworkConfig memory) {
        return activeNetworkConfig;
    }

    function stringToBytes32(
        string memory source
    ) public pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }

        assembly {
            result := mload(add(source, 32))
        }
    }
}
