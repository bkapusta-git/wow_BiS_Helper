-- BiS data: Beast Mastery Hunter — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/hunter/beast-mastery/bis-gear
--         https://www.wowhead.com/guide/classes/hunter/beast-mastery/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["HUNTER_BEASTMASTERY"] = {
    label = "Beast Mastery Hunter",
    class = "HUNTER",
    spec  = "Beast Mastery",

    -- ST: Haste > Crit > Mastery > Vers; AoE: Crit > Haste > Mastery > Vers
    statPriority = {
        raid = {
            note  = "Single-target: Haste>Crit. AoE: Crit>Haste. Mastery boosts pet damage",
            stats = {
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "M+/AoE: Crit moves above Haste",
            stats = {
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
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
        -- Hunter uses a ranged weapon (bow/gun/crossbow) in Main Hand slot; no Off Hand
        raid = {
            [1]  = { itemID = 249988, name = "Primal Sentry's Maw",              source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",        source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 151323, name = "Pauldrons of the Void Hunter",       source = "Seat of the Triumvirate"         }, -- Shoulder
            [5]  = { itemID = 249991, name = "Primal Sentry's Scaleplate",        source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 244611, name = "World Tender's Barkclasp",           source = "Crafted"                         }, -- Waist
            [7]  = { itemID = 249987, name = "Primal Sentry's Legguards",         source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 244610, name = "World Tender's Rootslippers",        source = "Crafted"                         }, -- Feet
            [9]  = { itemID = 251209, name = "Corewarden Cuffs",                  source = "Nexus Point Xenas"               }, -- Wrist
            [10] = { itemID = 249989, name = "Primal Sentry's Talonguards",       source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                   source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249369, name = "Bond of Light",                     source = "Lightblinded Vanguard"           }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",               source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 193701, name = "Algeth'ar Puzzle Box",              source = "Algeth'ar Academy"               }, -- Trinket 2
            [15] = { itemID = 258575, name = "Rigid Scale Greatcloak",            source = "Skyreach"                        }, -- Back
            [16] = { itemID = 251174, name = "Deceiver's Rotbow",                 source = "Maisara Caverns"                 }, -- Ranged (bow)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- No full M+ list from Wowhead; same as Raid
        mythicplus = {
            [1]  = { itemID = 249988, name = "Primal Sentry's Maw",              source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",        source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 151323, name = "Pauldrons of the Void Hunter",       source = "Seat of the Triumvirate"         }, -- Shoulder
            [5]  = { itemID = 249991, name = "Primal Sentry's Scaleplate",        source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 244611, name = "World Tender's Barkclasp",           source = "Crafted"                         }, -- Waist
            [7]  = { itemID = 249987, name = "Primal Sentry's Legguards",         source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 244610, name = "World Tender's Rootslippers",        source = "Crafted"                         }, -- Feet
            [9]  = { itemID = 251209, name = "Corewarden Cuffs",                  source = "Nexus Point Xenas"               }, -- Wrist
            [10] = { itemID = 249989, name = "Primal Sentry's Talonguards",       source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                   source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249369, name = "Bond of Light",                     source = "Lightblinded Vanguard"           }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",               source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 193701, name = "Algeth'ar Puzzle Box",              source = "Algeth'ar Academy"               }, -- Trinket 2
            [15] = { itemID = 258575, name = "Rigid Scale Greatcloak",            source = "Skyreach"                        }, -- Back
            [16] = { itemID = 251174, name = "Deceiver's Rotbow",                 source = "Maisara Caverns"                 }, -- Ranged (bow)
        },
    },
}
