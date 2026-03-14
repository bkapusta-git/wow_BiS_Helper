-- BiS data: Arms Warrior — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/warrior/arms/bis-gear
--         https://www.wowhead.com/guide/classes/warrior/arms/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["WARRIOR_ARMS"] = {
    label = "Arms Warrior",
    class = "WARRIOR",
    spec  = "Arms",

    -- Slayer & Colossus: Crit >= Haste > Mastery > Vers
    statPriority = {
        raid = {
            note  = "Crit >= Haste > Mastery > Vers. Crit boosts Rage generation and burst windows",
            stats = {
                { name = "Critical Strike", op = ">=",  r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same as Raid",
            stats = {
                { name = "Critical Strike", op = ">=",  r = 1.00, g = 0.35, b = 0.35 },
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
        -- Arms uses 2H weapon
        raid = {
            [1]  = { itemID = 249952, name = "Night Ender's Tusks",            source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 249337, name = "Ribbon of Coiled Malice",         source = "Fallen-King Salhadaar · Voidspire"}, -- Neck
            [3]  = { itemID = 249950, name = "Night Ender's Pauldrons",         source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249955, name = "Night Ender's Breastplate",       source = "Chimaerus · The Dreamrift"       }, -- Chest
            [6]  = { itemID = 249949, name = "Night Ender's Girdle",            source = "Catalyst"                        }, -- Waist
            [7]  = { itemID = 249951, name = "Night Ender's Chausses",          source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249381, name = "Greaves of the Unformed",         source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 237834, name = "Spellbreaker's Bracers",          source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 251081, name = "Embergrove Grasps",               source = "Windrunner Spire"                }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                 source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 251217, name = "Occlusion of Void",               source = "Nexus Point Xenas"               }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",             source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249342, name = "Heart of Ancient Hunger",         source = "Vorasius"                        }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",        source = "Crafted"                         }, -- Back
            [16] = { itemID = 249296, name = "Alah'endal, the Dawnsong",        source = "Midnight Falls"                  }, -- Main Hand (2H)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Same as Raid
        mythicplus = {
            [1]  = { itemID = 249952, name = "Night Ender's Tusks",            source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 249337, name = "Ribbon of Coiled Malice",         source = "Fallen-King Salhadaar · Voidspire"}, -- Neck
            [3]  = { itemID = 249950, name = "Night Ender's Pauldrons",         source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249955, name = "Night Ender's Breastplate",       source = "Chimaerus · The Dreamrift"       }, -- Chest
            [6]  = { itemID = 249949, name = "Night Ender's Girdle",            source = "Catalyst"                        }, -- Waist
            [7]  = { itemID = 249951, name = "Night Ender's Chausses",          source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249381, name = "Greaves of the Unformed",         source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 237834, name = "Spellbreaker's Bracers",          source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 251081, name = "Embergrove Grasps",               source = "Windrunner Spire"                }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                 source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 251217, name = "Occlusion of Void",               source = "Nexus Point Xenas"               }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",             source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249342, name = "Heart of Ancient Hunger",         source = "Vorasius"                        }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",        source = "Crafted"                         }, -- Back
            [16] = { itemID = 249296, name = "Alah'endal, the Dawnsong",        source = "Midnight Falls"                  }, -- Main Hand (2H)
        },
    },
}
