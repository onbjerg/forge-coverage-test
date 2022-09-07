// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.15;

import "src/Contract.sol";

contract ImportedLibraryUser {
    // junk so the identifier works
    function asdfghjklmnopqrstuvwxyz() external {
        // should be marked as covered
        InternalLibrary.addLtTen(5, 6);
    }

    function askfjdlasfklasjgfklsdjgsdklgjskldgjksdlgjk() external {
        // should not be covered
        revert("yooooooooooooooooooooooo");
    }
}
