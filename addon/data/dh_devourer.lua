-- BiS data: Devourer Demon Hunter — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/demon-hunter/devourer/bis-gear
-- Source: https://www.wowhead.com/guide/classes/demon-hunter/devourer/stat-priority-pve-dps
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DEMONHUNTER_DEVOURER"] = {
    label = "Devourer Demon Hunter",
    class = "DEMONHUNTER",
    spec  = "Devourer",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        dr = {
            { name = "Haste", rating = 1320, r = 1.00, g = 0.82, b = 0.20 },
            { name = "Crit / Mastery", rating = 1380, r = 1.00, g = 0.60, b = 0.30 },
            { name = "Versatility", rating = 1620, r = 0.65, g = 0.40, b = 1.00 },
        },
    },

    content = {
        -- ── Raid BiS ────────────────────────────────────────
        raid = {
            [1]= { itemID = 250033, name = "Devouring Reaver's Intake",        source = "Sporefall to Catalyze!"            }, -- Head
            [2]= { itemID = 249368, name = "Eternal Voidsong Chain",           source = "Crown of the Cosmos · The Voidspire"}, -- Neck
            [3]= { itemID = 250031, name = "Devouring Reaver's Exhaustplates", source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250036, name = "Devouring Reaver's Engine",        source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Sporefall"                         }, -- Waist
            [7]= { itemID = 49817, name = "Shaggy Wyrmleather Leggings",       source = "Pit of Saron"                      }, -- Legs
            [8]= { itemID = 244569, name = "Silvermoon Agent's Sneakers",      source = "Crafted"                           }, -- Feet
            [9]= { itemID = 193714, name = "Frenzyroot Cuffs",                 source = "Algeth'ar Academy"                 }, -- Wrist
            [10]= { itemID = 250034, name = "Devouring Reaver's Essence Grips", source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 1
            [12]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls"                    }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 249346, name = "Vaelgor's Final Stare",            source = "Vaelgor & Ezzorak · The Voidspire" }, -- Trinket 2
            [15]= { itemID = 249370, name = "Draconic Nullcape",                source = "Vaelgor & Ezzorak · The Voidspire" }, -- Back
            [16]= { itemID = 260408, name = "Lightless Lament",                 source = "Midnight Falls"                    }, -- Main Hand
            [17]= { itemID = 237840, name = "Spellbreaker's Warglaive",         source = "Crafted"                           }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 250033, name = "Devouring Reaver's Intake",        source = "Sporefall to Catalyze!"            }, -- Head
            [2]= { itemID = 249368, name = "Eternal Voidsong Chain",           source = "Crown of the Cosmos · The Voidspire"}, -- Neck
            [3]= { itemID = 250031, name = "Devouring Reaver's Exhaustplates", source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250036, name = "Devouring Reaver's Engine",        source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Sporefall"                         }, -- Waist
            [7]= { itemID = 49817, name = "Shaggy Wyrmleather Leggings",       source = "Pit of Saron"                      }, -- Legs
            [8]= { itemID = 244569, name = "Silvermoon Agent's Sneakers",      source = "Crafted"                           }, -- Feet
            [9]= { itemID = 193714, name = "Frenzyroot Cuffs",                 source = "Algeth'ar Academy"                 }, -- Wrist
            [10]= { itemID = 250034, name = "Devouring Reaver's Essence Grips", source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 1
            [12]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls"                    }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 249346, name = "Vaelgor's Final Stare",            source = "Vaelgor & Ezzorak · The Voidspire" }, -- Trinket 2
            [15]= { itemID = 249370, name = "Draconic Nullcape",                source = "Vaelgor & Ezzorak · The Voidspire" }, -- Back
            [16]= { itemID = 260408, name = "Lightless Lament",                 source = "Midnight Falls"                    }, -- Main Hand
            [17]= { itemID = 237840, name = "Spellbreaker's Warglaive",         source = "Crafted"                           }, -- Off Hand
        },
    },
}
