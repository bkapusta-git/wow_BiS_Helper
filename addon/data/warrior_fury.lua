-- BiS data: Fury Warrior — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/warrior/fury/bis-gear
-- Source: https://www.wowhead.com/guide/classes/warrior/fury/stat-priority-pve-dps
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["WARRIOR_FURY"] = {
    label = "Fury Warrior",
    class = "WARRIOR",
    spec  = "Fury",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
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
            [1]= { itemID = 249952, name = "Night Ender's Tusks",              source = "Tier Set"                          }, -- Head
            [2]= { itemID = 250247, name = "Amulet of the Abyssal Hymn",       source = "Midnight Falls"                    }, -- Neck
            [3]= { itemID = 249950, name = "Night Ender's Pauldrons",          source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 249955, name = "Night Ender's Breastplate",        source = "Rotmire (Catalyst)"                }, -- Chest
            [6]= { itemID = 268289, name = "Girdle of Devouring Rot",          source = "Rotmire"                           }, -- Waist
            [7]= { itemID = 249951, name = "Night Ender's Chausses",           source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 260377, name = "Fading Dawn Sabatons",             source = "Raid BoE for targeted stats"       }, -- Feet
            [9]= { itemID = 237834, name = "Spellbreaker's Bracers",           source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 151332, name = "Voidclaw Gauntlets",               source = "Seat of the Triumvirate"           }, -- Hands
            [11]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls"                    }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Rotmire"                           }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 249342, name = "Heart of Ancient Hunger",          source = "Vorasius · The Voidspire"          }, -- Trinket 2
            [15]= { itemID = 258575, name = "Rigid Scale Greatcloak",           source = "Skyreach"                          }, -- Back
            [16]= { itemID = 249277, name = "Bellamy's Final Judgement",        source = "Lightblinded Vanguard · The Voidspire"}, -- Main Hand
            [17]= { itemID = 237846, name = "Blood Knight's Warblade",          source = "Crafted"                           }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 249952, name = "Night Ender's Tusks",              source = "Tier Set"                          }, -- Head
            [2]= { itemID = 250247, name = "Amulet of the Abyssal Hymn",       source = "Midnight Falls"                    }, -- Neck
            [3]= { itemID = 249950, name = "Night Ender's Pauldrons",          source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 249955, name = "Night Ender's Breastplate",        source = "Rotmire (Catalyst)"                }, -- Chest
            [6]= { itemID = 268289, name = "Girdle of Devouring Rot",          source = "Rotmire"                           }, -- Waist
            [7]= { itemID = 249951, name = "Night Ender's Chausses",           source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 260377, name = "Fading Dawn Sabatons",             source = "Raid BoE for targeted stats"       }, -- Feet
            [9]= { itemID = 237834, name = "Spellbreaker's Bracers",           source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 151332, name = "Voidclaw Gauntlets",               source = "Seat of the Triumvirate"           }, -- Hands
            [11]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls"                    }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Rotmire"                           }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 249342, name = "Heart of Ancient Hunger",          source = "Vorasius · The Voidspire"          }, -- Trinket 2
            [15]= { itemID = 258575, name = "Rigid Scale Greatcloak",           source = "Skyreach"                          }, -- Back
            [16]= { itemID = 249277, name = "Bellamy's Final Judgement",        source = "Lightblinded Vanguard · The Voidspire"}, -- Main Hand
            [17]= { itemID = 237846, name = "Blood Knight's Warblade",          source = "Crafted"                           }, -- Off Hand
        },
    },
}
