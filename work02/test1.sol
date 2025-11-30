// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
// =====提交的测试合约地址：0x1Dc09EcD5276887BB496fA7D6C3dFA9D9552395A======
// 实现一个简单的 ERC20 代币合约。
// 要求：
// 1. 合约包含以下标准 ERC20 功能：
// - balanceOf：查询账户余额。
// - transfer：转账。
// - approve 和 transferFrom：授权和代扣转账。
// 2. 使用 event 记录转账和授权操作。
// 3. 提供 mint 函数，允许合约所有者增发代币。
// 提示：
// - 使用 mapping 存储账户余额和授权信息。
// - 使用 event 定义 Transfer 和 Approval 事件。
// 4. 部署到sepolia 测试网，导入到自己的钱包
contract SimpleERC20{
    // 账户余额映射
    mapping (address => uint256) public _balances;
    mapping(address => mapping(address => uint256)) public _allowances;

    uint256 public totalSupply;
    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    event Transfer(address indexed from, address indexed to,uint256 value);
    event Approval(address indexed owner, address indexed spender,uint256 value);
    
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(_balances[msg.sender] >= value, "balance low");
        _balances[msg.sender] -= value;
        _balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    function approve(address spender, uint256 value) public returns (bool) {
        _allowances[msg.sender][spender]=value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(_balances[from] >= value && _allowances[from][msg.sender] >= value, "balance low");
        _balances[from] -= value;
        _balances[to] += value;
        _allowances[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    function mint(uint256 value) external {
        require(msg.sender == owner, "not owner");
        totalSupply += value;
        _balances[msg.sender] += value;
        emit Transfer(address(0), msg.sender, value);
    }
}