// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SlotData} from "../../../codegen/tables/Slot.sol";
import {TraitData} from "../../../codegen/tables/Trait.sol";
import {FullSlotData} from "./FullSlotData.sol";

struct FullMascotData {
    uint256 id;
    address owner;
    string name;
    string mascotType;
    FullSlotData[] slots;
    TraitData[] traits;
}