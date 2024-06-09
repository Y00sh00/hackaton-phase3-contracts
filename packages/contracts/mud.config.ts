import {mudConfig} from "@latticexyz/world/register";

export default mudConfig({
    namespace: "kalb_v22",
    systems: {
        MascotManager: {
            name: "MascotManager",
            openAccess: true,
        },
        MascotCreator: {
            name: "MascotCreator",
            openAccess: true,
        }
    },
    tables: {
        CampaignClaimed: {
            keySchema: {user: "address", campaignId: "uint256"},
            valueSchema: {
                completed: "bool",
            },
        },
        OwnedSlots: {
            keySchema: {user: "address", slotId: "uint256"},
            valueSchema: {
                owned: "bool", // workaround since we do not have NFTs working yet from System so we just set this on true
                ownedCosmeticIds: "uint256[]", // All NFT TokenIds to check ownership on
            },
        },
        OwnedTraits: {
            keySchema: {user: "address", traitId: "uint256"},
            valueSchema: {
                owned: "bool", // workaround since we do not have NFTs working yet from System so we just set this on true
                ownedCosmeticIds: "uint256[]", // All NFT TokenIds to check ownership on
            },
        },
        MascotSystemSettings: {
            keySchema: {configId: "uint256"},
            valueSchema: {
                currentSlotId: "uint256",
                currentTraitId: "uint256",
                currentMascotId: "uint256",
                currentCosmeticSlotId: "uint256", // used for the index of new TokenIds for SLT
                currentCosmeticTraitId: "uint256", // used for the index of new TokenIds for TRT
                currentMascotIds: "uint256[]",
                currentTraitIds: "uint256[]",
                currentSlotIds: "uint256[]",
                currentCosmeticSlotIds: "uint256[]", // All NFT TokenIds for slots
                currentCosmeticTraitIds: "uint256[]" // All NFT TokenIds for traits
            },
        },
        MascotTraitChanges: {
            keySchema: {mascotId: "uint256", slot: "bytes20"},
            valueSchema: {
                id: "uint256",
                optionName: "string",
                optionValue: "string"
            },
        },
        MascotSlotChanges: {
            keySchema: {mascotId: "uint256", slot: "bytes20"},
            valueSchema: {
                id: "uint256"
            },
        },
        Mascot: {
            keySchema: {
                mascotId: "uint256"
            },
            valueSchema: {
                id: "uint256",
                owner: "address",
                name: "string",
                mascotType: "string",
                slots: "uint256[]",
                traits: "uint256[]"
            }
        },
        Slot: {
            keySchema: {
                slotId: "uint256"
            },
            valueSchema: {
                id: "uint256",
                x: "int256",
                y: "int256",
                slotName: "string",
                selectedComponent: "string",
                displayName: "string",
                slots: "uint256[]",
                properties: "string"
            }
        },
        Trait: {
            keySchema: {
                traitId: "uint256"
            },
            valueSchema: {
                id: "uint256",
                traitSlot: "string",
                optionName: "string",
                optionValue: "string"
            }
        },
        UserMascots: {
            keySchema: {
                user: "address"
            },
            valueSchema: {
                mascotIds: "uint256[]"
            }
        },
        BaseCosmetic: {
            keySchema: {id: "uint256"},
            valueSchema: {
                zIndex: "int256",
                x: "int256",
                y: "int256",
                slotName: "string",
                componentName: "string",
                displayName: "string",
            },
        },
        RatioConfig: {
            keySchema: {smartObjectId: "uint256", itemIn: "uint256"},
            valueSchema: {
                itemOut: "uint256",
                ratioIn: "uint256",
                ratioOut: "uint256",
            },
        },
        ItemSellerERC20: {
            keySchema: {
                smartObjectId: "uint256", // SSU ID
            },
            valueSchema: {
                tokenAddress: "address",
                tokenDecimals: "uint256",
                receiver: "address",
            },
        },
        ItemPrice: {
            keySchema: {
                smartObjectId: "uint256", // SSU ID
                itemId: "uint256",
            },
            valueSchema: {
                isSet: "bool",
                price: "uint256",
            },
        },
        GateKeeperConfig: {
            keySchema: {
                smartObjectId: "uint256",
            },
            valueSchema: {
                itemIn: "uint256",
                targetItemQuantity: "uint256",
                isGoalReached: "bool",
            }

        }
    }
});
