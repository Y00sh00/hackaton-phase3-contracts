// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { BaseCosmetic, BaseCosmeticData } from "../../codegen/tables/BaseCosmetic.sol";

contract MascotSystem is System {
    uint256 private currentEntityId;
    uint256[] private entityIds; // Array to track all entity IDs

    constructor() {
        currentEntityId = 0;
    }

    function setCosmeticData(
        string memory slotName,
        string memory componentName,
        int256 zIndex,
        string memory displayName,
        int256 x,
        int256 y
    ) public returns (uint256) {
        uint256 entityId = currentEntityId++;
        BaseCosmeticData memory data = BaseCosmeticData({
            zIndex: zIndex,
            x: x,
            y: y,
            slotName: slotName,
            componentName: componentName,
            displayName: displayName
        });

        BaseCosmetic.set(entityId, data);
        entityIds.push(entityId); // Track the new entity ID
        return entityId;
    }

    function getCosmeticData(uint256 entityId) public returns (BaseCosmeticData memory) {
        return BaseCosmetic.get(entityId);
    }

    // Function to get all entity IDs
    function getAllEntityIds() public returns (uint256[] memory) {
        return entityIds;
    }

    // Function to get all BaseCosmeticData for tracked entity IDs
    function getAllCosmeticData() public returns (BaseCosmeticData[] memory) {
        uint256[] memory ids = getAllEntityIds();
        BaseCosmeticData[] memory allData = new BaseCosmeticData[](ids.length);
        for (uint256 i = 0; i < ids.length; i++) {
            allData[i] = getCosmeticData(ids[i]);
        }
        return allData;
    }

}