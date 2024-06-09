// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Mascot, MascotData} from "../../codegen/tables/Mascot.sol";
import {MascotTraitChanges, MascotTraitChangesData} from "../../codegen/tables/MascotTraitChanges.sol";
import {OwnedSlots, OwnedSlotsData} from "../../codegen/tables/OwnedSlots.sol";
import {OwnedTraits, OwnedTraitsData} from "../../codegen/tables/OwnedTraits.sol";
import {MascotSlotChanges} from "../../codegen/tables/MascotSlotChanges.sol";
import {Slot, SlotData} from "../../codegen/tables/Slot.sol";
import {Trait, TraitData} from "../../codegen/tables/Trait.sol";
import {MascotSystemSettings, MascotSystemSettingsData} from "../../codegen/tables/MascotSystemSettings.sol";
import {UserMascots} from "../../codegen/tables/UserMascots.sol";
import {FullMascotData} from "./structs/FullMascotData.sol";
import {FullSlotData} from "./structs/FullSlotData.sol";
import {ResourceId} from "@latticexyz/store/src/ResourceId.sol";
import {SlotChange} from "./structs/SlotChange.sol";
import {OwnAbleTraitData} from "./structs/OwnAbleTraitData.sol";
import {OwnAbleSlotData} from "./structs/OwnAbleSlotData.sol";
import {SquareBaseSystem} from "./SquareBaseSystem.sol";

