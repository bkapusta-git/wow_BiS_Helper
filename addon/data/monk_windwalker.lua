-- BiS data: Windwalker Monk — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/monk/windwalker/bis-gear
-- Source: https://www.wowhead.com/guide/classes/monk/windwalker/stat-priority-pve-dps
-- Last updated: 2026-08-21

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["MONK_WINDWALKER"] = {
    label = "Windwalker Monk",
    class = "MONK",
    spec  = "Windwalker",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
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
            [1]= { itemID = 271875, name = "Gaze of the Coiled Watcher",       source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271517, name = "Tassels of the Monkey King",       source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 268235, name = "Vestment of the Awakening",        source = "Nek'zali the Soulcoiler"           }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 268225, name = "Coiled Hex Legguards",             source = "The Coiled Altar"                  }, -- Legs
            [8]= { itemID = 244569, name = "Silvermoon Agent's Sneakers",      source = "Crafting"                          }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafting"                          }, -- Wrist
            [10]= { itemID = 251124, name = "Gauntlets of Fevered Defense",     source = "Murder Row"                        }, -- Hands
            [11]= { itemID = 158366, name = "Charged Sandstone Band",           source = "Temple of Sethraliss"              }, -- Ring 1
            [12]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 2
            [13]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 1
            [14]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268215, name = "Abyssal Broodfiend's Bardiche",    source = "Ula'tek"                           }, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271875, name = "Gaze of the Coiled Watcher",       source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271517, name = "Tassels of the Monkey King",       source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 268235, name = "Vestment of the Awakening",        source = "Nek'zali the Soulcoiler"           }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 268225, name = "Coiled Hex Legguards",             source = "The Coiled Altar"                  }, -- Legs
            [8]= { itemID = 244569, name = "Silvermoon Agent's Sneakers",      source = "Crafting"                          }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafting"                          }, -- Wrist
            [10]= { itemID = 251124, name = "Gauntlets of Fevered Defense",     source = "Murder Row"                        }, -- Hands
            [11]= { itemID = 158366, name = "Charged Sandstone Band",           source = "Temple of Sethraliss"              }, -- Ring 1
            [12]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 2
            [13]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 1
            [14]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268215, name = "Abyssal Broodfiend's Bardiche",    source = "Ula'tek"                           }, -- Main Hand
        },
    },
}
