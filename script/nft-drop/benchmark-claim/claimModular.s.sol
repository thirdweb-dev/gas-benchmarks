// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {LibClone} from "@solady/utils/LibClone.sol";

contract BenchmarkModularNFTDrop_Claim is Script {
    

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        vm.stopBroadcast();
    }
}
