-- BiS data: Protection Paladin — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/paladin/protection/bis-gear
-- Source: https://www.wowhead.com/guide/classes/paladin/protection/stat-priority-pve-tank
-- Last updated: 2026-08-21

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["PALADIN_PROTECTION"] = {
    label = "Protection Paladin",
    class = "PALADIN",
    spec  = "Protection",

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
            [1]= { itemID = 271465, name = "Warhelm of the Consecrated Flame", source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271463, name = "Pauldrons of the Consecrated Flame",source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 271468, name = "Bulwark of the Consecrated Flame", source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268259, name = "Girdle of Toxic Regret",           source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271878, name = "Chausses of Unbound Rancor",       source = "Ula'tek"                           }, -- Legs
            [8]= { itemID = 237828, name = "Spellbreaker's March",             source = "Crafting Blacksmithing"            }, -- Feet
            [9]= { itemID = 237834, name = "Spellbreaker's Bracers",           source = "Crafting Blacksmithing"            }, -- Wrist
            [10]= { itemID = 271466, name = "Gauntlets of the Consecrated Flame",source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268252, name = "Apex Brute's Claw Ring",           source = "Sszorak"                           }, -- Ring 1
            [12]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 2
            [13]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 1
            [14]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268209, name = "Aman'muso, Warlord's Vengeance",   source = "The Coiled Altar"                  }, -- Main Hand
            [17]= { itemID = 268196, name = "Venom-Slashed Scuteward",          source = "The Lost Explorers"                }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271465, name = "Warhelm of the Consecrated Flame", source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271463, name = "Pauldrons of the Consecrated Flame",source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 271468, name = "Bulwark of the Consecrated Flame", source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268259, name = "Girdle of Toxic Regret",           source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271878, name = "Chausses of Unbound Rancor",       source = "Ula'tek"                           }, -- Legs
            [8]= { itemID = 237828, name = "Spellbreaker's March",             source = "Crafting Blacksmithing"            }, -- Feet
            [9]= { itemID = 237834, name = "Spellbreaker's Bracers",           source = "Crafting Blacksmithing"            }, -- Wrist
            [10]= { itemID = 271466, name = "Gauntlets of the Consecrated Flame",source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268252, name = "Apex Brute's Claw Ring",           source = "Sszorak"                           }, -- Ring 1
            [12]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 2
            [13]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 1
            [14]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268209, name = "Aman'muso, Warlord's Vengeance",   source = "The Coiled Altar"                  }, -- Main Hand
            [17]= { itemID = 268196, name = "Venom-Slashed Scuteward",          source = "The Lost Explorers"                }, -- Off Hand
        },
    },
}
