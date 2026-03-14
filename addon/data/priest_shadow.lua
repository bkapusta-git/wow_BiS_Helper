-- BiS data: Shadow Priest — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/priest/shadow/bis-gear
--         https://www.wowhead.com/guide/classes/priest/shadow/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["PRIEST_SHADOW"] = {
    label = "Shadow Priest",
    class = "PRIEST",
    spec  = "Shadow",

    -- Archon & Voidweaver: identical priority; same in AoE
    statPriority = {
        raid = {
            note  = "Archon & Voidweaver: identical priority",
            stats = {
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "No AoE difference — same priority as Raid",
            stats = {
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
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
        raid = {
            [1]  = { itemID = 250051, name = "Blind Oath's Winged Crest",          source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",         source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 250049, name = "Blind Oath's Seraphguards",          source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250054, name = "Blind Oath's Raiment",               source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249376, name = "Whisper-Inscribed Sash",             source = "Belo'ren"                        }, -- Waist
            [7]  = { itemID = 250050, name = "Blind Oath's Leggings",              source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249373, name = "Dream-Scorched Striders",            source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 251108, name = "Wraps of Watchful Wrath",            source = "Magister's Terrace"              }, -- Wrist
            [10] = { itemID = 250052, name = "Blind Oath's Touch",                 source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                    source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249919, name = "Sin'dorei Band of Hope",             source = "Belo'ren"                        }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249346, name = "Vaelgor's Final Stare",              source = "Vaelgor & Ezzorak · Voidspire"   }, -- Trinket 2
            [15] = { itemID = 249370, name = "Draconic Nullcape",                  source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 249283, name = "Belo'melorn, the Shattered Talon",   source = "Belo'ren"                        }, -- Main Hand
            [17] = { itemID = 249922, name = "Tome of Alnscorned Regret",          source = "Chimaerus · The Dreamrift"       }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Differences: Trinket 1, Trinket 2, Main Hand
        mythicplus = {
            [1]  = { itemID = 250051, name = "Blind Oath's Winged Crest",          source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",         source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 250049, name = "Blind Oath's Seraphguards",          source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250054, name = "Blind Oath's Raiment",               source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249376, name = "Whisper-Inscribed Sash",             source = "Belo'ren"                        }, -- Waist
            [7]  = { itemID = 250050, name = "Blind Oath's Leggings",              source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249373, name = "Dream-Scorched Striders",            source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 251108, name = "Wraps of Watchful Wrath",            source = "Magister's Terrace"              }, -- Wrist
            [10] = { itemID = 250052, name = "Blind Oath's Touch",                 source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                    source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249919, name = "Sin'dorei Band of Hope",             source = "Belo'ren"                        }, -- Ring 2
            [13] = { itemID = 250258, name = "Vessel of Tortured Souls",           source = "Mythic+"                         }, -- Trinket 1 (M+)
            [14] = { itemID = 250144, name = "Emberwing Feather",                  source = "Emberdawn"                       }, -- Trinket 2 (M+)
            [15] = { itemID = 249370, name = "Draconic Nullcape",                  source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 193707, name = "Final Grade",                        source = "Mythic+"                         }, -- Main Hand (M+)
            [17] = { itemID = 249922, name = "Tome of Alnscorned Regret",          source = "Chimaerus · The Dreamrift"       }, -- Off Hand
        },
    },
}
