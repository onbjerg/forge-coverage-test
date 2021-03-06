// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.15;

import "ds-test/test.sol";
import "src/Contract.sol";

interface Cheats {
    function expectRevert() external;
    function expectRevert(bytes calldata) external;
}

contract BranchTest is DSTest {
    Cheats constant internal cheats = Cheats(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    Branches fixture;

    function setUp() external {
        fixture = new Branches();
    }

    function testBranchRequire() public {
        fixture.branchRequire(true);
        cheats.expectRevert();
        fixture.branchRequire(false);
    }

    function testBranchAssert() public {
        fixture.branchAssert(true);
        cheats.expectRevert(abi.encodeWithSignature("Panic(uint256)", 0x01));
        fixture.branchAssert(false);
    }

    function testBranchIf() public {
        fixture.branchIf(true);
        cheats.expectRevert();
        fixture.branchIf(false);
    }

    function testBranchIfElse() public {
        fixture.branchIfElse(true);
        cheats.expectRevert();
        fixture.branchIfElse(false);
    }

    function testBranchIfElseIf() public {
        fixture.branchIfElseIf(true, true);
        fixture.branchIfElseIf(false, true);
        fixture.branchIfElseIf(true, false);
        fixture.branchIfElseIf(false, false);
    }

    function testBranchIfElseIfElse() public {
        fixture.branchIfElseIfElse(true, true);
        fixture.branchIfElseIfElse(false, true);
        fixture.branchIfElseIfElse(true, false);
        fixture.branchIfElseIfElse(false, false);
    }
}

contract LoopTest is DSTest {
    Loop fixture;

    function setUp() external {
        fixture = new Loop();
    }

    function testOddEven() external view {
        fixture.oddEven();
    }
}

contract PartiallyCoveredTest is DSTest {
    PartiallyCovered fixture;

    function setUp() external {
        fixture = new PartiallyCovered();
    }

    function testPartiallyCovered() external {
        fixture.allBranches(true);
    }
}