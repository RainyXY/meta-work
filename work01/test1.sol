// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
contract Voting {
    // 1.创建一个名为Voting的合约，包含以下功能:
    // 一个mapping来存储候选人的得票数
    // 一个vote函数，允许用户投票给某个候选人
    // 一个getVotes函数，返回某个候选人的得票数
    // 一个resetVotes函数，重置所有候选人的得票数
    mapping(string => uint256) private candidateVotes;

    event Voted(string indexed candidate, uint256 votes);

    function vote(string memory candidate) external {
        candidateVotes[candidate] += 1;
        emit Voted(candidate, candidateVotes[candidate]);
    }

    function getVotes(string memory candidate) external view returns (uint256) {
        return candidateVotes[candidate];
    }
    function resetVotes(string[] memory candidates) external {
        for (uint256 i = 0; i < candidates.length; i++) {
            candidateVotes[candidates[i]] = 0;
        }
    }
}
