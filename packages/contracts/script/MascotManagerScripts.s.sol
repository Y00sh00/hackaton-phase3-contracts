// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {IMascotManager} from "../src/codegen/world/IMascotManager.sol";
import {IMascotCreator} from "../src/codegen/world/IMascotCreator.sol";
import {MascotData} from "../src/codegen/tables/Mascot.sol";
import {SlotData} from "../src/codegen/tables/Slot.sol";
import {TraitData} from "../src/codegen/tables/Trait.sol";
import {MascotSystemSettings, MascotSystemSettingsData} from "../src/codegen/tables/MascotSystemSettings.sol";
import {FullMascotData} from "../src/systems/mascot_manager/structs/FullMascotData.sol";
import {OwnAbleTraitData} from "../src/systems/mascot_manager/structs/OwnAbleTraitData.sol";
import {ResourceId} from "@latticexyz/store/src/ResourceId.sol";
import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {StoreSwitch} from "@latticexyz/store/src/StoreSwitch.sol";
import {IBaseWorld} from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";
import {PuppetModule} from "@latticexyz/world-modules/src/modules/puppet/PuppetModule.sol";
import {IERC721Mintable} from "@latticexyz/world-modules/src/modules/erc721-puppet/IERC721Mintable.sol";
import {ERC721Module} from "@latticexyz/world-modules/src/modules/erc721-puppet/ERC721Module.sol";
import {registerERC721} from "@latticexyz/world-modules/src/modules/erc721-puppet/registerERC721.sol";
import {ERC721System} from "@latticexyz/world-modules/src/modules/erc721-puppet/ERC721System.sol";
import {ERC721MetadataData} from "@latticexyz/world-modules/src/modules/erc721-puppet/tables/ERC721Metadata.sol";
import {ERC721System} from "@latticexyz/world-modules/src/modules/erc721-puppet/ERC721System.sol";
import {Owners} from "@latticexyz/world-modules/src/modules/erc721-puppet/tables/Owners.sol";
import {_ownersTableId} from "@latticexyz/world-modules/src/modules/erc721-puppet/utils.sol";
import {Puppet} from "@latticexyz/world-modules/src/modules/puppet/Puppet.sol";
import {IERC721} from "@eveworld/world/src/modules/eve-erc721-puppet/IERC721.sol";

contract AddTraitOptions is Script {
    function run(address worldAddress) external {
        uint256 playerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(playerPrivateKey);
        address playerAddress = vm.addr(playerPrivateKey);

        uint256 bodyColorTrait1 = IMascotCreator(worldAddress).kalb_v22__createTrait("bodyColor", "light-grey", "grey");
        uint256 bodyColorTrait2 = IMascotCreator(worldAddress).kalb_v22__createTrait("bodyColor", "brown", "#724035");
        uint256 bodyColorTrait3 = IMascotCreator(worldAddress).kalb_v22__createTrait("bodyColor", "dark-red", "#942712");
        uint256 bodyColorTrait4 = IMascotCreator(worldAddress).kalb_v22__createTrait("bodyColor", "yellow", "#c29e0e");

        console.log("light-grey", bodyColorTrait1);
        console.log("brown", bodyColorTrait2);
        console.log("dark-red", bodyColorTrait3);
        console.log("yellow", bodyColorTrait4);

        vm.stopBroadcast();
    }
}

