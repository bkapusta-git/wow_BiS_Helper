-- BiS data: Balance Druid — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/druid/balance/bis-gear
-- Source: https://www.wowhead.com/guide/classes/druid/balance/stat-priority-pve-dps
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DRUID_BALANCE"] = {
    label = "Balance Druid",
    class = "DRUID",
    spec  = "Balance",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste", op = "="  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste", op = "="  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
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
            [1]= { itemID = 250024, name = "Branches of the Luminous Bloom",   source = "Sporefall (Catalyze It!)"          }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall"                         }, -- Neck
            [3]= { itemID = 250022, name = "Seedpods of the Luminous Bloom",   source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250027, name = "Trunk of the Luminous Bloom",      source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Sporefall"                         }, -- Waist
            [7]= { itemID = 250023, name = "Phloemwraps of the Luminous Bloom",source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 258577, name = "Boots of Burning Focus",           source = "Skyreach"                          }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 249321, name = "Vaelgor's Fearsome Grasp",         source = "Vaelgor & Ezzorak · The Voidspire" }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 1
            [12]= { itemID = 193708, name = "Platinum Star Band",               source = "Algeth'ar Academy"                 }, -- Ring 2
            [13]= { itemID = 249346, name = "Vaelgor's Final Stare",            source = "Vaelgor & Ezzorak · The Voidspire" }, -- Trinket 1
            [14]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 2
            [15]= { itemID = 258575, name = "Rigid Scale Greatcloak",           source = "Skyreach"                          }, -- Back
            [16]= { itemID = 251083, name = "Excavating Cudgel",                source = "Windrunner Spire"                  }, -- Main Hand
            [17]= { itemID = 245769, name = "Aln'hara Lantern",                 source = "Crafted"                           }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 250024, name = "Branches of the Luminous Bloom",   source = "Sporefall (Catalyze It!)"          }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall"                         }, -- Neck
            [3]= { itemID = 250022, name = "Seedpods of the Luminous Bloom",   source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250027, name = "Trunk of the Luminous Bloom",      source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Sporefall"                         }, -- Waist
            [7]= { itemID = 250023, name = "Phloemwraps of the Luminous Bloom",source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 258577, name = "Boots of Burning Focus",           source = "Skyreach"                          }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 249321, name = "Vaelgor's Fearsome Grasp",         source = "Vaelgor & Ezzorak · The Voidspire" }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 1
            [12]= { itemID = 193708, name = "Platinum Star Band",               source = "Algeth'ar Academy"                 }, -- Ring 2
            [13]= { itemID = 249346, name = "Vaelgor's Final Stare",            source = "Vaelgor & Ezzorak · The Voidspire" }, -- Trinket 1
            [14]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 2
            [15]= { itemID = 258575, name = "Rigid Scale Greatcloak",           source = "Skyreach"                          }, -- Back
            [16]= { itemID = 251083, name = "Excavating Cudgel",                source = "Windrunner Spire"                  }, -- Main Hand
            [17]= { itemID = 245769, name = "Aln'hara Lantern",                 source = "Crafted"                           }, -- Off Hand
        },
    },
}
