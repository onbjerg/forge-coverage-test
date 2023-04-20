// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.15;

import "ds-test/test.sol";
import { BranchesNew } from "src/Contract1.sol";

interface Cheats {
    function expectRevert() external;
    function expectRevert(bytes calldata) external;
}

contract BranchNewTest is DSTest {
    Cheats internal constant cheats = Cheats(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    BranchesNew fixture;

    function setUp() external {
        fixture = new BranchesNew();
    }

    function testBranchNewRequire() public {
        fixture.branchRequire(true);
        cheats.expectRevert();
        fixture.branchRequire(false);
    }
}