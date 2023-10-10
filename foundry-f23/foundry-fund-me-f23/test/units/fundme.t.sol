// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/fund_me.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

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

    function testup() public {
        assertEq(fundme.MINIMUM_USD(), 5e18);
    }

    function testVersion() public {
        assertEq(fundme.getVersion(), 4);
    }

    function testFundfailsWithoutEth() public {
        vm.expectRevert();
        fundme.fund();
    }

    function f() public {
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();
        uint256 amountfund = fundme.getAmountFunded(USER);
        assertEq(amountfund, SEND_VALUE);
    }

    function testAdds_funders_to_list_of_funders() public funded {
        // vm.prank(USER);
        // fundme.fund{value: SEND_VALUE}();
        address funder = fundme.getaddress(0);
        assertEq(funder, USER);
        //  Use  Modifier to reduce the length;
    }

    modifier funded() {
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();
        _;
    }

    function testOnlyOwnerCanWithdraw() public {
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();
        vm.prank(USER);
         vm.expectRevert();
        // console.log(address(msg.sender));
        fundme.cheaperwithdraw();
    }

    function test_Withdraw_with_single_funder() public funded {
        uint256 startingOwnerBalance = fundme.getowner().balance;
        uint256 startingFundMeBalance = address(fundme).balance;

        vm.prank(fundme.getowner());
        fundme.cheaperwithdraw();

        uint256 EndingOwnerBalance = fundme.getowner().balance;
        uint256 EndingFundMeBalance = address(fundme).balance;
        assertEq(EndingFundMeBalance, 0);
        assertEq(startingOwnerBalance + startingFundMeBalance, EndingOwnerBalance);
    }
     function test_cheaperWithdraw_with_multiple_funders() public {
        //uint160 for a reason that: to get address by using address(i) the i must be of type "uint160"
        uint160 no_of_funders = 10;
        uint160 startingFunderIndex = 1;

        for (uint160 i = startingFunderIndex; i < no_of_funders; i++) {
            /*next 3 lines are replacement of funded modifier*/
            hoax(address(i), 0.1 ether);
            fundme.fund{value: 0.1 ether}();
        }
        uint256 startingOwnerBalance = fundme.getowner().balance;
        uint256 startingFundMeBalance = address(fundme).balance;

        vm.prank(fundme.getowner());
        fundme.cheaperwithdraw();

        assertEq(address(fundme).balance, 0);
        assertEq(startingOwnerBalance + startingFundMeBalance, fundme.getowner().balance);
    }

    function test_Withdraw_with_multiple_funders() public {
        //uint160 for a reason that: to get address by using address(i) the i must be of type "uint160"
        uint160 no_of_funders = 10;
        uint160 startingFunderIndex = 1;

        for (uint160 i = startingFunderIndex; i < no_of_funders; i++) {
            /*next 3 lines are replacement of funded modifier*/
            hoax(address(i), 0.1 ether);
            fundme.fund{value: 0.1 ether}();
        }
        uint256 startingOwnerBalance = fundme.getowner().balance;
        uint256 startingFundMeBalance = address(fundme).balance;

        vm.prank(fundme.getowner());
        fundme.cheaperwithdraw();

        assertEq(address(fundme).balance, 0);
        assertEq(startingOwnerBalance + startingFundMeBalance, fundme.getowner().balance);
    }
}
