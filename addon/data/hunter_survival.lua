-- BiS data: Survival Hunter — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/hunter/survival/bis-gear
-- Source: https://www.wowhead.com/guide/classes/hunter/survival/stat-priority-pve-dps
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["HUNTER_SURVIVAL"] = {
    label = "Survival Hunter",
    class = "HUNTER",
    spec  = "Survival",

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
            [1]= { itemID = 249988, name = "Primal Sentry's Maw",              source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "(Sporefall)\r\n"                   }, -- Neck
            [3]= { itemID = 249318, name = "Nullwalker's Dread Epaulettes",    source = "Vaelgor & Ezzorak · The Voidspire" }, -- Shoulder
            [5]= { itemID = 249991, name = "Primal Sentry's Scaleplate",       source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 249371, name = "Scornbane Waistguard",             source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Waist
            [7]= { itemID = 249987, name = "Primal Sentry's Legguards",        source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 249990, name = "Primal Sentry's Swiftsteps",       source = "Tier Set"                          }, -- Feet
            [9]= { itemID = 244584, name = "Farstrider's Plated Bracers",      source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 249989, name = "Primal Sentry's Talonguards",      source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 251093, name = "Omission of Light",                source = "Nexus-Point Xenas"                 }, -- Ring 1
            [12]= { itemID = 251217, name = "Occlusion of Void",                source = "Nexus-Point Xenas"                 }, -- Ring 2
            [13]= { itemID = 193701, name = "Algeth'ar Puzzle Box",             source = "Algeth'ar Academy"                 }, -- Trinket 1
            [14]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 2
            [15]= { itemID = 258575, name = "Rigid Scale Greatcloak",           source = "Skyreach"                          }, -- Back
            [16]= { itemID = 251077, name = "Roostwarden's Bough",              source = "Windrunner Spire"                  }, -- Main Hand
            [17]= { itemID = 237837, name = "Farstrider's Mercy",               source = "Crafted"                           }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 249988, name = "Primal Sentry's Maw",              source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "(Sporefall)\r\n"                   }, -- Neck
            [3]= { itemID = 249318, name = "Nullwalker's Dread Epaulettes",    source = "Vaelgor & Ezzorak · The Voidspire" }, -- Shoulder
            [5]= { itemID = 249991, name = "Primal Sentry's Scaleplate",       source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 249371, name = "Scornbane Waistguard",             source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Waist
            [7]= { itemID = 249987, name = "Primal Sentry's Legguards",        source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 249990, name = "Primal Sentry's Swiftsteps",       source = "Tier Set"                          }, -- Feet
            [9]= { itemID = 244584, name = "Farstrider's Plated Bracers",      source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 249989, name = "Primal Sentry's Talonguards",      source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 251093, name = "Omission of Light",                source = "Nexus-Point Xenas"                 }, -- Ring 1
            [12]= { itemID = 251217, name = "Occlusion of Void",                source = "Nexus-Point Xenas"                 }, -- Ring 2
            [13]= { itemID = 193701, name = "Algeth'ar Puzzle Box",             source = "Algeth'ar Academy"                 }, -- Trinket 1
            [14]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 2
            [15]= { itemID = 258575, name = "Rigid Scale Greatcloak",           source = "Skyreach"                          }, -- Back
            [16]= { itemID = 251077, name = "Roostwarden's Bough",              source = "Windrunner Spire"                  }, -- Main Hand
            [17]= { itemID = 237837, name = "Farstrider's Mercy",               source = "Crafted"                           }, -- Off Hand
        },
    },
}
