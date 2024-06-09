// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import {SlotData} from "../../../codegen/tables/Slot.sol";

struct FullSlotData {
    uint256 id;
    int256 x;
    int256 y;
    string slotName;
    string selectedComponent;
    string displayName;
    uint256[] slots;
    // Holds a comma separate list of values order is important! zIndex, color1, color2, color3, color4, color5
    // ZIndex Specific info
    // we use a string here to do the following:
    // -1000 - 1000 we can use for rendering
    // 'null' means we do not set a z-index at all, important for composed components
    // 'default' means we set it to the default zIndex of 5
    string properties;
}