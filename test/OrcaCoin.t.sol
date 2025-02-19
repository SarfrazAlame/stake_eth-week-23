// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/OrcaCoin.sol";

contract OrcaCoinTest is Test {
    OrcaCoinContract orcaCoin;

    function setUp() public {
        orcaCoin = new OrcaCoinContract(address(this));
    }

    function testInitialSupply() public view {
        assert(orcaCoin.totalSupply() == 0);
    }

    function testMint() public {
        orcaCoin.mint(0x3e5D85Cf342f82e569c21E83248fC1D91Df303Cd, 100);
        assert(orcaCoin.balanceOf(0x3e5D85Cf342f82e569c21E83248fC1D91Df303Cd) == 100);
    }

    function testFailMint() public {
        vm.startPrank(0x3e5D85Cf342f82e569c21E83248fC1D91Df303Cd);
        orcaCoin.mint(0x3e5D85Cf342f82e569c21E83248fC1D91Df303Cd, 100);
    }

    function testChangeStakingContract() public {
        orcaCoin.updateStakingContract(0x3e5D85Cf342f82e569c21E83248fC1D91Df303Cd);

        vm.prank(0x3e5D85Cf342f82e569c21E83248fC1D91Df303Cd);
        orcaCoin.mint(0x3e5D85Cf342f82e569c21E83248fC1D91Df303Cd, 100);

        assertEq(orcaCoin.balanceOf(0x3e5D85Cf342f82e569c21E83248fC1D91Df303Cd), 100, "ok");
    }
}

