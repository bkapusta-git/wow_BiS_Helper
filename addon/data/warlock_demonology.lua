-- BiS data: Demonology Warlock — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/warlock/demonology/bis-gear
--         https://www.wowhead.com/guide/classes/warlock/demonology/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["WARLOCK_DEMONOLOGY"] = {
    label = "Demonology Warlock",
    class = "WARLOCK",
    spec  = "Demonology",

    -- Hellcaller & Soul Harvester: Haste = Crit > Mastery > Vers
    statPriority = {
        raid = {
            note  = "Haste = Crit > Mastery > Vers. Both hero talents share identical priority",
            stats = {
                { name = "Haste",           op = "=",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same as Raid",
            stats = {
                { name = "Haste",           op = "=",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
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
        -- Demonology uses a 2H staff
        raid = {
            [1]  = { itemID = 250042, name = "Abyssal Immolator's Smoldering Flames", source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 50228,  name = "Barbed Ymirheim Choker",                source = "Pit of Saron"                    }, -- Neck
            [3]  = { itemID = 251085, name = "Mantle of Dark Devotion",               source = "Windrunner Spire"                }, -- Shoulder
            [5]  = { itemID = 250045, name = "Abyssal Immolator's Dreadrobe",         source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249376, name = "Whisper-Inscribed Sash",                source = "Belo'ren"                        }, -- Waist
            [7]  = { itemID = 250041, name = "Abyssal Immolator's Pillars",           source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249373, name = "Dream-Scorched Striders",               source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 249315, name = "Voracious Wristwraps",                  source = "Vorasius"                        }, -- Wrist
            [10] = { itemID = 250043, name = "Abyssal Immolator's Grasps",            source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                       source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 241140, name = "Signet of Azerothian Blessings",        source = "Crafted"                         }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                   source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249810, name = "Shadow of the Empyrean Requiem",        source = "Midnight Falls"                  }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",              source = "Crafted"                         }, -- Back
            [16] = { itemID = 193707, name = "Final Grade",                           source = "Algeth'ar Academy"               }, -- Main Hand (2H staff)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Same as Raid
        mythicplus = {
            [1]  = { itemID = 250042, name = "Abyssal Immolator's Smoldering Flames", source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 50228,  name = "Barbed Ymirheim Choker",                source = "Pit of Saron"                    }, -- Neck
            [3]  = { itemID = 251085, name = "Mantle of Dark Devotion",               source = "Windrunner Spire"                }, -- Shoulder
            [5]  = { itemID = 250045, name = "Abyssal Immolator's Dreadrobe",         source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249376, name = "Whisper-Inscribed Sash",                source = "Belo'ren"                        }, -- Waist
            [7]  = { itemID = 250041, name = "Abyssal Immolator's Pillars",           source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249373, name = "Dream-Scorched Striders",               source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 249315, name = "Voracious Wristwraps",                  source = "Vorasius"                        }, -- Wrist
            [10] = { itemID = 250043, name = "Abyssal Immolator's Grasps",            source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                       source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 241140, name = "Signet of Azerothian Blessings",        source = "Crafted"                         }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                   source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249810, name = "Shadow of the Empyrean Requiem",        source = "Midnight Falls"                  }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",              source = "Crafted"                         }, -- Back
            [16] = { itemID = 193707, name = "Final Grade",                           source = "Algeth'ar Academy"               }, -- Main Hand (2H staff)
        },
    },
}
