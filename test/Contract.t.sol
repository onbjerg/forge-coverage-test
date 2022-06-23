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

    function testBranchRequireTrue() public {
        fixture.branchRequire(true);
    }

    function testBranchRequireFalse() public {
        cheats.expectRevert();
        fixture.branchRequire(false);
    }

    function testBranchAssertTrue() public {
        fixture.branchAssert(true);
    }

    function testBranchAssertFalse() public {
        cheats.expectRevert(abi.encodeWithSignature("Panic(uint256)", 0x01));
        fixture.branchAssert(false);
    }

    function testBranchIfTrue() public {
        fixture.branchIf(true);
    }

    function testBranchIfFalse() public {
        cheats.expectRevert();
        fixture.branchIf(false);
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