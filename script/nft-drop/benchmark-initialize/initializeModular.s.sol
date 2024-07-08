// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {LibClone} from "lib/solady/src/utils/LibClone.sol";
import {ERC721CoreInitializable} from "modular-contracts/src/core/token/ERC721CoreInitializable.sol";
import {BatchMetadataERC721} from "modular-contracts/src/extension/token/metadata/BatchMetadataERC721.sol";
import {DelayedRevealBatchMetadataERC721} from "modular-contracts/src/extension/token/metadata/DelayedRevealBatchMetadataERC721.sol";
import {ClaimableERC721} from "modular-contracts/src/extension/token/minting/ClaimableERC721.sol";
import {RoyaltyERC721} from "modular-contracts/src/extension/token/royalty/RoyaltyERC721.sol";
import {TransferableERC721} from "modular-contracts/src/extension/token/transferable/TransferableERC721.sol";

contract BenchmarkModularNFTDrop_Initialize is Script {
    ERC721CoreInitializable public core;

    address public owner;

    address public coreImpl;

    address public batchMetadataImpl;
    address public delayedRevealImpl;
    address public claimableImpl;
    address public royaltyImpl;
    address public transferableImpl;

    address[] public extensions;
    bytes[] public extensionInstallData;

    function setUp() public {
        owner = address(0x1234);

        address coreImpl = address(new ERC721CoreInitializable());
        
        batchMetadataImpl = address(new BatchMetadataERC721());
        extensions.push(batchMetadataImpl);
        extensionInstallData.push("");

        delayedRevealImpl = address(new DelayedRevealBatchMetadataERC721());
        extensions.push(delayedRevealImpl);
        extensionInstallData.push("");

        claimableImpl = address(new ClaimableERC721());
        extensions.push(claimableImpl);
        extensionInstallData.push("");

        royaltyImpl = address(new RoyaltyERC721());
        extensions.push(royaltyImpl);
        extensionInstallData.push(abi.encode(owner, uint256(100)));

        transferableImpl = address(new TransferableERC721());
        extensions.push(transferableImpl);
        extensionInstallData.push("");
    }

    function run() public {
        vm.startBroadcast();

        core = ERC721CoreInitializable(payable (LibClone.clone(coreImpl)));
        core.initialize("Test", "TEST", "", owner, extensions, extensionInstallData);

        vm.stopBroadcast();
    }
}
