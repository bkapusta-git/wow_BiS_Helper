-- BiS data: Havoc Demon Hunter — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/demon-hunter/havoc/bis-gear
--         https://www.wowhead.com/guide/classes/demon-hunter/havoc/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DEMONHUNTER_HAVOC"] = {
    label = "Havoc Demon Hunter",
    class = "DEMONHUNTER",
    spec  = "Havoc",

    -- Stat priority — source: Wowhead stat priority page
    -- Same for both builds (Fel-Scarred & Aldrachi Reaver); same in AoE
    statPriority = {
        raid = {
            note  = "Fel-Scarred & Aldrachi Reaver: identical priority",
            stats = {
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Priority remains roughly the same in AoE",
            stats = {
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
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
            [1]  = { itemID = 251109, name = "Spellsnap Shadowmask",             source = "Magister's Terrace"              }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",       source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 250031, name = "Devouring Reaver's Exhaustplates", source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250036, name = "Devouring Reaver's Engine",        source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 251082, name = "Snapvine Cinch",                   source = "Windrunner Spire"                }, -- Waist
            [7]  = { itemID = 250032, name = "Devouring Reaver's Pistons",       source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 258577, name = "Boots of Burning Focus",           source = "Skyreach"                        }, -- Feet
            [9]  = { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 250034, name = "Devouring Reaver's Essence Grips", source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren"                        }, -- Ring 1
            [12] = { itemID = 251217, name = "Occlusion of Void",                source = "Nexus Point Xenas"               }, -- Ring 2
            [13] = { itemID = 193701, name = "Algeth'ar Puzzle Box",             source = "Algeth'ar Academy"               }, -- Trinket 1
            [14] = { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus · The Dreamrift"       }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Crafted"                         }, -- Back
            [16] = { itemID = 260408, name = "Lightless Lament",                 source = "Midnight Falls"                  }, -- Main Hand
            [17] = { itemID = 249280, name = "Emblazoned Sunglaive",             source = "The Voidspire"                   }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Same as Raid — no separate full M+ list on Wowhead
        mythicplus = {
            [1]  = { itemID = 251109, name = "Spellsnap Shadowmask",             source = "Magister's Terrace"              }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",       source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 250031, name = "Devouring Reaver's Exhaustplates", source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250036, name = "Devouring Reaver's Engine",        source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 251082, name = "Snapvine Cinch",                   source = "Windrunner Spire"                }, -- Waist
            [7]  = { itemID = 250032, name = "Devouring Reaver's Pistons",       source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 258577, name = "Boots of Burning Focus",           source = "Skyreach"                        }, -- Feet
            [9]  = { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 250034, name = "Devouring Reaver's Essence Grips", source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren"                        }, -- Ring 1
            [12] = { itemID = 251217, name = "Occlusion of Void",                source = "Nexus Point Xenas"               }, -- Ring 2
            [13] = { itemID = 193701, name = "Algeth'ar Puzzle Box",             source = "Algeth'ar Academy"               }, -- Trinket 1
            [14] = { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus · The Dreamrift"       }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Crafted"                         }, -- Back
            [16] = { itemID = 260408, name = "Lightless Lament",                 source = "Midnight Falls"                  }, -- Main Hand
            [17] = { itemID = 249280, name = "Emblazoned Sunglaive",             source = "The Voidspire"                   }, -- Off Hand
        },
    },
}
