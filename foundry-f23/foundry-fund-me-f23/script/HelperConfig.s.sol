// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "../forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/mocksV3aggregator.sol";

struct Addresholder {
    address priceFeeed;
}

contract HelperConfig is Script {
    uint8 public constant decimal = 8;
    int256 public constant initial_answer = 2000e8;

    Addresholder public Active_network_config;

    constructor() {
        if (block.chainid == 11155111) {
            Active_network_config = Seopolia_is_network();
        } else {
            Active_network_config = Anvil_is_network();
        }
    }

    function Seopolia_is_network() public pure returns (Addresholder memory) {
        Addresholder memory sepolia_network_address =
            Addresholder({priceFeeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return (sepolia_network_address);
    }

    function Anvil_is_network() public returns (Addresholder memory) {
        if (Active_network_config.priceFeeed != address(0)) {
            return Active_network_config;
        }
        vm.startBroadcast();
        MockV3Aggregator mockV3aggregator = new MockV3Aggregator(decimal,initial_answer);
        vm.stopBroadcast();
        Addresholder memory anvil_network_address = Addresholder({priceFeeed: address(mockV3aggregator)});
        return (anvil_network_address);
    }
}
