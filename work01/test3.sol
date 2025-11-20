// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
contract intToRoman {
    // 用 solidity 实现整数转罗马数字 题目描述在 https://leetcode.cn/problems/roman-to-integer/description/
    function run(uint256 num) external pure returns (string memory) {
        require(num > 0 && num < 4000, "Roman: out of range");
        // 降序表，完全对标 JS 版本
        uint16[13] memory vals = [
            1000,
            900,
            500,
            400,
            100,
            90,
            50,
            40,
            10,
            9,
            5,
            4,
            1
        ];
        bytes[13] memory syms = [
            bytes("M"),
            bytes("CM"),
            bytes("D"),
            bytes("CD"),
            bytes("C"),
            bytes("XC"),
            bytes("L"),
            bytes("XL"),
            bytes("X"),
            bytes("IX"),
            bytes("V"),
            bytes("IV"),
            bytes("I")
        ];

        // 先计算最终长度，一次性分配内存
        uint256 len;
        uint256 tmp = num;
        for (uint8 i = 0; i < 13; ++i) {
            while (tmp >= vals[i]) {
                tmp -= vals[i];
                len += syms[i].length;
            }
            if (tmp == 0) break;
        }

        // 组装结果
        bytes memory res = new bytes(len);
        uint256 idx;
        for (uint8 i = 0; i < 13; ++i) {
            while (num >= vals[i]) {
                bytes memory sym = syms[i];
                for (uint256 j = 0; j < sym.length; ++j) {
                    res[idx++] = sym[j];
                }
                num -= vals[i];
            }
            if (num == 0) break;
        }
        return string(res);
    }
}
