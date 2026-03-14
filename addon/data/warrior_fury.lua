-- BiS data: Fury Warrior — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/warrior/fury/bis-gear
--         https://www.wowhead.com/guide/classes/warrior/fury/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["WARRIOR_FURY"] = {
    label = "Fury Warrior",
    class = "WARRIOR",
    spec  = "Fury",

    -- Slayer & Titan's Grip: Haste >= Mastery > Crit = Vers
    statPriority = {
        raid = {
            note  = "Haste >= Mastery > Crit = Vers. Haste reduces GCD and speeds Bloodthirst/Execute",
            stats = {
                { name = "Haste",           op = ">=",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = "=",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same as Raid",
            stats = {
                { name = "Haste",           op = ">=",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = "=",   r = 1.00, g = 0.35, b = 0.35 },
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
        -- Fury dual-wields 2H weapons (Titan's Grip)
        raid = {
            [1]  = { itemID = 249952, name = "Night Ender's Tusks",            source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",     source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 249950, name = "Night Ender's Pauldrons",         source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249955, name = "Night Ender's Breastplate",       source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249949, name = "Night Ender's Girdle",            source = "Catalyst"                        }, -- Waist
            [7]  = { itemID = 249951, name = "Night Ender's Chausses",          source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249954, name = "Night Ender's Greatboots",        source = "Catalyst"                        }, -- Feet
            [9]  = { itemID = 237834, name = "Spellbreaker's Bracers",          source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 249953, name = "Night Ender's Fists",             source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                 source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249369, name = "Bond of Light",                   source = "Lightblinded Vanguard"           }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",             source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249342, name = "Heart of Ancient Hunger",         source = "Vorasius"                        }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",        source = "Crafted"                         }, -- Back
            [16] = { itemID = 249277, name = "Bellamy's Final Judgement",       source = "Lightblinded Vanguard"           }, -- Main Hand (2H)
            [17] = { itemID = 249296, name = "Alah'endal, the Dawnsong",        source = "Midnight Falls"                  }, -- Off Hand (2H, Titan's Grip)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Same as Raid (M+ weapons: Whirling Voidcleaver, Liferipper's Cutlass)
        mythicplus = {
            [1]  = { itemID = 249952, name = "Night Ender's Tusks",            source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",     source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 249950, name = "Night Ender's Pauldrons",         source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249955, name = "Night Ender's Breastplate",       source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249949, name = "Night Ender's Girdle",            source = "Catalyst"                        }, -- Waist
            [7]  = { itemID = 249951, name = "Night Ender's Chausses",          source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249954, name = "Night Ender's Greatboots",        source = "Catalyst"                        }, -- Feet
            [9]  = { itemID = 237834, name = "Spellbreaker's Bracers",          source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 249953, name = "Night Ender's Fists",             source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                 source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249369, name = "Bond of Light",                   source = "Lightblinded Vanguard"           }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",             source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249342, name = "Heart of Ancient Hunger",         source = "Vorasius"                        }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",        source = "Crafted"                         }, -- Back
            [16] = { itemID = 249277, name = "Bellamy's Final Judgement",       source = "Lightblinded Vanguard"           }, -- Main Hand (2H)
            [17] = { itemID = 249296, name = "Alah'endal, the Dawnsong",        source = "Midnight Falls"                  }, -- Off Hand (2H, Titan's Grip)
        },
    },
}
