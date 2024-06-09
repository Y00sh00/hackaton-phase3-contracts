//// SPDX-License-Identifier: MIT
//pragma solidity >=0.8.0;
//import { Script } from "forge-std/Script.sol";
//import { console } from "forge-std/console.sol";
//
//import { IVendingMachine } from "../src/codegen/world/IVendingMachine.sol";
//import { RatioConfig } from "../src/codegen/tables/RatioConfig.sol";
//import { IWorld } from "../src/codegen/world/IWorld.sol";
//
//contract ExecuteVendingMachine is Script {
//  function run(address worldAddress) external {
//    // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
//    // uint256 playerPrivateKey = vm.envUint("PRIVATE_KEY");
//
//    uint256 ephemeralPrivateKey = uint256(0xbbe5cced0eaf62244dd3ec0021fcd8341213fd9dba577015e28ccf0e9a032b25);
//    address ephemeralOwner = address(0x5B7780bB5F79EaCF04Ea4710BEA16159D0e4Dab4);
//    vm.startBroadcast(ephemeralPrivateKey);
//
//    //Read from .env
//    uint256 smartStorageUnitId = vm.envUint("SSU_ID");
//    uint256 itemIn = vm.envUint("ITEM_IN_ID");
//
//    //The method below will change based on the namespace you have configurd. If the namespace is changed, make sure to update the method name
//    IVendingMachine(worldAddress).kalb_v22__executeVendingMachine(smartStorageUnitId, 1, itemIn);
//
//    vm.stopBroadcast();
//  }
//}
