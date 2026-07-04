-- BiS data: Enhancement Shaman — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/shaman/enhancement/bis-gear
-- Source: https://www.wowhead.com/guide/classes/shaman/enhancement/stat-priority-pve-dps
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["SHAMAN_ENHANCEMENT"] = {
    label = "Enhancement Shaman",
    class = "SHAMAN",
    spec  = "Enhancement",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = "="  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = "="  , r = 0.30, g = 0.75, b = 1.00 },
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
            [1]= { itemID = 249979, name = "Locus of the Primal Core",         source = "Catalyst |  Raid |  Vault"         }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Rotmire"                           }, -- Neck
            [3]= { itemID = 249977, name = "Tempests of the Primal Core",      source = "Catalyst |  Raid |  Vault"         }, -- Shoulder
            [5]= { itemID = 249982, name = "Embrace of the Primal Core",       source = "Catalyst |  Raid |  Vault"         }, -- Chest
            [6]= { itemID = 249976, name = "Ceinture of the Primal Core",      source = "Catalyst"                          }, -- Waist
            [7]= { itemID = 268288, name = "Fungarian Folly Faulds",           source = "Rotmire"                           }, -- Legs
            [8]= { itemID = 268287, name = "Grudgefiend Stompers",             source = "Rotmire"                           }, -- Feet
            [9]= { itemID = 249304, name = "Fallen King's Cuffs",              source = "Fallen-King Salhadaar · The Voidspire"}, -- Wrist
            [10]= { itemID = 249980, name = "Earthgrips of the Primal Core",    source = "Catalyst | Raid |  Vault"          }, -- Hands
            [11]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls"                    }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Rotmire"                           }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 193701, name = "Algeth'ar Puzzle Box",             source = "Algeth'ar Academy"                 }, -- Trinket 2
            [15]= { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Unknown Source"                    }, -- Back
            [16]= { itemID = 249287, name = "Clutchmates' Caress",              source = "Vaelgor & Ezzorak · The Voidspire" }, -- Main Hand
            [17]= { itemID = 237850, name = "Farstrider's Chopper",             source = "Unknown Source"                    }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 249979, name = "Locus of the Primal Core",         source = "Catalyst |  Raid |  Vault"         }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Rotmire"                           }, -- Neck
            [3]= { itemID = 249977, name = "Tempests of the Primal Core",      source = "Catalyst |  Raid |  Vault"         }, -- Shoulder
            [5]= { itemID = 249982, name = "Embrace of the Primal Core",       source = "Catalyst |  Raid |  Vault"         }, -- Chest
            [6]= { itemID = 249976, name = "Ceinture of the Primal Core",      source = "Catalyst"                          }, -- Waist
            [7]= { itemID = 268288, name = "Fungarian Folly Faulds",           source = "Rotmire"                           }, -- Legs
            [8]= { itemID = 268287, name = "Grudgefiend Stompers",             source = "Rotmire"                           }, -- Feet
            [9]= { itemID = 249304, name = "Fallen King's Cuffs",              source = "Fallen-King Salhadaar · The Voidspire"}, -- Wrist
            [10]= { itemID = 249980, name = "Earthgrips of the Primal Core",    source = "Catalyst | Raid |  Vault"          }, -- Hands
            [11]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls"                    }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Rotmire"                           }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 193701, name = "Algeth'ar Puzzle Box",             source = "Algeth'ar Academy"                 }, -- Trinket 2
            [15]= { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Unknown Source"                    }, -- Back
            [16]= { itemID = 249287, name = "Clutchmates' Caress",              source = "Vaelgor & Ezzorak · The Voidspire" }, -- Main Hand
            [17]= { itemID = 237850, name = "Farstrider's Chopper",             source = "Unknown Source"                    }, -- Off Hand
        },
    },
}
