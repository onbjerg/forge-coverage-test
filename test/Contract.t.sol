// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.15;

import "ds-test/test.sol";
import "src/Contract.sol";
import { BranchesNew2 } from "src/Contract1.sol";
import "src/Contract2.sol";

interface Cheats {
    function expectRevert() external;
    function expectRevert(bytes calldata) external;
}

contract BranchTest is DSTest {
    Cheats internal constant cheats = Cheats(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
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

    function testComplexBranch() public {
        fixture.complexBranch(false, 300);
    }
}

contract BranchNew2Test is DSTest {
    Cheats internal constant cheats = Cheats(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    BranchesNew2 fixture;

    function setUp() external {
        fixture = new BranchesNew2();
    }

    function testBranchNew2Require() public {
        fixture.branchRequire(true);
        cheats.expectRevert();
        fixture.branchRequire(false);
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

// Note: Shouldn't break
contract StuffThatBreaksTest is DSTest {
    StuffThatBreaks fixture;

    function setUp() external {
        fixture = new StuffThatBreaks();
    }

    function testJustReturns() external {
        assertEq(fixture.justReturns(), 1);
    }

    function testSomeInternalFunc() external {
        fixture.someInternalFunc(true);
    }
}

contract FuzzTest is DSTest {
    Fuzz fixture;

    function setUp() external {
        fixture = new Fuzz();
    }

    function testFuzz(bool a) external {
        assert(fixture.eq(a, a));
    }
}

contract InternalLibraryUserTest is DSTest {
    InternalLibraryUser fixture;

    function setUp() external {
        fixture = new InternalLibraryUser();
    }

    function testRun() external {
        fixture.run();
    }
}

contract ExternalLibraryUserTest is DSTest {
    ExternalLibraryUser fixture;

    function setUp() external {
        fixture = new ExternalLibraryUser();
    }

    function testRun() external {
        fixture.run();
    }
}

contract ImportedLibraryUserTest is DSTest {
    Cheats internal constant cheats = Cheats(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    ImportedLibraryUser fixture;

    function setUp() external {
        fixture = new ImportedLibraryUser();
    }

    function testRun() external {
        cheats.expectRevert("too much");
        fixture.asdfghjklmnopqrstuvwxyz();
    }
}

contract UsingForLibraryUserTest is DSTest {
    UsingForLibraryUser fixture;

    function setUp() external {
        fixture = new UsingForLibraryUser();
    }

    function testTenMinusArgPlusOne() external {
        assertEq(fixture.tenMinusArgPlusOne(10), 1);
    }
}
