-- BiS data: Marksmanship Hunter — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/hunter/marksmanship/bis-gear
--         https://www.wowhead.com/guide/classes/hunter/marksmanship/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["HUNTER_MARKSMANSHIP"] = {
    label = "Marksmanship Hunter",
    class = "HUNTER",
    spec  = "Marksmanship",

    -- Sentinel & Dark Ranger: identical priority
    statPriority = {
        raid = {
            note  = "Sentinel & Dark Ranger: identical. Multiple talents scale with Crit",
            stats = {
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Haste",           op = nil,   r = 1.00, g = 0.82, b = 0.20 },
            },
        },
        mythicplus = {
            note  = "Same as Raid — M+ trinket alternatives available",
            stats = {
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Haste",           op = nil,   r = 1.00, g = 0.82, b = 0.20 },
            },
        },
        dr = {
            { name = "Haste",          rating = 1320, r = 1.00, g = 0.82, b = 0.20 },
            { name = "Crit / Mastery", rating = 1380, r = 1.00, g = 0.60, b = 0.30 },
            { name = "Versatility",    rating = 1620, r = 0.65, g = 0.40, b = 1.00 },
        },
    },

    content = {
        -- ── Raid BiS ────────────────────────────────────────
        raid = {
            [1]  = { itemID = 249988, name = "Primal Sentry's Maw",              source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",        source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 151323, name = "Pauldrons of the Void Hunter",       source = "Seat of the Triumvirate"         }, -- Shoulder
            [5]  = { itemID = 249991, name = "Primal Sentry's Scaleplate",        source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 244611, name = "World Tender's Barkclasp",           source = "Crafted"                         }, -- Waist
            [7]  = { itemID = 249987, name = "Primal Sentry's Legguards",         source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 244610, name = "World Tender's Rootslippers",        source = "Crafted"                         }, -- Feet
            [9]  = { itemID = 249304, name = "Fallen King's Cuffs",               source = "Fallen-King Salhadaar · Voidspire"}, -- Wrist
            [10] = { itemID = 249989, name = "Primal Sentry's Talonguards",       source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249919, name = "Sin'dorei Band of Hope",            source = "Belo'ren"                        }, -- Ring 1
            [12] = { itemID = 249336, name = "Signet of the Starved Beast",        source = "Vorasius"                        }, -- Ring 2
            [13] = { itemID = 193701, name = "Algeth'ar Puzzle Box",              source = "Algeth'ar Academy"               }, -- Trinket 1
            [14] = { itemID = 260235, name = "Umbral Plume",                      source = "Belo'ren"                        }, -- Trinket 2
            [15] = { itemID = 249335, name = "Imperator's Banner",                source = "Imperator Averzian"              }, -- Back
            [16] = { itemID = 249288, name = "Ranger-Captain's Lethal Recurve",   source = "Crown of the Cosmos · Voidspire" }, -- Ranged (bow)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Differences: Trinket 1, Trinket 2 (dungeon alternatives)
        mythicplus = {
            [1]  = { itemID = 249988, name = "Primal Sentry's Maw",              source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",        source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 151323, name = "Pauldrons of the Void Hunter",       source = "Seat of the Triumvirate"         }, -- Shoulder
            [5]  = { itemID = 249991, name = "Primal Sentry's Scaleplate",        source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 244611, name = "World Tender's Barkclasp",           source = "Crafted"                         }, -- Waist
            [7]  = { itemID = 249987, name = "Primal Sentry's Legguards",         source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 244610, name = "World Tender's Rootslippers",        source = "Crafted"                         }, -- Feet
            [9]  = { itemID = 249304, name = "Fallen King's Cuffs",               source = "Fallen-King Salhadaar · Voidspire"}, -- Wrist
            [10] = { itemID = 249989, name = "Primal Sentry's Talonguards",       source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249919, name = "Sin'dorei Band of Hope",            source = "Belo'ren"                        }, -- Ring 1
            [12] = { itemID = 249336, name = "Signet of the Starved Beast",        source = "Vorasius"                        }, -- Ring 2
            [13] = { itemID = 250258, name = "Vessel of Tortured Souls",          source = "Mythic+"                         }, -- Trinket 1 (M+)
            [14] = { itemID = 250144, name = "Emberwing Feather",                 source = "Windrunner Spire"                }, -- Trinket 2 (M+)
            [15] = { itemID = 249335, name = "Imperator's Banner",                source = "Imperator Averzian"              }, -- Back
            [16] = { itemID = 249288, name = "Ranger-Captain's Lethal Recurve",   source = "Crown of the Cosmos · Voidspire" }, -- Ranged (bow)
        },
    },
}
