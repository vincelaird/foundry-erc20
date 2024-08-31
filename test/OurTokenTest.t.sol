// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;
    DeployOurToken public deployer;

    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    address charlie = makeAddr("charlie");

    uint256 public constant STARTING_BALANCE = 100 ether;
    uint256 public constant INITIAL_SUPPLY = 1000 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testInitialSupply() public view {
        assertEq(ourToken.totalSupply(), INITIAL_SUPPLY);
    }

    function testBobBalance() public view {
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE);
    }

    function testTransfer() public {
        uint256 transferAmount = 50 ether;
        
        vm.prank(bob);
        bool success = ourToken.transfer(alice, transferAmount);

        assertTrue(success);
        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }

    function testFailTransferInsufficientBalance() public {
        uint256 transferAmount = STARTING_BALANCE + 1 ether;
        
        vm.prank(bob);
        ourToken.transfer(alice, transferAmount);
    }

    function testAllowanceAndTransferFrom() public {
        uint256 initialAllowance = 1000;
        uint256 transferAmount = 500;
        
        // Bob approves Alice to spend tokens on his behalf
        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);

        assertEq(ourToken.allowance(bob, alice), initialAllowance);

        vm.prank(alice);
        bool success = ourToken.transferFrom(bob, charlie, transferAmount);

        assertTrue(success);
        assertEq(ourToken.balanceOf(charlie), transferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
        assertEq(ourToken.allowance(bob, alice), initialAllowance - transferAmount);
    }

    function testFailTransferFromInsufficientAllowance() public {
        uint256 initialAllowance = 100;
        uint256 transferAmount = initialAllowance + 1;
        
        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);

        vm.prank(alice);
        ourToken.transferFrom(bob, charlie, transferAmount);
    }

    function testTokenMetadata() public view {
        assertEq(ourToken.name(), "OurToken");
        assertEq(ourToken.symbol(), "OT");
        assertEq(ourToken.decimals(), 18);
    }
}