contract AddSlotOptions is Script {
    function run(address worldAddress) external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // Empty slot to assign to components without slots
        uint256[] memory emptySlots;

        // Create Stand Alone Slots
        uint256 lastId;

        // Body
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("MainBody", "mino-body-1", "Body (Default)", 0, 0, emptySlots, "default");
        console.log("Default Body", lastId);

        // Belts
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Belt", "body-empty", "Empty", 0, 0, emptySlots, "default");
        console.log("Belt Empty", lastId);

        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Belt", "mino-belt-1", "Belt (Default)", 0, 0, emptySlots, "7");
        console.log("Belt Default", lastId);

        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Belt", "mino-belt-1", "Belt (Yellow)", 0, 0, emptySlots, "7,#faac22");
        console.log("Belt Yellow", lastId);

        // Arms
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Arms", "mino-arms-1", "Arms (Default)", 0, 0, emptySlots, "null");
        console.log("Arms Default", lastId);
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Arms", "mino-arms-2", "Arms (Wraps)", 0, 0, emptySlots, "null");
        console.log("Arms Wraps", lastId);
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Arms", "mino-arms-2", "Arms (Blue Wraps)", 0, 0, emptySlots, "null, #0c2d59");
        console.log("Arms Blue Wraps", lastId);

        // Horns
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Horns", "body-empty", "Empty", 0, 0, emptySlots, "default");
        console.log("Empty Horns", lastId);
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Horns", "mino-horns-1", "Horns (Default)", 0, 0, emptySlots, "null");
        console.log("Default Horns", lastId);
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Horns", "mino-horns-1", "Horns (Gold)", 0, 0, emptySlots, "null,#dbb045");
        console.log("Golden Horns", lastId);

        // Legs
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Legs", "mino-legs-1", "Default", 0, 0, emptySlots, "default");
        console.log("Default legs", lastId);
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Legs", "mino-legs-1", "Default (Gold Hoofs)", 0, 0, emptySlots, "default,#dbb045");
        console.log("Gold Hoods", lastId);

        // Pants
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Pants", "mino-pants-1", "Default", 0, 0, emptySlots, "default");
        console.log("Pants Default", lastId);
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Pants", "mino-pants-1", "Pants (Blue)", 0, 0, emptySlots, "6,#0c2d59");
        console.log("Pants Blue", lastId);

        // Create Mouth Slot & Head
        // Nose
        uint256 noseDefault = IMascotCreator(worldAddress).kalb_v22__createSlot("Nose_Accessory", "body-empty", "Empty", 0, 0, emptySlots, "default");
        console.log("Empty Nose Accessory", noseDefault);
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Nose_Accessory", "mino-nosering-1", "Nose Ring (Gold)", 0, 0, emptySlots, "8,#dbb045");
        console.log("Nose Ring Gold", lastId);
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Nose_Accessory", "mino-nosering-1", "Nose Ring (Silver)", 0, 0, emptySlots, "8,grey");
        console.log("Nose Ring Silver", lastId);

        // Beard
        uint256 beardDefault = IMascotCreator(worldAddress).kalb_v22__createSlot("Beard", "body-empty", "Empty", 0, 0, emptySlots, "default");
        console.log("Empty Beard", beardDefault);
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Beard", "mino-gotee-1", "Small Gotee (Brown)", 0, 0, emptySlots, "8");
        console.log("Small Gotee Brown", lastId);
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Beard", "mino-gotee-1", "Small Gotee (Grey)", 0, 0, emptySlots, "8,grey");
        console.log("Small Gotee Grey", lastId);

        // Mouth
        uint256[] memory defaultMouthSlots = new uint256[](2);
        defaultMouthSlots[0] = noseDefault;
        defaultMouthSlots[1] = beardDefault;

        uint256 mouthDefault = IMascotCreator(worldAddress).kalb_v22__createSlot("Mouth", "mino-mouth-1", "Mouth (Default)", 0, 0, defaultMouthSlots, "7");
        console.log("Mouth Default", mouthDefault);

        // Eyes
        uint256 eyesDefault = IMascotCreator(worldAddress).kalb_v22__createSlot("Eyes", "mino-eye-1", "Eyes (Angry)", 0, 0, emptySlots, "7");
        console.log("Eyes Default", eyesDefault);
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Eyes", "mino-eye-2", "Eyes (Hurt)", 0, 0, emptySlots, "7");
        console.log("Closed Eyes", lastId);

        // Hair
        uint256 hairDefault = IMascotCreator(worldAddress).kalb_v22__createSlot("Hair", "body-empty", "Empty", 0, 0, emptySlots, "default");
        console.log("Hair empty Default", hairDefault);
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Hair", "mino-hair-1", "Hair (Pony)", 0, 0, emptySlots, "default");
        console.log("Hair Pony", lastId);
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Hair", "mino-hair-1", "Hair (Gold Pony)", 0, 0, emptySlots, "default,#faac22,#0c2d59");
        console.log("Hair Gold Pony", lastId);

        // Ears
        uint256 earsDefault = IMascotCreator(worldAddress).kalb_v22__createSlot("Ears", "mino-ear-1", "Ears (Default)", 0, 0, emptySlots, "7,grey");
        console.log("Hair empty Default", earsDefault);

        // Head
        uint256[] memory defaultHeadSlots = new uint256[](4);
        defaultHeadSlots[0] = hairDefault;
        defaultHeadSlots[1] = eyesDefault;
        defaultHeadSlots[2] = earsDefault;
        defaultHeadSlots[3] = mouthDefault;

        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Head", "mino-head-1", "Head (Default)", 0, 0, defaultHeadSlots, "6");
        console.log("Head Default", lastId);

        // Hands
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("LeftHand", "mino-left-hand-1", "Default", 0, 0, emptySlots, "3");
        console.log("Left Hand Default", lastId);

        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("RightHand", "mino-right-hand-1", "Default", 0, 0, emptySlots, "8");
        console.log("Right Hand Default", lastId);

        vm.stopBroadcast();
    }
}


