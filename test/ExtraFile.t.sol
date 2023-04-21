// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.15;

import "ds-test/test.sol";
// import { BranchesNew } from "src/Contract1.sol";
// import { BranchesNew2 } from "src/Contract1.sol";
import "src/ExtraFile.sol";

interface Cheats {
    function expectRevert() external;
    function expectRevert(bytes calldata) external;
}

contract ExtraFileContract1Test is DSTest {
    Cheats internal constant cheats = Cheats(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    ExtraFileContract1 fixture;

    function setUp() external {
        fixture = new ExtraFileContract1();
    }

    function testBranchesNew() public {
        fixture.compute(true);
        cheats.expectRevert();
        fixture.compute(false);
    }
}

contract AnyNameButWeTestExtraFileContract2Test is DSTest {
    Cheats internal constant cheats = Cheats(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    ExtraFileContract2 fixture;

    function setUp() external {
        fixture = new ExtraFileContract2();
    }

    function testExtraFileContract2() public {
        fixture.compute(true);
        cheats.expectRevert();
        fixture.compute(false);
    }
}
