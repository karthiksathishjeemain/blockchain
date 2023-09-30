// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19 ;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/fund_me.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";
contract Fundme_test is Test {
    FundMe fundme;
    // DeployFundMe deployFundMe;
    address USER = makeAddr("user");
    uint256 public constant SEND_VALUE = 0.1 ether;
    uint256 public constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundme = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }
    function testUserCanFundInteraction() public{
        FundFundMe fundFundMe =new FundFundMe ();
        fundFundMe.fundFundMe(address(fundme)) ;
        WithdrawFundMe withdrawFundMe =new WithdrawFundMe ();
        withdrawFundMe.withdrawFundMe(address(fundme)) ;
        assert(address(fundme).balance == 0);
    }
}