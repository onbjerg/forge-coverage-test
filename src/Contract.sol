// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.15;

/// Expected:
/// - Functions: 6
/// - Branches: 6, 14 paths(?)
/// - Statements: 14(?)
/// - Lines: 19
/// - Coverage: 100%
contract Branches {
    event Branch(uint256 n);

    function branchRequire(bool increment) external {
        // Should be treated as a branch
        require(increment);

        emit Branch(2);
    }

    function branchAssert(bool increment) external {
        // Should be treated as a branch
        assert(increment);

        emit Branch(2);
    }

    function branchIf(bool increment) external {
        // Should be treated as a branch
        if (!increment) {
            revert();
        }

        emit Branch(2);
    }

    function branchIfElse(bool increment) external {
        if (increment) {
            emit Branch(1);
        } else {
            revert();
        }
    }

    function branchIfElseIf(bool a, bool b) external {
        if (a) {
            emit Branch(1);
        } else if (b) {
            emit Branch(2);
        }
    }

    function branchIfElseIfElse(bool a, bool b) external {
        if (a) {
            emit Branch(1);
        } else if (b) {
            emit Branch(2);
        } else {
            emit Branch(3);
        }
    }

    function complexBranch(bool a, uint256 b) external {
        if (a && b < 100) {
            // Uncovered
            emit Branch(1);
        } else if (a && b < 200) {
            // Uncovered
            emit Branch(2);
        } else if (!a) {
            // Covered
            emit Branch(3);
        }
    }
}

/// Expected:
/// - Functions: 1
/// - Branches: 1, 2 paths
/// - Statements: 7
/// - Lines: 6
/// - Coverage: 100%
contract Loop {
    function oddEven() external pure {
        // Should be executed once
        uint256 count = 0;

        for (uint256 i = 0; i < 10; i++) {
            if (i % 2 == 0) {
                // Should be executed 5 times
                count += 1;
            } else {
                // Should be executed 5 times
                count -= 1;
            }
        }
    }
}

/// Expected:
/// - Functions: 1
/// - Branches: 1, 2 paths
/// - Statements: 4
/// - Lines: 5
/// - Coverage: 0%
contract Uncovered {
    function dontCallMe(uint256 a, uint256 b) external pure {
        uint256 c = a + b;
        uint256 d = a - b;
        uint256 e = a + b * 2;

        // I know this should have been checked earlier don't look t11s
        if (c < 10) {
            revert();
        }
    }
}

contract PartiallyCovered {
    event Branch(uint256 n);

    function allBranches(bool a) external {
        // Should be partially covered
        require(a);
        // Should be partially covered
        assert(a);

        if (!a) {
            // Should not be covered
            revert();
        }

        if (a) {
            // Should be covered
            emit Branch(1);
        } else {
            // Should not be covered
            revert();
        }

        if (a) {
            // Should be covered
            emit Branch(2);
        } else if (1 + 2 == 1) {
            // Should not be covered
            emit Branch(3);

            // There is an implicit "else" here that should not be covered
        }

        if (a) {
            // Should be covered
            emit Branch(2);
        } else if (1 + 2 == 1) {
            // Should not be covered
            emit Branch(3);
        } else {
            // Should not be covered
            emit Branch(4);
        }
    }
}

// Note: Shouldn't break anymore
contract StuffThatBreaks {
    uint256 x = 0;

    function justReturns() external returns (uint256) {
        // should be covered
        return 1;
    }

    function isInternal(bool a, bool b) internal {
        // should be covered
        if (a && b) {
            x = x + 1;
        }
    }

    // should not generate coverage data
    function emptyBody() external {}

    function someInternalFunc(bool a) external {
        // should be covered
        isInternal(a, a);
    }
}

contract Fuzz {
    function eq(bool a, bool b) external returns (bool) {
        // should be run 256 times and be covered
        return a == b;
    }
}

library InternalLibrary {
    function addLtTen(uint256 a, uint256 b) internal {
        // should be marked as covered (partially)
        require(a + b <= 10, "too much");
    }
}

library ExternalLibrary {
    function addGtTen(uint256 a, uint256 b) external {
        // should be marked as covered (partially)
        require(a + b > 10, "too little");
    }
}

contract InternalLibraryUser {
    function run() external {
        // should be marked as covered
        InternalLibrary.addLtTen(1, 2);
    }
}

contract ExternalLibraryUser {
    function run() external {
        // should be marked as covered
        ExternalLibrary.addGtTen(10, 10);
    }
}