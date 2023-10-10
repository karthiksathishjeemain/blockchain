// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script,console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/fund_me.sol";

contract FundFundMe is Script {
    function fundFundMe(address most_recently_deployed)  public  {
        vm.startBroadcast();
        FundMe (payable(most_recently_deployed)).fund{value: 0.01 ether};
        vm.stopBroadcast(); 
        console.log("Funde FundMe with 0.01 ether"  );  
    }
    function run()  external {
        address most_recently_deployed = DevOpsTools.get_most_recent_deployment("FundMe",block.chainid);
        fundFundMe(most_recently_deployed);
    }
     
}
contract WithdrawFundMe is Script {
     function withdrawFundMe(address most_recently_deployed)  public  {
        vm.startBroadcast();
        FundMe(payable(most_recently_deployed)).cheaperwithdraw();
        vm.stopBroadcast(); 
        console.log("Funde FundMe with 0.01 ether"  );  
    }
    function run()  external {
        address most_recently_deployed = DevOpsTools.get_most_recent_deployment("FundMe",block.chainid);
        withdrawFundMe(most_recently_deployed);
    }
     
    
}