// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
contract romanToInt {
    // 用 solidity 实现罗马数字转数整数 题目描述在 https://leetcode.cn/problems/integer-to-roman/description/
    function _val(bytes1 c) internal pure returns (uint256) {
        if (c == "I") return 1;
        if (c == "V") return 5;
        if (c == "X") return 10;
        if (c == "L") return 50;
        if (c == "C") return 100;
        if (c == "D") return 500;
        if (c == "M") return 1000;
        revert("Invalid Roman char");
    }
    function run(string memory s) external pure returns (uint256 result) {
        uint256 len = bytes(s).length;
        bytes memory _s = bytes(s);

        for (uint256 i = 0; i < len; ) {
            uint256 cur = _val(_s[i]);
            uint256 next = i + 1 < len ? _val(_s[i + 1]) : 0;

            if (cur < next) {
                result += next - cur; // 减法组合 IV、IX …
                i += 2; // 一次消耗两个字符
            } else {
                result += cur;
                i += 1;
            }
        }
        // 可选：限制最大值 3999
        if (result == 0 || result > 3999) revert("Out of range");
    }
}
