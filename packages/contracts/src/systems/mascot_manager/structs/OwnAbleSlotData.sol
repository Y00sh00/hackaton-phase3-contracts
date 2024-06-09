// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

struct OwnAbleSlotData {
    uint256 id;
    int256 x;
    int256 y;
    string slotName;
    string selectedComponent;
    string displayName;
    uint256[] slots;
    string properties;
    bool owned;
}
