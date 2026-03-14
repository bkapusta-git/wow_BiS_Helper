-- BiS data: Frost Mage — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/mage/frost/bis-gear
--         https://www.wowhead.com/guide/classes/mage/frost/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["MAGE_FROST"] = {
    label = "Frost Mage",
    class = "MAGE",
    spec  = "Frost",

    -- Frostfire & Spellslinger: identical priority; no build differences
    statPriority = {
        raid = {
            note  = "Frostfire & Spellslinger: identical priority",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same priority as Raid — no AoE difference for Frost",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
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
        raid = {
            [1]  = { itemID = 250060, name = "Voidbreaker's Veil",          source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",  source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 251085, name = "Mantle of Dark Devotion",      source = "Windrunner Spire"                }, -- Shoulder
            [5]  = { itemID = 250063, name = "Voidbreaker's Robe",           source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 250057, name = "Voidbreaker's Sage Cord",      source = "Catalyst"                        }, -- Waist
            [7]  = { itemID = 250059, name = "Voidbreaker's Britches",       source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249373, name = "Dream-Scorched Striders",      source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 258580, name = "Bracers of Blazing Light",     source = "Skyreach"                        }, -- Wrist
            [10] = { itemID = 250061, name = "Voidbreaker's Gloves",         source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249919, name = "Sin'dorei Band of Hope",       source = "Belo'ren"                        }, -- Ring 1
            [12] = { itemID = 193708, name = "Platinum Star Band",           source = "Algeth'ar Academy"               }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",          source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 250144, name = "Emberwing Feather",            source = "Windrunner Spire"                }, -- Trinket 2
            [15] = { itemID = 258575, name = "Rigid Scale Greatcloak",       source = "Skyreach"                        }, -- Back
            [16] = { itemID = 258514, name = "Umbral Spire of Zuraal",       source = "Seat of the Triumvirate"         }, -- Main Hand (Staff)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Difference: Trinket 1 (Vessel of Tortured Souls preferred in M+)
        mythicplus = {
            [1]  = { itemID = 250060, name = "Voidbreaker's Veil",          source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",  source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 251085, name = "Mantle of Dark Devotion",      source = "Windrunner Spire"                }, -- Shoulder
            [5]  = { itemID = 250063, name = "Voidbreaker's Robe",           source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 250057, name = "Voidbreaker's Sage Cord",      source = "Catalyst"                        }, -- Waist
            [7]  = { itemID = 250059, name = "Voidbreaker's Britches",       source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249373, name = "Dream-Scorched Striders",      source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 258580, name = "Bracers of Blazing Light",     source = "Skyreach"                        }, -- Wrist
            [10] = { itemID = 250061, name = "Voidbreaker's Gloves",         source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249919, name = "Sin'dorei Band of Hope",       source = "Belo'ren"                        }, -- Ring 1
            [12] = { itemID = 193708, name = "Platinum Star Band",           source = "Algeth'ar Academy"               }, -- Ring 2
            [13] = { itemID = 250258, name = "Vessel of Tortured Souls",     source = "Mythic+"                         }, -- Trinket 1 (M+)
            [14] = { itemID = 250144, name = "Emberwing Feather",            source = "Windrunner Spire"                }, -- Trinket 2
            [15] = { itemID = 258575, name = "Rigid Scale Greatcloak",       source = "Skyreach"                        }, -- Back
            [16] = { itemID = 258514, name = "Umbral Spire of Zuraal",       source = "Seat of the Triumvirate"         }, -- Main Hand (Staff)
        },
    },
}
