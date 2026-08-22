-- BiS data: Holy Paladin — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/paladin/holy/bis-gear
-- Source: https://www.wowhead.com/guide/classes/paladin/holy/stat-priority-pve-healer
-- Last updated: 2026-08-21

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["PALADIN_HOLY"] = {
    label = "Holy Paladin",
    class = "PALADIN",
    spec  = "Holy",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste", op = "="  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste", op = "="  , r = 1.00, g = 0.82, b = 0.20 },
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
            [1]= { itemID = 271465, name = "Warhelm of the Consecrated Flame", source = "Murder Row"                        }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271463, name = "Pauldrons of the Consecrated Flame",source = "Murder Row"                        }, -- Shoulder
            [5]= { itemID = 271468, name = "Bulwark of the Consecrated Flame", source = "The Coiled Altar"                  }, -- Chest
            [6]= { itemID = 268259, name = "Girdle of Toxic Regret",           source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271464, name = "Greaves of the Consecrated Flame", source = "Ula'tek"                           }, -- Legs
            [8]= { itemID = 268260, name = "Scaled Fiend's Warboots",          source = "Vashnik the Malignant"             }, -- Feet
            [9]= { itemID = 268239, name = "Shellbound Bracers",               source = "The Lost Explorers"                }, -- Wrist
            [10]= { itemID = 271466, name = "Gauntlets of the Consecrated Flame",source = "Entombed Sentinels"                }, -- Hands
            [11]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 1
            [12]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 2
            [13]= { itemID = 270162, name = "Soulcoiler Ritual Vessel",         source = "Nek'zali the Soulcoiler"           }, -- Trinket 1
            [14]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268211, name = "Baleful Hexblade",                 source = "The Coiled Altar"                  }, -- Main Hand
            [17]= { itemID = 268262, name = "Bubblefin Splash Guard",           source = "Nymrissa Wavecaller"               }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271465, name = "Warhelm of the Consecrated Flame", source = "Murder Row"                        }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271463, name = "Pauldrons of the Consecrated Flame",source = "Murder Row"                        }, -- Shoulder
            [5]= { itemID = 271468, name = "Bulwark of the Consecrated Flame", source = "The Coiled Altar"                  }, -- Chest
            [6]= { itemID = 268259, name = "Girdle of Toxic Regret",           source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271464, name = "Greaves of the Consecrated Flame", source = "Ula'tek"                           }, -- Legs
            [8]= { itemID = 268260, name = "Scaled Fiend's Warboots",          source = "Vashnik the Malignant"             }, -- Feet
            [9]= { itemID = 268239, name = "Shellbound Bracers",               source = "The Lost Explorers"                }, -- Wrist
            [10]= { itemID = 271466, name = "Gauntlets of the Consecrated Flame",source = "Entombed Sentinels"                }, -- Hands
            [11]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 1
            [12]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 2
            [13]= { itemID = 270162, name = "Soulcoiler Ritual Vessel",         source = "Nek'zali the Soulcoiler"           }, -- Trinket 1
            [14]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268211, name = "Baleful Hexblade",                 source = "The Coiled Altar"                  }, -- Main Hand
            [17]= { itemID = 268262, name = "Bubblefin Splash Guard",           source = "Nymrissa Wavecaller"               }, -- Off Hand
        },
    },
}
