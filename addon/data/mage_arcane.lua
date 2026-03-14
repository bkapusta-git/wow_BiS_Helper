-- BiS data: Arcane Mage — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/mage/arcane/bis-gear
--         https://www.wowhead.com/guide/classes/mage/arcane/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["MAGE_ARCANE"] = {
    label = "Arcane Mage",
    class = "MAGE",
    spec  = "Arcane",

    -- Spellslinger & Sunfury: identical priority
    statPriority = {
        raid = {
            note  = "Spellslinger & Sunfury: identical. Mastery amplifies Arcane Charges",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = ">=",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same as Raid",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = ">=",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
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
        -- Arcane Mage uses 1H weapon + off-hand
        raid = {
            [1]  = { itemID = 250060, name = "Voidbreaker's Veil",             source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",     source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 250058, name = "Voidbreaker's Leyline Nexi",     source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250063, name = "Voidbreaker's Robe",             source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249376, name = "Whisper-Inscribed Sash",         source = "Belo'ren"                        }, -- Waist
            [7]  = { itemID = 251090, name = "Commander's Faded Breeches",     source = "Windrunner Spire"                }, -- Legs
            [8]  = { itemID = 249373, name = "Dream-Scorched Striders",        source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 239660, name = "Arcanoweave Bracers",            source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 250061, name = "Voidbreaker's Gloves",           source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249919, name = "Sin'dorei Band of Hope",         source = "Belo'ren"                        }, -- Ring 1
            [12] = { itemID = 249920, name = "Eye of Midnight",                source = "Midnight Falls"                  }, -- Ring 2
            [13] = { itemID = 249346, name = "Vaelgor's Final Stare",          source = "Vaelgor & Ezzorak · Voidspire"   }, -- Trinket 1
            [14] = { itemID = 249343, name = "Gaze of the Alnseer",            source = "Chimaerus · The Dreamrift"       }, -- Trinket 2
            [15] = { itemID = 239661, name = "Arcanoweave Cloak",              source = "Crafted"                         }, -- Back
            [16] = { itemID = 258218, name = "Skybreaker's Blade",             source = "Skyreach"                        }, -- Main Hand
            [17] = { itemID = 251094, name = "Sigil of the Restless Heart",    source = "Windrunner Spire"                }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- No full M+ list from Wowhead; same as Raid
        mythicplus = {
            [1]  = { itemID = 250060, name = "Voidbreaker's Veil",             source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",     source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 250058, name = "Voidbreaker's Leyline Nexi",     source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250063, name = "Voidbreaker's Robe",             source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249376, name = "Whisper-Inscribed Sash",         source = "Belo'ren"                        }, -- Waist
            [7]  = { itemID = 251090, name = "Commander's Faded Breeches",     source = "Windrunner Spire"                }, -- Legs
            [8]  = { itemID = 249373, name = "Dream-Scorched Striders",        source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 239660, name = "Arcanoweave Bracers",            source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 250061, name = "Voidbreaker's Gloves",           source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249919, name = "Sin'dorei Band of Hope",         source = "Belo'ren"                        }, -- Ring 1
            [12] = { itemID = 249920, name = "Eye of Midnight",                source = "Midnight Falls"                  }, -- Ring 2
            [13] = { itemID = 249346, name = "Vaelgor's Final Stare",          source = "Vaelgor & Ezzorak · Voidspire"   }, -- Trinket 1
            [14] = { itemID = 249343, name = "Gaze of the Alnseer",            source = "Chimaerus · The Dreamrift"       }, -- Trinket 2
            [15] = { itemID = 239661, name = "Arcanoweave Cloak",              source = "Crafted"                         }, -- Back
            [16] = { itemID = 258218, name = "Skybreaker's Blade",             source = "Skyreach"                        }, -- Main Hand
            [17] = { itemID = 251094, name = "Sigil of the Restless Heart",    source = "Windrunner Spire"                }, -- Off Hand
        },
    },
}
