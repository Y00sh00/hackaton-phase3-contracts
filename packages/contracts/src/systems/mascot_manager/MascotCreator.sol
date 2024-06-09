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
import {CampaignClaimed} from "../../codegen/tables/CampaignClaimed.sol";
import {FullMascotData} from "./structs/FullMascotData.sol";
import {FullSlotData} from "./structs/FullSlotData.sol";
import {ResourceId} from "@latticexyz/store/src/ResourceId.sol";
import {SlotChange} from "./structs/SlotChange.sol";
import {OwnAbleTraitData} from "./structs/OwnAbleTraitData.sol";
import {SquareBaseSystem} from "./SquareBaseSystem.sol";

contract MascotCreator is SquareBaseSystem {
    address private constant HARD_CODED_ADDRESS = 0x150DaDAbaB5A7c7b8A4fCC86E5d8bb774F0eeff6;


    function isCampaignClaimed(uint256 campaignId) public returns (bool){
        address user = _msgSender();
        return CampaignClaimed.get(user, campaignId);
    }

    // Todo shouldnt be in this system
    function claimCampaign(uint256 campaignId) public returns (uint256[] memory) {
        address user = _msgSender();
        uint256[] memory slots = new uint256[](20);
        uint256 newCount = 0;

        if (campaignId == 1) {
            if (_addSlotOwnershipIfNeeded(31, user)) {
                slots[newCount] = 31;
                newCount++;
            }
            CampaignClaimed.set(user, 1, true);
        }

        return slots;
    }

    function createMascot(
        address user,
        string memory name,
        string memory mascotType
    ) public returns (uint256) {

        // Todo unlock the traits for the user if they do not own them
        uint256[] memory selectedTraitIds = new uint256[](1);
        uint traitChosen = _random(4);
        selectedTraitIds[0] = traitChosen;
        _addTraitOwnershipIfNeeded(traitChosen, user);

        uint256[] memory selectedSlotIds = new uint256[](9);
        selectedSlotIds[0] = 1; // Body
        _addSlotOwnershipIfNeeded(1, user);
        selectedSlotIds[1] = 3; // Belt
        _addSlotOwnershipIfNeeded(3, user);
        selectedSlotIds[2] = 6; // Arms
        _addSlotOwnershipIfNeeded(6, user);
        selectedSlotIds[3] = 9; // Horns
        _addSlotOwnershipIfNeeded(9, user);
        selectedSlotIds[4] = 11; // Legs
        _addSlotOwnershipIfNeeded(11, user);
        selectedSlotIds[5] = 13; // Pants
        _addSlotOwnershipIfNeeded(13, user);
        selectedSlotIds[6] = 28; // Head
        _addSlotOwnershipIfNeeded(28, user);
        selectedSlotIds[7] = 29; // Left Hand
        _addSlotOwnershipIfNeeded(29, user);
        selectedSlotIds[8] = 30; // Right Hand
        _addSlotOwnershipIfNeeded(30, user);

        uint256 mascotId = _getSettings().currentMascotId;
        _incrementCurrentMascotId();

        Mascot.set(mascotId, mascotId, user, name, mascotType, selectedSlotIds, selectedTraitIds);

        // TODO MINT NFT HERE

        UserMascots.push(user, mascotId);
        MascotSystemSettings.pushCurrentMascotIds(1, mascotId);

        return mascotId;
    }

    function createSlot(
        string memory slotName,
        string memory selectedComponent,
        string memory displayName,
        int256 x,
        int256 y,
        uint256[] memory subSlotIds,
        string memory properties
    ) public returns (uint256) {
        require(_msgSender() == HARD_CODED_ADDRESS, "You are not authorized");
        uint256 slotId = _getSettings().currentSlotId;
        _incrementCurrentSlotId();

        Slot.set(slotId, SlotData({
            id: slotId,
            slotName: slotName,
            selectedComponent: selectedComponent,
            displayName: displayName,
            x: x,
            y: y,
            slots: subSlotIds,
            properties: properties
        }));
        MascotSystemSettings.pushCurrentSlotIds(1, slotId);
        return slotId;
    }

    function createTrait(
        string memory traitSlot,
        string memory optionName,
        string memory color
    ) public returns (uint256) {
        require(_msgSender() == HARD_CODED_ADDRESS, "You are not authorized");

    uint256 traitId = _getSettings().currentTraitId;
        _incrementCurrentTraitId();

        Trait.set(traitId, TraitData({
            id: traitId,
            traitSlot: traitSlot,
            optionName: optionName,
            optionValue: color
        }));

        MascotSystemSettings.pushCurrentTraitIds(1, traitId);

        return traitId;
    }

    // Helpers
    function _addTraitOwnershipIfNeeded(uint256 trait, address user) internal returns (bool){
        if (!OwnedTraits.getOwned(user, trait)) {
            uint256 newId = _getSettings().currentCosmeticTraitId;
            _incrementCurrentCosmeticTraitId();

            OwnedTraits.setOwned(user, trait, true);

            // Todo Mint NFT but unsure how to "transfer namespace ownership to the calling System's contract address"

            // Store
            OwnedTraits.pushOwnedCosmeticIds(user, trait, newId);
            MascotSystemSettings.pushCurrentCosmeticTraitIds(1, newId);
            return true;
        }
        return false;
    }

    function _addSlotOwnershipIfNeeded(uint256 slot, address user) internal returns (bool) {
        if (!OwnedSlots.getOwned(user, slot)) {
            uint256 newId = _getSettings().currentCosmeticSlotId;
            _incrementCurrentCosmeticSlotId();

            OwnedSlots.setOwned(user, slot, true);

            // Todo Mint NFT but unsure how to "transfer namespace ownership to the calling System's contract address"

            // Store
            OwnedSlots.pushOwnedCosmeticIds(user, slot, newId);
            MascotSystemSettings.pushCurrentCosmeticSlotIds(1, newId);

            // Check for sub slots and sort those as well
            uint256[] memory subSlots = Slot.getSlots(slot);
            for (uint256 i = 0; i < subSlots.length; i++) {
                uint256 subSlot = subSlots[i];
                _addSlotOwnershipIfNeeded(subSlot, user);
            }
            // Todo we have no way of storing the sub unlocks at the moment
            return true;
        }
        return false;
    }
}
