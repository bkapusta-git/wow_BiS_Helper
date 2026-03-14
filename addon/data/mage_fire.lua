-- BiS data: Fire Mage — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/mage/fire/bis-gear
--         https://www.wowhead.com/guide/classes/mage/fire/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["MAGE_FIRE"] = {
    label = "Fire Mage",
    class = "MAGE",
    spec  = "Fire",

    -- Sunfury & Frostfire: identical priority
    statPriority = {
        raid = {
            note  = "Sunfury & Frostfire: identical. Haste increases Combustion cast windows",
            stats = {
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = nil,   r = 1.00, g = 0.35, b = 0.35 },
            },
        },
        mythicplus = {
            note  = "Same as Raid — M+ uses dungeon trinket alternative",
            stats = {
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = nil,   r = 1.00, g = 0.35, b = 0.35 },
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
        -- Fire Mage uses a 2H staff
        raid = {
            [1]  = { itemID = 250060, name = "Voidbreaker's Veil",             source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",     source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 250058, name = "Voidbreaker's Leyline Nexi",     source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249912, name = "Robes of Endless Oblivion",      source = "Midnight Falls"                  }, -- Chest
            [6]  = { itemID = 249376, name = "Whisper-Inscribed Sash",         source = "Belo'ren"                        }, -- Waist
            [7]  = { itemID = 250059, name = "Voidbreaker's Britches",         source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 258584, name = "Lightbinder Treads",             source = "Skyreach"                        }, -- Feet
            [9]  = { itemID = 239648, name = "Martyr's Bindings",              source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 250061, name = "Voidbreaker's Gloves",           source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249369, name = "Bond of Light",                  source = "Lightblinded Vanguard"           }, -- Ring 2
            [13] = { itemID = 250144, name = "Emberwing Feather",              source = "Windrunner Spire"                }, -- Trinket 1
            [14] = { itemID = 249343, name = "Gaze of the Alnseer",            source = "Chimaerus · The Dreamrift"       }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",       source = "Crafted"                         }, -- Back
            [16] = { itemID = 249286, name = "Brazier of the Dissonant Dirge", source = "Midnight Falls"                  }, -- Main Hand (2H staff)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Difference: Trinket 2 (Omission of Light preferred in M+)
        mythicplus = {
            [1]  = { itemID = 250060, name = "Voidbreaker's Veil",             source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",     source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 250058, name = "Voidbreaker's Leyline Nexi",     source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249912, name = "Robes of Endless Oblivion",      source = "Midnight Falls"                  }, -- Chest
            [6]  = { itemID = 249376, name = "Whisper-Inscribed Sash",         source = "Belo'ren"                        }, -- Waist
            [7]  = { itemID = 250059, name = "Voidbreaker's Britches",         source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 258584, name = "Lightbinder Treads",             source = "Skyreach"                        }, -- Feet
            [9]  = { itemID = 239648, name = "Martyr's Bindings",              source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 250061, name = "Voidbreaker's Gloves",           source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249369, name = "Bond of Light",                  source = "Lightblinded Vanguard"           }, -- Ring 2
            [13] = { itemID = 250144, name = "Emberwing Feather",              source = "Windrunner Spire"                }, -- Trinket 1
            [14] = { itemID = 251093, name = "Omission of Light",              source = "Nexus Point Xenas"               }, -- Trinket 2 (M+)
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",       source = "Crafted"                         }, -- Back
            [16] = { itemID = 249286, name = "Brazier of the Dissonant Dirge", source = "Midnight Falls"                  }, -- Main Hand (2H staff)
        },
    },
}