contract AddCampaignReward is Script {
    function run(address worldAddress) external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // Empty slot to assign to components without slots
        uint256[] memory emptySlots;

        // Create Stand Alone Slots
        uint256 lastId;

        // Arms
        lastId = IMascotCreator(worldAddress).kalb_v22__createSlot("Arms", "mino-arms-3", "Arms (Phase 3 Limited)", 0, 0, emptySlots, "null");
        console.log("Arms (Phase 3 Limited)", lastId);

        vm.stopBroadcast();
    }
}

contract CreateMascot is Script {
    function run(address worldAddress) external {
        // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
        uint256 playerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(playerPrivateKey);
        address playerAddress = vm.addr(playerPrivateKey);

        console.log("sender is", playerAddress);

        IMascotCreator(worldAddress).kalb_v22__createMascot(playerAddress, "Taury", "taury");
        vm.stopBroadcast();
    }
}

contract GetUserFullMascots is Script {
    function run(address worldAddress) external {
        uint256 playerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(playerPrivateKey);
        address playerAddress = vm.addr(playerPrivateKey);

        FullMascotData[] memory mascots = IMascotManager(worldAddress).kalb_v22__getFullUserMascots(playerAddress);
        if (mascots.length == 0) {
            console.log("No mascots found");
        } else {
            console.log(mascots[0].name);
        }
        vm.stopBroadcast();
    }
}

contract GetAllTraits is Script {
    function run(address worldAddress) external {
        uint256 playerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(playerPrivateKey);
        address playerAddress = vm.addr(playerPrivateKey);

        OwnAbleTraitData[] memory traits = IMascotManager(worldAddress).kalb_v22__getAllTraits();
        if (traits.length == 0) {
            console.log("No mascots found");
        }
        vm.stopBroadcast();
    }
}

contract GetMascotWithID is Script {
    function run(address worldAddress) external {
        uint256 playerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(playerPrivateKey);
        address playerAddress = vm.addr(playerPrivateKey);

        MascotData memory data = IMascotManager(worldAddress).kalb_v22__getMascot(4);
        console.log(data.name);

        vm.stopBroadcast();
    }
}

contract GetUserMascots is Script {
    function run(address worldAddress) external {
        uint256 playerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(playerPrivateKey);
        address playerAddress = vm.addr(playerPrivateKey);

        uint256[] memory data = IMascotManager(worldAddress).kalb_v22__getUserMascots(playerAddress);
        console.log(data.length);

        vm.stopBroadcast();
    }
}

contract Setup is Script {
    function run(address worldAddress) external {
        uint256 playerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(playerPrivateKey);
        address playerAddress = vm.addr(playerPrivateKey);

        MascotSystemSettingsData memory table = IMascotManager(worldAddress).kalb_v22__setup();
        console.log("traitId", table.currentTraitId);
        console.log("slotId", table.currentSlotId);
        console.log("mascotId", table.currentMascotId);
        console.log("currentCosmeticSlotId", table.currentCosmeticSlotId);
        console.log("currentCosmeticTraitId", table.currentCosmeticTraitId);
        vm.stopBroadcast();
    }
}

//contract GetSettings is Script {
//    function run(address worldAddress) external {
//        uint256 playerPrivateKey = vm.envUint("PRIVATE_KEY");
//        vm.startBroadcast(playerPrivateKey);
//        address playerAddress = vm.addr(playerPrivateKey);
//
//        MascotSystemSettingsData memory table = IMascotManager(worldAddress).kalb_v22___getSettings();
//        console.log("trait id", table.currentTraitId);
//        console.log("slot id", table.currentSlotId);
//        console.log("current mascot id", table.currentMascotId);
//
//        vm.stopBroadcast();
//    }
//}

//

