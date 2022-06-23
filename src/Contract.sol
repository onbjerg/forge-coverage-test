// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.15;

/// Expected:
/// - Functions: 3
/// - Branches: 3, 6 paths
/// - Statements: 7(?)
/// - Lines: 7
/// - Coverage: 100%
contract Branches {
    event Branch(bool condition);

    function branchRequire(bool increment) external {
        // Should be treated as a branch
        require(increment);

        emit Branch(increment);
    }

    function branchAssert(bool increment) external {
        // Should be treated as a branch
        assert(increment);

        emit Branch(increment);
    }

    function branchIf(bool increment) external {
        // Should be treated as a branch
        if (!increment) {
            revert();
        }

        emit Branch(increment);
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
