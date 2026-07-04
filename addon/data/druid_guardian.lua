-- BiS data: Guardian Druid — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/druid/guardian/bis-gear
-- Source: https://www.wowhead.com/guide/classes/druid/guardian/stat-priority-pve-tank
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DRUID_GUARDIAN"] = {
    label = "Guardian Druid",
    class = "DRUID",
    spec  = "Guardian",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery", op = nil  , r = 0.30, g = 0.75, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery", op = nil  , r = 0.30, g = 0.75, b = 1.00 },
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
            [1]= { itemID = 268283, name = "Festerbloom Crown",                source = "Sporefall"                         }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall"                         }, -- Neck
            [3]= { itemID = 250022, name = "Seedpods of the Luminous Bloom",   source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250027, name = "Trunk of the Luminous Bloom",      source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Sporefall"                         }, -- Waist
            [7]= { itemID = 250023, name = "Phloemwraps of the Luminous Bloom",source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 249334, name = "Void-Claimed Shinkickers",         source = "Imperator Averzian · The Voidspire"}, -- Feet
            [9]= { itemID = 249327, name = "Void-Skinned Bracers",             source = "Vorasius · The Voidspire"          }, -- Wrist
            [10]= { itemID = 250025, name = "Arbortenders of the Luminous Bloom",source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 1
            [12]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls"                    }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 193701, name = "Algeth'ar Puzzle Box",             source = "Algeth'ar Academy"                 }, -- Trinket 2
            [15]= { itemID = 249370, name = "Draconic Nullcape",                source = "Vaelgor & Ezzorak · The Voidspire" }, -- Back
            [16]= { itemID = 249278, name = "Alnscorned Spire",                 source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 268283, name = "Festerbloom Crown",                source = "Sporefall"                         }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall"                         }, -- Neck
            [3]= { itemID = 250022, name = "Seedpods of the Luminous Bloom",   source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250027, name = "Trunk of the Luminous Bloom",      source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Sporefall"                         }, -- Waist
            [7]= { itemID = 250023, name = "Phloemwraps of the Luminous Bloom",source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 249334, name = "Void-Claimed Shinkickers",         source = "Imperator Averzian · The Voidspire"}, -- Feet
            [9]= { itemID = 249327, name = "Void-Skinned Bracers",             source = "Vorasius · The Voidspire"          }, -- Wrist
            [10]= { itemID = 250025, name = "Arbortenders of the Luminous Bloom",source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 1
            [12]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls"                    }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 193701, name = "Algeth'ar Puzzle Box",             source = "Algeth'ar Academy"                 }, -- Trinket 2
            [15]= { itemID = 249370, name = "Draconic Nullcape",                source = "Vaelgor & Ezzorak · The Voidspire" }, -- Back
            [16]= { itemID = 249278, name = "Alnscorned Spire",                 source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Main Hand
        },
    },
}
