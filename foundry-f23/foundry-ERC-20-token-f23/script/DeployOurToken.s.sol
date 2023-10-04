// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {OurToken} from "../src/OurToken.sol";

contract DeployOurToken is Script {
    uint256 private constant INITIAL_SUPPLY = 1000 ether; // the identifier is CAPITAL because it is a constsant

    function run() external returns (OurToken) {
        vm.startBroadcast();
        OurToken ot = new  OurToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return ot;
    }
}
