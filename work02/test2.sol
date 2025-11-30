// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
// =====提交的测试合约地址：0x2515D7B8c96EbBC138188cbC7d2872DDF8606d0d======
// 任务步骤
// 1. 编写 NFT 合约
//   - 使用 OpenZeppelin 的 ERC721 库编写一个 NFT 合约。
//   - 合约应包含以下功能：
//   - 构造函数：设置 NFT 的名称和符号。
//   - mintNFT 函数：允许用户铸造 NFT，并关联元数据链接（tokenURI）。
//   - 在 Remix IDE 中编译合约。
// 2. 准备图文数据
//   - 准备一张图片，并将其上传到 IPFS（可以使用 Pinata 或其他工具）。
//   - 创建一个 JSON 文件，描述 NFT 的属性（如名称、描述、图片链接等）。
//   - 将 JSON 文件上传到 IPFS，获取元数据链接。
//   - JSON文件参考 https://docs.opensea.io/docs/metadata-standards
// 3. 部署合约到测试网
//   - 在 Remix IDE 中连接 MetaMask，并确保 MetaMask 连接到 Goerli 或 Sepolia 测试网。
//   - 部署 NFT 合约到测试网，并记录合约地址。
// 4. 铸造 NFT
//   - 使用 mintNFT 函数铸造 NFT：
//   - 在 recipient 字段中输入你的钱包地址。
//   - 在 tokenURI 字段中输入元数据的 IPFS 链接。
//   - 在 MetaMask 中确认交易。
// 5. 查看 NFT
//   - 打开 OpenSea 测试网 或 Etherscan 测试网。
//   - 连接你的钱包，查看你铸造的 NFT。
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract MyNFT is ERC721Enumerable {
    mapping(uint256 => string) internal _tokenURIs;
    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

    function mintNFT(address recipient, string memory _tokenURI) external {
        uint256 tokenId = totalSupply() + 1;
        _tokenURIs[tokenId] = _tokenURI;
        _safeMint(recipient, tokenId);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);

        return _tokenURIs[tokenId];
    }
}