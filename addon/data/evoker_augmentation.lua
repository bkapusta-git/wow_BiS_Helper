-- BiS data: Augmentation Evoker — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/evoker/augmentation/bis-gear
-- Source: https://www.wowhead.com/guide/classes/evoker/augmentation/stat-priority-pve-dps
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["EVOKER_AUGMENTATION"] = {
    label = "Augmentation Evoker",
    class = "EVOKER",
    spec  = "Augmentation",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
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
            [1]= { itemID = 249914, name = "Oblivion Guise",                   source = "Midnight Falls"                    }, -- Head
            [2]= { itemID = 249337, name = "Ribbon of Coiled Malice",          source = "Fallen-King Salhadaar · The Voidspire"}, -- Neck
            [3]= { itemID = 249995, name = "Beacons of the Black Talon",       source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250000, name = "Frenzyward of the Black Talon",    source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 49810, name = "Scabrous Zombie Leather Belt",      source = "Pit of Saron"                      }, -- Waist
            [7]= { itemID = 249996, name = "Greaves of the Black Talon",       source = "Rotmire (The Catalyst)"            }, -- Legs
            [8]= { itemID = 249999, name = "Spelltreads of the Black Talon",   source = "Rotmire (The Catalyst)"            }, -- Feet
            [9]= { itemID = 244584, name = "Farstrider's Plated Bracers",      source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 249998, name = "Enforcer's Grips of the Black Talon",source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Rotmire"                           }, -- Ring 1
            [12]= { itemID = 49812, name = "Purloined Wedding Ring",            source = "Pit of Saron"                      }, -- Ring 2
            [13]= { itemID = 249810, name = "Shadow of the Empyrean Requiem",   source = "Midnight Falls"                    }, -- Trinket 1
            [14]= { itemID = 250223, name = "Soulcatcher's Charm",              source = "Maisara Caverns"                   }, -- Trinket 2
            [15]= { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Crafted"                           }, -- Back
            [16]= { itemID = 251178, name = "Ceremonial Hexblade",              source = "Maisara Caverns"                   }, -- Main Hand
            [17]= { itemID = 249276, name = "Grimoire of the Eternal Light",    source = "Vorasius · The Voidspire"          }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 249914, name = "Oblivion Guise",                   source = "Midnight Falls"                    }, -- Head
            [2]= { itemID = 249337, name = "Ribbon of Coiled Malice",          source = "Fallen-King Salhadaar · The Voidspire"}, -- Neck
            [3]= { itemID = 249995, name = "Beacons of the Black Talon",       source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250000, name = "Frenzyward of the Black Talon",    source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 49810, name = "Scabrous Zombie Leather Belt",      source = "Pit of Saron"                      }, -- Waist
            [7]= { itemID = 249996, name = "Greaves of the Black Talon",       source = "Rotmire (The Catalyst)"            }, -- Legs
            [8]= { itemID = 249999, name = "Spelltreads of the Black Talon",   source = "Rotmire (The Catalyst)"            }, -- Feet
            [9]= { itemID = 244584, name = "Farstrider's Plated Bracers",      source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 249998, name = "Enforcer's Grips of the Black Talon",source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Rotmire"                           }, -- Ring 1
            [12]= { itemID = 49812, name = "Purloined Wedding Ring",            source = "Pit of Saron"                      }, -- Ring 2
            [13]= { itemID = 249810, name = "Shadow of the Empyrean Requiem",   source = "Midnight Falls"                    }, -- Trinket 1
            [14]= { itemID = 250223, name = "Soulcatcher's Charm",              source = "Maisara Caverns"                   }, -- Trinket 2
            [15]= { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Crafted"                           }, -- Back
            [16]= { itemID = 251178, name = "Ceremonial Hexblade",              source = "Maisara Caverns"                   }, -- Main Hand
            [17]= { itemID = 249276, name = "Grimoire of the Eternal Light",    source = "Vorasius · The Voidspire"          }, -- Off Hand
        },
    },
}
