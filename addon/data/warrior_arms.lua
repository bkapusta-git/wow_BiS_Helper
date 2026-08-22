-- BiS data: Arms Warrior — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/warrior/arms/bis-gear
-- Source: https://www.wowhead.com/guide/classes/warrior/arms/stat-priority-pve-dps
-- Last updated: 2026-08-21

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["WARRIOR_ARMS"] = {
    label = "Arms Warrior",
    class = "WARRIOR",
    spec  = "Arms",

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
            [1]= { itemID = 271456, name = "Tempered Horns of the Jade Warlord",source = "The Twin Fangs"                    }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271454, name = "Raging Pauldrons of the Jade Warlord",source = "BoE Trash Drop"                    }, -- Shoulder
            [5]= { itemID = 271459, name = "Cuirass of the Jade Warlord",      source = "The Coiled Altar"                  }, -- Chest
            [6]= { itemID = 268259, name = "Girdle of Toxic Regret",           source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271455, name = "Greaves of the Jade Warlord",      source = "Ula'tek"                           }, -- Legs
            [8]= { itemID = 237828, name = "Spellbreaker's March",             source = "Crafted"                           }, -- Feet
            [9]= { itemID = 237834, name = "Spellbreaker's Bracers",           source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 271457, name = "Jeweled Gauntlets of the Jade Warlord",source = "Entombed Sentinels"                }, -- Hands
            [11]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 1
            [12]= { itemID = 273792, name = "Band of the Amani Warlord",        source = "Altar of Fangs"                    }, -- Ring 2
            [13]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 1
            [14]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268213, name = "Maze-roa, Warlord's Fury",         source = "The Coiled Altar"                  }, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271456, name = "Tempered Horns of the Jade Warlord",source = "The Twin Fangs"                    }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271454, name = "Raging Pauldrons of the Jade Warlord",source = "BoE Trash Drop"                    }, -- Shoulder
            [5]= { itemID = 271459, name = "Cuirass of the Jade Warlord",      source = "The Coiled Altar"                  }, -- Chest
            [6]= { itemID = 268259, name = "Girdle of Toxic Regret",           source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271455, name = "Greaves of the Jade Warlord",      source = "Ula'tek"                           }, -- Legs
            [8]= { itemID = 237828, name = "Spellbreaker's March",             source = "Crafted"                           }, -- Feet
            [9]= { itemID = 237834, name = "Spellbreaker's Bracers",           source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 271457, name = "Jeweled Gauntlets of the Jade Warlord",source = "Entombed Sentinels"                }, -- Hands
            [11]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 1
            [12]= { itemID = 273792, name = "Band of the Amani Warlord",        source = "Altar of Fangs"                    }, -- Ring 2
            [13]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 1
            [14]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268213, name = "Maze-roa, Warlord's Fury",         source = "The Coiled Altar"                  }, -- Main Hand
        },
    },
}
