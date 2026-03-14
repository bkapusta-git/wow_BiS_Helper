-- BiS data: Holy Priest — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/priest/holy/bis-gear
--         https://www.wowhead.com/guide/classes/priest/holy/stat-priority-pve-healer
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["PRIEST_HOLY"] = {
    label = "Holy Priest",
    class = "PRIEST",
    spec  = "Holy",

    -- Archon & Oracle: identical priority
    -- Raid: Mastery excels (all party healing amplified)
    -- M+: Mastery loses value (less sustained healing needed, damage matters)
    statPriority = {
        raid = {
            note  = "Archon & Oracle: identical. Mastery amplifies all party healing",
            stats = {
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = "=",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = nil,   r = 1.00, g = 0.82, b = 0.20 },
            },
        },
        mythicplus = {
            note  = "M+: Mastery loses value — no damage bonus hurts dungeon timer",
            stats = {
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
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
            [1]  = { itemID = 250051, name = "Blind Oath's Winged Crest",          source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",         source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 250049, name = "Blind Oath's Seraphguards",          source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249912, name = "Robes of Endless Oblivion",          source = "Midnight Falls"                  }, -- Chest
            [6]  = { itemID = 239664, name = "Arcanoweave Cord",                   source = "Crafted"                         }, -- Waist
            [7]  = { itemID = 250050, name = "Blind Oath's Leggings",              source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249373, name = "Dream-Scorched Striders",            source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 250047, name = "Blind Oath's Wraps",                 source = "Tier Set"                        }, -- Wrist
            [10] = { itemID = 250052, name = "Blind Oath's Touch",                 source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249336, name = "Signet of the Starved Beast",        source = "Vorasius"                        }, -- Ring 1
            [12] = { itemID = 249919, name = "Sin'dorei Band of Hope",             source = "Belo'ren"                        }, -- Ring 2
            [13] = { itemID = 249809, name = "Locus-Walker's Ribbon",              source = "Crown of the Cosmos · Voidspire" }, -- Trinket 1
            [14] = { itemID = 249343, name = "Gaze of the Alnseer",                source = "Chimaerus · The Dreamrift"       }, -- Trinket 2
            [15] = { itemID = 249335, name = "Imperator's Banner",                 source = "Imperator Averzian"              }, -- Back
            [16] = { itemID = 249293, name = "Weight of Command",                  source = "Imperator Averzian"              }, -- Main Hand
            [17] = { itemID = 245769, name = "Aln'hara Lantern",                   source = "Crafted"                         }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- No full M+ list from Wowhead; same as Raid
        mythicplus = {
            [1]  = { itemID = 250051, name = "Blind Oath's Winged Crest",          source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",         source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 250049, name = "Blind Oath's Seraphguards",          source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249912, name = "Robes of Endless Oblivion",          source = "Midnight Falls"                  }, -- Chest
            [6]  = { itemID = 239664, name = "Arcanoweave Cord",                   source = "Crafted"                         }, -- Waist
            [7]  = { itemID = 250050, name = "Blind Oath's Leggings",              source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249373, name = "Dream-Scorched Striders",            source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 250047, name = "Blind Oath's Wraps",                 source = "Tier Set"                        }, -- Wrist
            [10] = { itemID = 250052, name = "Blind Oath's Touch",                 source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249336, name = "Signet of the Starved Beast",        source = "Vorasius"                        }, -- Ring 1
            [12] = { itemID = 249919, name = "Sin'dorei Band of Hope",             source = "Belo'ren"                        }, -- Ring 2
            [13] = { itemID = 249809, name = "Locus-Walker's Ribbon",              source = "Crown of the Cosmos · Voidspire" }, -- Trinket 1
            [14] = { itemID = 249343, name = "Gaze of the Alnseer",                source = "Chimaerus · The Dreamrift"       }, -- Trinket 2
            [15] = { itemID = 249335, name = "Imperator's Banner",                 source = "Imperator Averzian"              }, -- Back
            [16] = { itemID = 249293, name = "Weight of Command",                  source = "Imperator Averzian"              }, -- Main Hand
            [17] = { itemID = 245769, name = "Aln'hara Lantern",                   source = "Crafted"                         }, -- Off Hand
        },
    },
}