contract MascotManager is SquareBaseSystem {

    function getMascot(uint256 mascotId) public returns (MascotData memory) {
        return Mascot.get(mascotId);
    }

    function addSlotToMascot(uint256 mascotId, uint256 slotId) public {
        Mascot.pushSlots(mascotId, slotId);
    }

    function getSlot(uint256 slotId) public returns (SlotData memory) {
        return Slot.get(slotId);
    }

    function getTrait(uint256 traitId) public returns (TraitData memory) {
        return Trait.get(traitId);
    }


    function getUserMascots(address user) public returns (uint256[] memory) {
        return UserMascots.get(user);
    }

    function getFullSlots(uint256[] memory sourceSlots) public returns (FullSlotData[] memory) {
        FullSlotData[] memory targetSlots = new FullSlotData[](sourceSlots.length);

        for (uint256 j = 0; j < sourceSlots.length; j++) {
            // Source Slot
            SlotData memory slot = Slot.get(sourceSlots[j]);

            // Target Slot
            FullSlotData memory fullSlotData;
            fullSlotData.selectedComponent = slot.selectedComponent;
            fullSlotData.properties = slot.properties;
            fullSlotData.displayName = slot.displayName;
            fullSlotData.id = slot.id;
            fullSlotData.slotName = slot.slotName;
            fullSlotData.x = slot.x;
            fullSlotData.y = slot.y;
            fullSlotData.slots = slot.slots;

            targetSlots[j] = fullSlotData;
        }
        return targetSlots;
    }

    function getFullUserMascots(address user) public returns (FullMascotData[] memory) {
        uint256[] memory mascotIds = UserMascots.get(user);
        FullMascotData[] memory fullMascotDataArray = new FullMascotData[](mascotIds.length);

        for (uint256 i = 0; i < mascotIds.length; i++) {
            uint256 mascotId = mascotIds[i];
            MascotData memory mascotData = Mascot.get(mascotId);

            FullSlotData[] memory slots = getFullSlots(mascotData.slots);

            TraitData[] memory traits = new TraitData[](mascotData.traits.length);
            for (uint256 k = 0; k < mascotData.traits.length; k++) {
                traits[k] = Trait.get(mascotData.traits[k]);
            }

            FullMascotData memory fullMascotData;
            fullMascotData.id = mascotData.id;
            fullMascotData.owner = mascotData.owner;
            fullMascotData.name = mascotData.name;
            fullMascotData.mascotType = mascotData.mascotType;
            fullMascotData.slots = slots;
            fullMascotData.traits = traits;


            fullMascotDataArray[i] = fullMascotData;
        }

        return fullMascotDataArray;
    }

    function getAllTraits() public returns (OwnAbleTraitData[] memory) {
        uint256[] memory traitIds = MascotSystemSettings.getCurrentTraitIds(1);

        OwnAbleTraitData[] memory allData = new OwnAbleTraitData[](traitIds.length);

        for (uint256 i = 0; i < traitIds.length; i++) {
            TraitData memory trait = Trait.get(traitIds[i]);
            allData[i].id = trait.id;
            allData[i].optionName = trait.optionName;
            allData[i].optionValue = trait.optionValue;
            allData[i].traitSlot = trait.traitSlot;
            allData[i].owned = OwnedTraits.getOwned(_msgSender(), trait.id);
        }
        return allData;
    }

    function getAllSlots() public returns (OwnAbleSlotData[] memory) {
        uint256[] memory slotIds = MascotSystemSettings.getCurrentSlotIds(1);
        OwnAbleSlotData[] memory allData = new OwnAbleSlotData[](slotIds.length);

        for (uint256 i = 0; i < slotIds.length; i++) {
            SlotData memory slot = Slot.get(slotIds[i]);
            allData[i].id = slot.id;
            allData[i].slotName = slot.slotName;
            allData[i].slots = slot.slots;
            allData[i].displayName = slot.displayName;
            allData[i].selectedComponent = slot.selectedComponent;
            allData[i].x = slot.x;
            allData[i].y = slot.y;
            allData[i].properties = slot.properties;
            allData[i].owned = OwnedSlots.getOwned(_msgSender(), slot.id);
        }
        return allData;
    }

    // Trait Changes specific update methods
    function updateTraits(uint256 mascotId, string memory traitSlot, uint256 traitId, string memory optionName, string memory optionValue) public {
        // Todo this should handle multiple traits
        bytes20 encodedSlot = stringToBytes20(traitSlot);
        MascotTraitChanges.set(mascotId, encodedSlot, traitId, optionName, optionValue);
    }

    function removeTraitChanges(uint256 mascotId, string memory traitSlot) public {
        bytes20 encodedSlot = stringToBytes20(traitSlot);
        MascotTraitChanges.deleteRecord(mascotId, encodedSlot);
    }

    // Todo rename & fix type in changed to changes
    function getTraitChanged(uint256 mascotId, string memory traitSlot) public returns (MascotTraitChangesData memory) {
        bytes20 encodedSlot = stringToBytes20(traitSlot);
        return MascotTraitChanges.get(mascotId, encodedSlot);
    }

    // Slot Changes specific update methods
    function updateSlots(uint256 mascotId, string[] memory slotNames, uint256[] memory selectedSlotIds) public {
        require(slotNames.length == selectedSlotIds.length, "Array lengths must match");

        for (uint256 i = 0; i < slotNames.length; i++) {
            bytes20 encodedSlot = stringToBytes20(slotNames[i]);
            MascotSlotChanges.set(mascotId, encodedSlot, selectedSlotIds[i]);
        }
    }

    function removeSlotChanges(uint256 mascotId, string[] memory slotNames) public {
        for (uint256 i = 0; i < slotNames.length; i++) {
            bytes20 encodedSlot = stringToBytes20(slotNames[i]);
            MascotSlotChanges.deleteRecord(mascotId, encodedSlot);
        }
    }

    function getSlotChanges(uint256 mascotId, string[] memory slotNames) public returns (SlotChange[] memory) {
        SlotChange[] memory allData = new SlotChange[](slotNames.length);

        for (uint256 i = 0; i < slotNames.length; i++) {
            bytes20 encodedSlot = stringToBytes20(slotNames[i]);
            allData[i].slotName = slotNames[i];
            allData[i].selectedSlot = MascotSlotChanges.get(mascotId, encodedSlot);
        }

        return allData;
    }

    //  TODO REALLY needs a owner check
    function setup() public returns (MascotSystemSettingsData memory table) {
        uint256[] memory emptyUintArray = new uint256[](0);
        MascotSystemSettings.setCurrentMascotId(1, 1);
        MascotSystemSettings.setCurrentSlotId(1, 1);
        MascotSystemSettings.setCurrentTraitId(1, 1);
        MascotSystemSettings.setCurrentCosmeticSlotId(1, 1);
        MascotSystemSettings.setCurrentCosmeticTraitId(1, 1);
        MascotSystemSettings.setCurrentMascotIds(1, emptyUintArray);
        MascotSystemSettings.setCurrentSlotIds(1, emptyUintArray);
        MascotSystemSettings.setCurrentTraitIds(1, emptyUintArray);
        MascotSystemSettings.setCurrentCosmeticSlotIds(1, emptyUintArray);
        MascotSystemSettings.setCurrentCosmeticTraitIds(1, emptyUintArray);
        return MascotSystemSettings.get(1);
    }
}
