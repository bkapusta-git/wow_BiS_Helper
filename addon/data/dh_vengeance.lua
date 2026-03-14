-- BiS data: Vengeance Demon Hunter — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/demon-hunter/vengeance/bis-gear
--         https://www.wowhead.com/guide/classes/demon-hunter/vengeance/stat-priority-pve-tank
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DEMONHUNTER_VENGEANCE"] = {
    label = "Vengeance Demon Hunter",
    class = "DEMONHUNTER",
    spec  = "Vengeance",

    -- Stat priority — source: Wowhead stat priority page
    -- Note: Item Level is always #1; secondary stats are very close in value
    statPriority = {
        raid = {
            note  = "Item Level always #1. All secondaries close in value; Mastery slightly behind",
            stats = {
                { name = "Haste",           op = ">=",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">=",  r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Mastery",         op = nil,   r = 0.30, g = 0.75, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Aldrachi Reaver: Haste becomes more important (more Soul consumption)",
            stats = {
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">=",  r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Mastery",         op = nil,   r = 0.30, g = 0.75, b = 1.00 },
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
            [1]  = { itemID = 250033, name = "Devouring Reaver's Intake",        source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 151309, name = "Necklace of the Twisting Void",    source = "Seat of the Triumvirate"         }, -- Neck
            [3]  = { itemID = 250031, name = "Devouring Reaver's Exhaustplates", source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 151313, name = "Vest of the Void's Embrace",       source = "Seat of the Triumvirate"         }, -- Chest
            [6]  = { itemID = 49806,  name = "Flayer's Black Belt",              source = "Pit of Saron"                    }, -- Waist
            [7]  = { itemID = 250032, name = "Devouring Reaver's Pistons",       source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 251210, name = "Eclipse Espadrilles",              source = "Nexus Point Xenas"               }, -- Feet
            [9]  = { itemID = 50264,  name = "Chewed Leather Wristguards",       source = "Pit of Saron"                    }, -- Wrist
            [10] = { itemID = 250034, name = "Devouring Reaver's Essence Grips", source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 251513, name = "Loa Worshiper's Band",             source = "Crafted"                         }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249344, name = "Light Company Guidon",             source = "Imperator Averzian"              }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Crafted"                         }, -- Back
            [16] = { itemID = 260408, name = "Lightless Lament",                 source = "Midnight Falls"                  }, -- Main Hand
            [17] = { itemID = 249298, name = "Tormentor's Bladed Fists",         source = "Fallen-King Salhadaar · Voidspire"}, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Key differences: Trinket 1, Main Hand
        mythicplus = {
            [1]  = { itemID = 250033, name = "Devouring Reaver's Intake",        source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 151309, name = "Necklace of the Twisting Void",    source = "Seat of the Triumvirate"         }, -- Neck
            [3]  = { itemID = 250031, name = "Devouring Reaver's Exhaustplates", source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 151313, name = "Vest of the Void's Embrace",       source = "Seat of the Triumvirate"         }, -- Chest
            [6]  = { itemID = 49806,  name = "Flayer's Black Belt",              source = "Pit of Saron"                    }, -- Waist
            [7]  = { itemID = 250032, name = "Devouring Reaver's Pistons",       source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 251210, name = "Eclipse Espadrilles",              source = "Nexus Point Xenas"               }, -- Feet
            [9]  = { itemID = 50264,  name = "Chewed Leather Wristguards",       source = "Pit of Saron"                    }, -- Wrist
            [10] = { itemID = 250034, name = "Devouring Reaver's Essence Grips", source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 251513, name = "Loa Worshiper's Band",             source = "Crafted"                         }, -- Ring 2
            [13] = { itemID = 252420, name = "Solarflare Prism",                 source = "Mythic+"                         }, -- Trinket 1 (M+)
            [14] = { itemID = 249344, name = "Light Company Guidon",             source = "Imperator Averzian"              }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Crafted"                         }, -- Back
            [16] = { itemID = 193717, name = "Mystakria's Harvester",            source = "Mythic+"                         }, -- Main Hand (M+)
            [17] = { itemID = 249298, name = "Tormentor's Bladed Fists",         source = "Fallen-King Salhadaar · Voidspire"}, -- Off Hand
        },
    },
}
