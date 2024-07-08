// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {LibClone} from "@solady/utils/LibClone.sol";
import {DropERC721} from "@thirdweb-dev/contracts/prebuilts/drop/DropERC721.sol";

contract BenchmarkLegacyNFTDrop_Initialize is Script {
    DropERC721 public drop;

    address public owner;

    address public impl;
    address[] public forwarders;

    function setUp() public {
        owner = address(0x1234);
        impl = address(new DropERC721());
    }

    function run() public {
        vm.startBroadcast();

        drop = DropERC721(payable (LibClone.clone(impl)));
        drop.initialize(owner, "Test", "TEST", "", forwarders, owner, owner, 100, 100, owner);

        vm.stopBroadcast();
    }
}
