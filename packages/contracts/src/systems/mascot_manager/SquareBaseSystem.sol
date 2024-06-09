// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {MascotSystemSettings, MascotSystemSettingsData} from "../../codegen/tables/MascotSystemSettings.sol";
import {System} from "@latticexyz/world/src/System.sol";

// Todo refactor things in here to say nothing about Mascot
contract SquareBaseSystem is System {
    uint256 private nonce;

    constructor() {
        nonce = 0;
    }

    function _getSettings() internal returns (MascotSystemSettingsData memory) {
        return MascotSystemSettings.get(1);
    }

    // todo What if two operations call this at the same time? how does that work on blockchain tech? race conditions?
    function _incrementCurrentSlotId() internal {
        uint256 id = MascotSystemSettings.getCurrentSlotId(1);
        MascotSystemSettings.setCurrentSlotId(1, ++id);
    }

    function _incrementCurrentTraitId() internal {
        uint256 id = MascotSystemSettings.getCurrentTraitId(1);
        MascotSystemSettings.setCurrentTraitId(1, ++id);
    }

    function _incrementCurrentMascotId() internal {
        uint256 id = MascotSystemSettings.getCurrentMascotId(1);
        MascotSystemSettings.setCurrentMascotId(1, ++id);
    }

    function _incrementCurrentCosmeticTraitId() internal {
        uint256 id = MascotSystemSettings.getCurrentCosmeticTraitId(1);
        MascotSystemSettings.setCurrentCosmeticTraitId(1, ++id);
    }

    function _incrementCurrentCosmeticSlotId() internal {
        uint256 id = MascotSystemSettings.getCurrentCosmeticSlotId(1);
        MascotSystemSettings.setCurrentCosmeticSlotId(1, ++id);
    }

    function stringToBytes20(string memory source) internal pure returns (bytes20 result) {
        bytes memory tempBytes = bytes(source);
        if (tempBytes.length == 0) {
            return 0x0;
        }
        require(tempBytes.length <= 20, "String too long");
        assembly {
            result := mload(add(tempBytes, 32))
        }
    }

    function _random(uint x) internal returns (uint) {
        nonce++;
        uint hash = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender, nonce)));
        return (hash % x) + 1;
    }
}
