// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.15;

import "src/Contract.sol";

contract ImportedLibraryUser {
    function run() external {
        // should be marked as covered
        InternalLibrary.addLtTen(5, 6);
    }
}
