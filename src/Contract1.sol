// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.15;

/// Expected:
/// - Functions: 6
/// - Branches: 6, 14 paths(?)
/// - Statements: 14(?)
/// - Lines: 19
/// - Coverage: 100%
contract BranchesNew {
    event Branch(uint256 n);

    function branchRequire(bool increment) external {
        // Should be treated as a branch
        require(increment);

        emit Branch(2);
    }
}

contract BranchesNew2 {
    event Branch(uint256 n);

    function branchRequire(bool increment) external {
        // Should be treated as a branch
        require(increment);

        emit Branch(2);
    }
}