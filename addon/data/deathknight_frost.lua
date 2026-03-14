-- BiS data: Frost Death Knight — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/death-knight/frost/bis-gear
--         https://www.wowhead.com/guide/classes/death-knight/frost/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DEATHKNIGHT_FROST"] = {
    label = "Frost Death Knight",
    class = "DEATHKNIGHT",
    spec  = "Frost",

    -- Deathbringer & Rider of the Apocalypse: identical priority
    statPriority = {
        raid = {
            note  = "Deathbringer & Rider: identical. Raid BiS uses 2H weapon",
            stats = {
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same priority as Raid — no AoE difference",
            stats = {
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
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
        -- Uses 2H weapon (Bellamy's Final Judgement)
        raid = {
            [1]  = { itemID = 249970, name = "Relentless Rider's Crown",       source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",     source = "Seat of the Triumvirate"         }, -- Neck
            [3]  = { itemID = 50234,  name = "Shoulderplates of Frozen Blood", source = "Pit of Saron"                    }, -- Shoulder
            [5]  = { itemID = 249973, name = "Relentless Rider's Cuirass",     source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249380, name = "Hate-Tied Waistchain",           source = "Crown of the Cosmos · Voidspire" }, -- Waist
            [7]  = { itemID = 249949, name = "Night Ender's Girdle",           source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249381, name = "Greaves of the Unformed",        source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 237834, name = "Spellbreaker's Bracers",         source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 249971, name = "Relentless Rider's Bonegrasps",  source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 251513, name = "Loa Worshiper's Band",           source = "Crafted"                         }, -- Ring 1
            [12] = { itemID = 249919, name = "Sin'dorei Band of Hope",         source = "Belo'ren"                        }, -- Ring 2
            [13] = { itemID = 249344, name = "Light Company Guidon",           source = "Imperator Averzian"              }, -- Trinket 1
            [14] = { itemID = 249343, name = "Gaze of the Alnseer",            source = "Chimaerus · The Dreamrift"       }, -- Trinket 2
            [15] = { itemID = 258575, name = "Rigid Scale Greatcloak",         source = "Skyreach"                        }, -- Back
            [16] = { itemID = 249277, name = "Bellamy's Final Judgement",      source = "Lightblinded Vanguard"           }, -- Main Hand (2H)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Differences: Main Hand, Trinket 1, Trinket 2
        mythicplus = {
            [1]  = { itemID = 249970, name = "Relentless Rider's Crown",       source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",     source = "Seat of the Triumvirate"         }, -- Neck
            [3]  = { itemID = 50234,  name = "Shoulderplates of Frozen Blood", source = "Pit of Saron"                    }, -- Shoulder
            [5]  = { itemID = 249973, name = "Relentless Rider's Cuirass",     source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249380, name = "Hate-Tied Waistchain",           source = "Crown of the Cosmos · Voidspire" }, -- Waist
            [7]  = { itemID = 249949, name = "Night Ender's Girdle",           source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249381, name = "Greaves of the Unformed",        source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 237834, name = "Spellbreaker's Bracers",         source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 249971, name = "Relentless Rider's Bonegrasps",  source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 251513, name = "Loa Worshiper's Band",           source = "Crafted"                         }, -- Ring 1
            [12] = { itemID = 249919, name = "Sin'dorei Band of Hope",         source = "Belo'ren"                        }, -- Ring 2
            [13] = { itemID = 193701, name = "Algeth'ar Puzzle Box",           source = "Mythic+"                         }, -- Trinket 1 (M+)
            [14] = { itemID = 252420, name = "Solarflare Prism",               source = "Mythic+"                         }, -- Trinket 2 (M+)
            [15] = { itemID = 258575, name = "Rigid Scale Greatcloak",         source = "Skyreach"                        }, -- Back
            [16] = { itemID = 258525, name = "Scepter of the Endless Night",   source = "Mythic+"                         }, -- Main Hand (M+)
        },
    },
}
