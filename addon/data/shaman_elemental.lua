-- BiS data: Elemental Shaman — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/shaman/elemental/bis-gear
-- Source: https://www.wowhead.com/guide/classes/shaman/elemental/stat-priority-pve-dps
-- Last updated: 2026-08-21

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["SHAMAN_ELEMENTAL"] = {
    label = "Elemental Shaman",
    class = "SHAMAN",
    spec  = "Elemental",

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
            [1]= { itemID = 271483, name = "Serpent Crown of the Ophidian Oracle",source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271481, name = "Hissing Mantle of the Ophidian Oracle",source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 271486, name = "Fanged Raiment of the Ophidian Oracle",source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268254, name = "Serpentine Mixing Belt",           source = "Vashnik the Malignant"             }, -- Waist
            [7]= { itemID = 271482, name = "Leggings of the Ophidian Oracle",  source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 244577, name = "Farstrider's Razor Talons",        source = "Crafting"                          }, -- Feet
            [9]= { itemID = 244584, name = "Farstrider's Plated Bracers",      source = "Crafting"                          }, -- Wrist
            [10]= { itemID = 271484, name = "Hexing Grips of the Ophidian Oracle",source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 1
            [12]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 1
            [14]= { itemID = 273796, name = "Vile Vial of Volatile Venom",      source = "Altar of Fangs"                    }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 268262, name = "Bubblefin Splash Guard",           source = "Nymrissa Wavecaller"               }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271483, name = "Serpent Crown of the Ophidian Oracle",source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271481, name = "Hissing Mantle of the Ophidian Oracle",source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 271486, name = "Fanged Raiment of the Ophidian Oracle",source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268254, name = "Serpentine Mixing Belt",           source = "Vashnik the Malignant"             }, -- Waist
            [7]= { itemID = 271482, name = "Leggings of the Ophidian Oracle",  source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 244577, name = "Farstrider's Razor Talons",        source = "Crafting"                          }, -- Feet
            [9]= { itemID = 244584, name = "Farstrider's Plated Bracers",      source = "Crafting"                          }, -- Wrist
            [10]= { itemID = 271484, name = "Hexing Grips of the Ophidian Oracle",source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 1
            [12]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 1
            [14]= { itemID = 273796, name = "Vile Vial of Volatile Venom",      source = "Altar of Fangs"                    }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 268262, name = "Bubblefin Splash Guard",           source = "Nymrissa Wavecaller"               }, -- Off Hand
        },
    },
}
