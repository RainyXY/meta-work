// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
contract arrayMerger {
    //5.合并两个有序数组(Merge Sorted Array)
    function run(
        uint[] memory arr1,
        uint[] memory arr2
    ) external pure returns (uint[] memory arrMerge) {
        uint len1 = arr1.length;
        uint len2 = arr2.length;
        arrMerge = new uint[](len1 + len2);

        uint i = 0;
        uint j = 0;
        uint k = 0;

        while (i < len1 && j < len2) {
            if (arr1[i] < arr2[j]) {
                arrMerge[k++] = arr1[i++];
            } else {
                arrMerge[k++] = arr2[j++];
            }
        }

        while (i < len1) {
            arrMerge[k++] = arr1[i++];
        }
        while (j < len2) {
            arrMerge[k++] = arr2[j++];
        }

        return arrMerge;
    }
}
