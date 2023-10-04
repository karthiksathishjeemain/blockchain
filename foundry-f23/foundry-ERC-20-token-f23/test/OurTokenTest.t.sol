// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test,console} from "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";

contract OurTokenTest is Test {
    address public bob =makeAddr("bob");
    address public deepak = makeAddr("deepak");
    uint256 amount = 2 ether;
    DeployOurToken public deployer;
    OurToken public ourtoken;

    function setUp() public {
        deployer = new DeployOurToken();
        ourtoken = deployer.run();
         vm.prank(msg.sender);
        ourtoken.transfer(bob, amount);

    }

    function testTransfer() public {
    //    console.log(ourtoken.balanceOf(address(this)));
        assertEq(ourtoken.balanceOf(bob), amount);
    }
   
}
