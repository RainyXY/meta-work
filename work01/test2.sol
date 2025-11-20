// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
contract reverse {
    // 反转字符串(Reverse String)
    function run2(string memory s) external pure returns (string memory) {
        bytes memory b = bytes(s);
        uint left = 0;
        uint right = b.length - 1;
        while (left < right) {
            (b[left], b[right]) = (b[right], b[left]);
            ++left;
            --right;
        }
        return string(b);
    }
    function run(string calldata s) external pure returns (string memory) {
        bytes memory b = bytes(s);
        uint256 len = b.length;
        bytes memory r = new bytes(len);
        for (uint256 i = 0; i < len; ++i) {
            r[i] = b[len - 1 - i];
        }
        return string(r);
    }
}
