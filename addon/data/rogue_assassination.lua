-- BiS data: Assassination Rogue — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/rogue/assassination/bis-gear
-- Source: https://www.wowhead.com/guide/classes/rogue/assassination/stat-priority-pve-dps
-- Last updated: 2026-07-04

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
            [1]= { itemID = 268283, name = "Festerbloom Crown",                source = "Sporefall"                         }, -- Head
            [2]= { itemID = 249337, name = "Ribbon of Coiled Malice",          source = "Fallen-King Salhadaar · The Voidspire"}, -- Neck
            [3]= { itemID = 250004, name = "Venom Casks of the Grim Jest",     source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250009, name = "Fantastic Finery of the Grim Jest",source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 249374, name = "Scorn-Scarred Shul'ka's Belt",     source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Waist
            [7]= { itemID = 250005, name = "Blade Holsters of the Grim Jest",  source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 249382, name = "Canopy Walker's Footwraps",        source = "Crown of the Cosmos · The Voidspire"}, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 250007, name = "Sleight of Hand of the Grim Jest", source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren"                          }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 193701, name = "Algeth'ar Puzzle Box",             source = "Algeth'ar Academy"                 }, -- Trinket 2
            [15]= { itemID = 260312, name = "Defiant Defender's Drape",         source = "Magisters' Terrace"                }, -- Back
            [16]= { itemID = 249925, name = "Hungering Victory",                source = "Vorasius · The Voidspire"          }, -- Main Hand
            [17]= { itemID = 237837, name = "Farstrider's Mercy",               source = "Crafted"                           }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 268283, name = "Festerbloom Crown",                source = "Sporefall"                         }, -- Head
            [2]= { itemID = 249337, name = "Ribbon of Coiled Malice",          source = "Fallen-King Salhadaar · The Voidspire"}, -- Neck
            [3]= { itemID = 250004, name = "Venom Casks of the Grim Jest",     source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250009, name = "Fantastic Finery of the Grim Jest",source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 249374, name = "Scorn-Scarred Shul'ka's Belt",     source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Waist
            [7]= { itemID = 250005, name = "Blade Holsters of the Grim Jest",  source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 249382, name = "Canopy Walker's Footwraps",        source = "Crown of the Cosmos · The Voidspire"}, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 250007, name = "Sleight of Hand of the Grim Jest", source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren"                          }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 193701, name = "Algeth'ar Puzzle Box",             source = "Algeth'ar Academy"                 }, -- Trinket 2
            [15]= { itemID = 260312, name = "Defiant Defender's Drape",         source = "Magisters' Terrace"                }, -- Back
            [16]= { itemID = 249925, name = "Hungering Victory",                source = "Vorasius · The Voidspire"          }, -- Main Hand
            [17]= { itemID = 237837, name = "Farstrider's Mercy",               source = "Crafted"                           }, -- Off Hand
        },
    },
}