contract SetupMintNFTs is Script {
    function run(address worldAddress) external {
        StoreSwitch.setStoreAddress(worldAddress);
        IBaseWorld world = IBaseWorld(worldAddress);
        uint256 playerPrivateKey = vm.envUint("PRIVATE_KEY");
        address playerAddress = vm.addr(playerPrivateKey);

        // Private Key loaded from environment
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // Mascot NFT
        {
            string memory namespace = "kalb_msct_v1";
            // Namespace must be <14chars and unique
            string memory name = "Mascot";
            string memory symbol = "MSCT";
            string memory baseURI = "https://pandemic-horde.org/nft/MSCT/";

            IERC721Mintable erc721Token;
            StoreSwitch.setStoreAddress(address(world));
            erc721Token = registerERC721(
                world,
                stringToBytes14(namespace),
                ERC721MetadataData({name: name, symbol: symbol, baseURI: baseURI})
            );

            console.log("Deploying ERC721 (Mascot) token with address: ", address(erc721Token));
        }

        // Trait NFT
        {
            string memory namespace = "kalb_trt_v1";
            // Namespace must be <14chars and unique
            string memory name = "Trait";
            string memory symbol = "TRT";
            string memory baseURI = "https://pandemic-horde.org/nft/TRT/";

            IERC721Mintable erc721Token;
            StoreSwitch.setStoreAddress(address(world));
            erc721Token = registerERC721(
                world,
                stringToBytes14(namespace),
                ERC721MetadataData({name: name, symbol: symbol, baseURI: baseURI})
            );

            console.log("Deploying ERC721 (TRT) token with address: ", address(erc721Token));
        }

        // Slot NFT
        {
            string memory namespace = "kalb_slt_v1";
            // Namespace must be <14chars and unique
            string memory name = "Slot";
            string memory symbol = "SLT";
            string memory baseURI = "https://pandemic-horde.org/nft/SLT/";

            IERC721Mintable erc721Token;
            StoreSwitch.setStoreAddress(address(world));
            erc721Token = registerERC721(
                world,
                stringToBytes14(namespace),
                ERC721MetadataData({name: name, symbol: symbol, baseURI: baseURI})
            );

            console.log("Deploying ERC721 (SLT) token with address: ", address(erc721Token));
        }
        vm.stopBroadcast();
    }

    function stringToBytes14(string memory str) public pure returns (bytes14) {
        bytes memory tempBytes = bytes(str);

        // Ensure the bytes array is not longer than 14 bytes.
        // If it is, this will truncate the array to the first 14 bytes.
        // If it's shorter, it will be padded with zeros.
        require(tempBytes.length <= 14, "String too long");

        bytes14 converted;
        for (uint i = 0; i < tempBytes.length; i++) {
            converted |= bytes14(tempBytes[i] & 0xFF) >> (i * 8);
        }

        return converted;
    }

    function mintNFTToUser(IERC721Mintable erc721Token, address user) internal {
        uint256 tokenId = 1; // Example tokenId
        erc721Token.safeMint(user, tokenId);
        console.log("Minted NFT to user with address: ", user);
    }
}

contract NFTCreationTest is Script {
    function run(address worldAddress) external {
        StoreSwitch.setStoreAddress(worldAddress);
        IBaseWorld world = IBaseWorld(worldAddress);
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address playerAddress = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        IERC721Mintable(0x8A706F5ac4da24957a3a139c9e4167db62Ff45d1).mint(playerAddress, 2);

        vm.stopBroadcast();
    }
}

contract NFTTest is Script {
    function run(address worldAddress) external {
        StoreSwitch.setStoreAddress(worldAddress);
        IBaseWorld world = IBaseWorld(worldAddress);
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address playerAddress = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        address owner = IERC721(0x8A706F5ac4da24957a3a139c9e4167db62Ff45d1).ownerOf(1);
        console.log("owner", owner);

        vm.stopBroadcast();
    }
}


contract CheckNFTOwnership is Script {
    function run(address worldAddress) external {
        // Load private key from environment
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        IBaseWorld world = IBaseWorld(worldAddress);

        vm.startBroadcast(deployerPrivateKey);
        StoreSwitch.setStoreAddress(address(worldAddress));
        ResourceId tableId = _ownersTableId(this.stringToBytes14("mascot_v22"));
        address test = Owners.get(tableId, 1);
        console.log(test);

        vm.stopBroadcast();
    }

    function stringToBytes14(string memory str) public pure returns (bytes14) {
        bytes memory tempBytes = bytes(str);

        // Ensure the bytes array is not longer than 14 bytes.
        // If it is, this will truncate the array to the first 14 bytes.
        // If it's shorter, it will be padded with zeros.
        require(tempBytes.length <= 14, "String too long");

        bytes14 converted;
        for (uint i = 0; i < tempBytes.length; i++) {
            converted |= bytes14(tempBytes[i] & 0xFF) >> (i * 8);
        }

        return converted;
    }
}
