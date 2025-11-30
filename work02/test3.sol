// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
// =====提交的测试合约地址：0xD31f44e3C93cB349BD3aFAD9725Bca50C410b27c======
// 任务目标
// 1. 使用 Solidity 编写一个合约，允许用户向合约地址发送以太币。
// 2. 记录每个捐赠者的地址和捐赠金额。
// 3. 允许合约所有者提取所有捐赠的资金。

// 任务步骤
// 1. 编写合约
//   - 创建一个名为 BeggingContract 的合约。
//   - 合约应包含以下功能：
//   - 一个 mapping 来记录每个捐赠者的捐赠金额。
//   - 一个 donate 函数，允许用户向合约发送以太币，并记录捐赠信息。
//   - 一个 withdraw 函数，允许合约所有者提取所有资金。
//   - 一个 getDonation 函数，允许查询某个地址的捐赠金额。
//   - 使用 payable 修饰符和 address.transfer 实现支付和提款。
// 2. 部署合约
//   - 在 Remix IDE 中编译合约。
//   - 部署合约到 Goerli 或 Sepolia 测试网。
// 3. 测试合约
//   - 使用 MetaMask 向合约发送以太币，测试 donate 功能。
//   - 调用 withdraw 函数，测试合约所有者是否可以提取资金。
//   - 调用 getDonation 函数，查询某个地址的捐赠金额。

// 任务要求
// 1. 合约代码：
//   - 使用 mapping 记录捐赠者的地址和金额。
//   - 使用 payable 修饰符实现 donate 和 withdraw 函数。
//   - 使用 onlyOwner 修饰符限制 withdraw 函数只能由合约所有者调用。
// 2. 测试网部署：
//   - 合约必须部署到 Goerli 或 Sepolia 测试网。
// 3. 功能测试：
//   - 确保 donate、withdraw 和 getDonation 函数正常工作。
contract BeggingContract{
    address public immutable owner;  
    mapping(address => uint256) public donations;

    modifier onlyOwner(){
        require(msg.sender == owner, "Begging not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    event DonationReceived(address indexed donor, uint256 amount);
    event Withdrawn(address indexed owner, uint256 amount);

    function donate() external payable {
         require(msg.value > 0, "Begging zero");
         donations[msg.sender] += msg.value;
         emit DonationReceived(msg.sender,msg.value);
    }
    function withdraw() external payable onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "Begging no balance");
        emit Withdrawn(owner,balance);

        (bool success, )= owner.call{value: balance}("");
        require(success, "Begging call failed");
    }

    function getDonation(address _donor) external view returns(uint256) {
        return donations[_donor];
    }

    // 查看总余额
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}