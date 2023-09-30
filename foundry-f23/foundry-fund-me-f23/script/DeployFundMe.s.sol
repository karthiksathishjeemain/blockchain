// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "../forge-std/Script.sol";
import {FundMe} from "../src/fund_me.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        HelperConfig helperConfig = new HelperConfig();

        vm.startBroadcast();
        FundMe fundMe = new FundMe(helperConfig.Active_network_config());
        vm.stopBroadcast();
        return fundMe;
    }
}
