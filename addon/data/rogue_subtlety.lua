-- BiS data: Subtlety Rogue — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/rogue/subtlety/bis-gear
-- Source: https://www.wowhead.com/guide/classes/rogue/subtlety/stat-priority-pve-dps
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["ROGUE_SUBTLETY"] = {
    label = "Subtlety Rogue",
    class = "ROGUE",
    spec  = "Subtlety",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
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
            [1]= { itemID = 250006, name = "Masquerade of the Grim Jest",      source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall"                         }, -- Neck
            [3]= { itemID = 250004, name = "Venom Casks of the Grim Jest",     source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250009, name = "Fantastic Finery of the Grim Jest",source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Sporefall"                         }, -- Waist
            [7]= { itemID = 251087, name = "Legwraps of Lingering Legacies",   source = "Windrunner Spire"                  }, -- Legs
            [8]= { itemID = 244569, name = "Silvermoon Agent's Sneakers",      source = "Crafted"                           }, -- Feet
            [9]= { itemID = 50264, name = "Chewed Leather Wristguards",        source = "Pit of Saron"                      }, -- Wrist
            [10]= { itemID = 250007, name = "Sleight of Hand of the Grim Jest", source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 1
            [12]= { itemID = 193708, name = "Platinum Star Band",               source = "Algeth'ar Academy"                 }, -- Ring 2
            [13]= { itemID = 249344, name = "Light Company Guidon",             source = "Imperator Averzian · The Voidspire"}, -- Trinket 1
            [14]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 2
            [15]= { itemID = 260312, name = "Defiant Defender's Drape",         source = "Magisters' Terrace"                }, -- Back
            [16]= { itemID = 249284, name = "Belo'ren's Swift Talon",           source = "Belo'ren"                          }, -- Main Hand
            [17]= { itemID = 237837, name = "Farstrider's Mercy",               source = "Crafted"                           }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 250006, name = "Masquerade of the Grim Jest",      source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall"                         }, -- Neck
            [3]= { itemID = 250004, name = "Venom Casks of the Grim Jest",     source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250009, name = "Fantastic Finery of the Grim Jest",source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Sporefall"                         }, -- Waist
            [7]= { itemID = 251087, name = "Legwraps of Lingering Legacies",   source = "Windrunner Spire"                  }, -- Legs
            [8]= { itemID = 244569, name = "Silvermoon Agent's Sneakers",      source = "Crafted"                           }, -- Feet
            [9]= { itemID = 50264, name = "Chewed Leather Wristguards",        source = "Pit of Saron"                      }, -- Wrist
            [10]= { itemID = 250007, name = "Sleight of Hand of the Grim Jest", source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 1
            [12]= { itemID = 193708, name = "Platinum Star Band",               source = "Algeth'ar Academy"                 }, -- Ring 2
            [13]= { itemID = 249344, name = "Light Company Guidon",             source = "Imperator Averzian · The Voidspire"}, -- Trinket 1
            [14]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 2
            [15]= { itemID = 260312, name = "Defiant Defender's Drape",         source = "Magisters' Terrace"                }, -- Back
            [16]= { itemID = 249284, name = "Belo'ren's Swift Talon",           source = "Belo'ren"                          }, -- Main Hand
            [17]= { itemID = 237837, name = "Farstrider's Mercy",               source = "Crafted"                           }, -- Off Hand
        },
    },
}
