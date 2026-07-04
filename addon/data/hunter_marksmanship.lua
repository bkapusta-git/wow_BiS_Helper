-- BiS data: Marksmanship Hunter — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/hunter/marksmanship/bis-gear
-- Source: https://www.wowhead.com/guide/classes/hunter/marksmanship/stat-priority-pve-dps
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["HUNTER_MARKSMANSHIP"] = {
    label = "Marksmanship Hunter",
    class = "HUNTER",
    spec  = "Marksmanship",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Haste", op = nil  , r = 1.00, g = 0.82, b = 0.20 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Haste", op = nil  , r = 1.00, g = 0.82, b = 0.20 },
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
            [2]= { itemID = 249368, name = "Eternal Voidsong Chain",           source = "Crown of the Cosmos · The Voidspire"}, -- Neck
            [3]= { itemID = 249986, name = "Primal Sentry's Trophies",         source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 244609, name = "World Tender's Trunkplate",        source = "Unknown Source"                    }, -- Chest
            [6]= { itemID = 244611, name = "World Tender's Barkclasp",         source = "Unknown Source"                    }, -- Waist
            [7]= { itemID = 249987, name = "Primal Sentry's Legguards",        source = "Catalyst the Rotmire Legs"         }, -- Legs
            [8]= { itemID = 249990, name = "Primal Sentry's Swiftsteps",       source = "Catalyst the Rotmire Boots"        }, -- Feet
            [9]= { itemID = 249304, name = "Fallen King's Cuffs",              source = "Fallen-King Salhadaar · The Voidspire"}, -- Wrist
            [10]= { itemID = 249989, name = "Primal Sentry's Talonguards",      source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 249336, name = "Signet of the Starved Beast",      source = "Vorasius · The Voidspire"          }, -- Ring 1
            [12]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren"                          }, -- Ring 2
            [13]= { itemID = 193701, name = "Algeth'ar Puzzle Box",             source = "Algeth'ar Academy"                 }, -- Trinket 1
            [14]= { itemID = 260235, name = "Umbral Plume",                     source = "Belo'ren"                          }, -- Trinket 2
            [15]= { itemID = 258575, name = "Rigid Scale Greatcloak",           source = "Skyreach"                          }, -- Back
            [16]= { itemID = 258412, name = "Stormshaper's Crossbow",           source = "Skyreach"                          }, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 249988, name = "Primal Sentry's Maw",              source = "Tier Set"                          }, -- Head
            [2]= { itemID = 249368, name = "Eternal Voidsong Chain",           source = "Crown of the Cosmos · The Voidspire"}, -- Neck
            [3]= { itemID = 249986, name = "Primal Sentry's Trophies",         source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 244609, name = "World Tender's Trunkplate",        source = "Unknown Source"                    }, -- Chest
            [6]= { itemID = 244611, name = "World Tender's Barkclasp",         source = "Unknown Source"                    }, -- Waist
            [7]= { itemID = 249987, name = "Primal Sentry's Legguards",        source = "Catalyst the Rotmire Legs"         }, -- Legs
            [8]= { itemID = 249990, name = "Primal Sentry's Swiftsteps",       source = "Catalyst the Rotmire Boots"        }, -- Feet
            [9]= { itemID = 249304, name = "Fallen King's Cuffs",              source = "Fallen-King Salhadaar · The Voidspire"}, -- Wrist
            [10]= { itemID = 249989, name = "Primal Sentry's Talonguards",      source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 249336, name = "Signet of the Starved Beast",      source = "Vorasius · The Voidspire"          }, -- Ring 1
            [12]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren"                          }, -- Ring 2
            [13]= { itemID = 193701, name = "Algeth'ar Puzzle Box",             source = "Algeth'ar Academy"                 }, -- Trinket 1
            [14]= { itemID = 260235, name = "Umbral Plume",                     source = "Belo'ren"                          }, -- Trinket 2
            [15]= { itemID = 258575, name = "Rigid Scale Greatcloak",           source = "Skyreach"                          }, -- Back
            [16]= { itemID = 258412, name = "Stormshaper's Crossbow",           source = "Skyreach"                          }, -- Main Hand
        },
    },
}
