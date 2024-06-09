// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

/**
 * @title IVendingMachine
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IVendingMachine {
  function kalb_v14__setVendingMachineRatio(
    uint256 smartObjectId,
    uint256 inventoryItemIdIn,
    uint256 inventoryItemIdOut,
    uint256 quantityIn,
    uint256 quantityOut
  ) external;

  function kalb_v14__executeVendingMachine(uint256 smartObjectId, uint256 quantity, uint256 inventoryItemIdIn) external;

  function kalb_v14__calculateOutput(
    uint256 inputRatio,
    uint256 outputRatio,
    uint256 inputAmount
  ) external pure returns (uint256 outputAmount, uint256 remainingInput);
}
