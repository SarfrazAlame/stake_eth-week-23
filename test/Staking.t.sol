// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/StakingContract.sol";

contract StakingContractTest is Test {

    StakingContract stakingContract;

    function setUp() public {
        stakingContract = new StakingContract();
    }

    function testStake() public {
        stakingContract.stake{value: 200}();
        assert(stakingContract.balanceOf(address(this)) == 200);
    }

    function testStakeUser() public {
        vm.startPrank(0x3e5D85Cf342f82e569c21E83248fC1D91Df303Cd);
        vm.deal(0x3e5D85Cf342f82e569c21E83248fC1D91Df303Cd, 10 ether);
        stakingContract.stake{value: 1 ether}();
        assert(
            stakingContract.balanceOf(
                0x3e5D85Cf342f82e569c21E83248fC1D91Df303Cd
            ) == 1 ether
        );
    }

    function testUnstake() public {
        stakingContract.stake{value: 200}();
        stakingContract.unstake(100);
        assert(stakingContract.balanceOf(address(this)) == 100);
    }

    function testFailUnstake() public {
        stakingContract.stake{value: 200}();
        stakingContract.unstake(300);
    }
}
