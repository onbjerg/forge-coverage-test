// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.15;

contract ExtraFileContract1 {
    event ExtraFileEvent(uint256 n);

    function compute(bool increment) external {
        // Should be treated as a branch
        require(increment);

        emit ExtraFileEvent(2);
    }
}

contract ExtraFileContract2 {
    // BUG (?): If we would call this event `ExtraFileEvent(uint256 n)`
    // then the compute function below would not be covered.
    event ExtraFileEvent();

    function compute(bool increment) external {
        // Should be treated as a branch
        require(increment);

        emit ExtraFileEvent();
    }
}