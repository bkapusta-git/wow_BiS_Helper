-- BiS data: Assassination Rogue — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/rogue/assassination/bis-gear
-- Source: https://www.wowhead.com/guide/classes/rogue/assassination/stat-priority-pve-dps
-- Last updated: 2026-08-21

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["ROGUE_ASSASSINATION"] = {
    label = "Assassination Rogue",
    class = "ROGUE",
    spec  = "Assassination",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        dr = {
            { name = "Haste", rating = 1320, r = 1.00, g = 0.82, b = 0.20 },
            { name = "Crit / Mastery", rating = 1380, r = 1.00, g = 0.60, b = 0.30 },
            { name = "Versatility", rating = 1620, r = 0.65, g = 0.40, b = 1.00 },
        },
    },

    content = {
        -- ── Raid BiS ────────────────────────────────────────
        raid = {
            [1]= { itemID = 271510, name = "Chosen Bloodslayer's Spirit Shroud",source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271508, name = "Chosen Bloodslayer's Voodoo Guards",source = "Voidscar Arena"                    }, -- Shoulder
            [5]= { itemID = 271513, name = "Chosen Bloodslayer's Banded Poncho",source = "Den of Nalorakk"                   }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271509, name = "Chosen Bloodslayer's Reinforced Pants",source = "The Coiled Altar"                  }, -- Legs
            [8]= { itemID = 251153, name = "Arctic Explorer's Legwraps",       source = "Den of Nalorakk"                   }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafting/Misc"                     }, -- Wrist
            [10]= { itemID = 271511, name = "Chosen Bloodslayer's Fanged Grips",source = "Entombed Sentinels"                }, -- Hands
            [11]= { itemID = 273792, name = "Band of the Amani Warlord",        source = "Altar of Fangs"                    }, -- Ring 1
            [12]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 2
            [13]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 1
            [14]= { itemID = 270168, name = "Font of Venomous Rage",            source = "Ula'tek"                           }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271093, name = "Zatha'tek, Breath of Corruption",  source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 237837, name = "Farstrider's Mercy",               source = "Crafting/Misc"                     }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271510, name = "Chosen Bloodslayer's Spirit Shroud",source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271508, name = "Chosen Bloodslayer's Voodoo Guards",source = "Voidscar Arena"                    }, -- Shoulder
            [5]= { itemID = 271513, name = "Chosen Bloodslayer's Banded Poncho",source = "Den of Nalorakk"                   }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271509, name = "Chosen Bloodslayer's Reinforced Pants",source = "The Coiled Altar"                  }, -- Legs
            [8]= { itemID = 251153, name = "Arctic Explorer's Legwraps",       source = "Den of Nalorakk"                   }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafting/Misc"                     }, -- Wrist
            [10]= { itemID = 271511, name = "Chosen Bloodslayer's Fanged Grips",source = "Entombed Sentinels"                }, -- Hands
            [11]= { itemID = 273792, name = "Band of the Amani Warlord",        source = "Altar of Fangs"                    }, -- Ring 1
            [12]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 2
            [13]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 1
            [14]= { itemID = 270168, name = "Font of Venomous Rage",            source = "Ula'tek"                           }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271093, name = "Zatha'tek, Breath of Corruption",  source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 237837, name = "Farstrider's Mercy",               source = "Crafting/Misc"                     }, -- Off Hand
        },
    },
}
