//// SPDX-License-Identifier: MIT
//pragma solidity >=0.8.0;
//
//import {Script} from "forge-std/Script.sol";
//import {console} from "forge-std/console.sol";
//import {IMascotSystem} from "../src/codegen/world/IMascotSystem.sol";
//import {BaseCosmeticData} from "../src/codegen/tables/BaseCosmetic.sol";
//
//contract ConfigureAvailableCosmetics is Script {
//    function run(address worldAddress) external {
//        // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
//        uint256 playerPrivateKey = vm.envUint("PRIVATE_KEY");
//        vm.startBroadcast(playerPrivateKey);
//
//        // Assign values
//        string memory slotName = "Legs";
//        string memory componentName = "mino-legs-1";
//        int256 zIndex = 0;
//        string memory displayName = "Default Legs";
//        int256 x = 0;
//        int256 y = 0;
//
//        // Interact with the MascotSystem contract through the world address
//        uint256 entityId = IMascotSystem(worldAddress).kalb_v22__setCosmeticData(slotName, componentName, zIndex, displayName, x, y);
//        console.log("Generated entityId:", entityId);
//
//        vm.stopBroadcast();
//    }
//}
//
//contract GetCosmeticData is Script {
//    function run(address worldAddress) external {
//        // Interact with the MascotSystem contract through the world address
//        BaseCosmeticData memory cosmeticData = IMascotSystem(worldAddress).kalb_v22__getCosmeticData(2);
//
//        console.log("CosmeticData for entityId 1:");
//        console.log("Component Name:", cosmeticData.componentName);
//    }
//}
//
//contract GetAllEntityIds is Script {
//    function run(address worldAddress) external {
//        // Interact with the MascotSystem contract through the world address
//        uint256[] memory entityIds = IMascotSystem(worldAddress).kalb_v22__getAllEntityIds();
//
//        console.log("All entity IDs:");
//        for (uint256 i = 0; i < entityIds.length; i++) {
//            console.log(entityIds[i]);
//        }
//    }
//}
//
//contract GetAllCosmeticData is Script {
//    function run(address worldAddress) external {
//        // Interact with the MascotSystem contract through the world address
//        BaseCosmeticData[] memory allData = IMascotSystem(worldAddress).kalb_v22__getAllCosmeticData();
//
//        for (uint256 i = 0; i < allData.length; i++) {
//            console.log("Cosmetic Data for entityId", i);
//            console.log("Slot Name:", allData[i].slotName);
//            console.log("Component Name:", allData[i].componentName);
////            console.log("zIndex:", allData[i].zIndex);
////            console.log("Display Name:", allData[i].displayName);
////            console.log("x:", allData[i].x);
////            console.log("y:", allData[i].y);
//        }
//    }
//}