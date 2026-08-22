-- BiS data: Balance Druid — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/druid/balance/bis-gear
-- Source: https://www.wowhead.com/guide/classes/druid/balance/stat-priority-pve-dps
-- Last updated: 2026-08-12

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DRUID_BALANCE"] = {
    label = "Balance Druid",
    class = "DRUID",
    spec  = "Balance",

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
            [1]= { itemID = 271875, name = "Gaze of the Coiled Watcher",       source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 244572, name = "Silvermoon Agent's Mantle",        source = "Crafting/Misc"                     }, -- Shoulder
            [5]= { itemID = 251159, name = "War Trial Vestments",              source = "Den of Nalorakk"                   }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 268225, name = "Coiled Hex Legguards",             source = "The Coiled Altar"                  }, -- Legs
            [8]= { itemID = 251153, name = "Arctic Explorer's Legwraps",       source = "Den of Nalorakk"                   }, -- Feet
            [9]= { itemID = 268240, name = "Restless Spirit Shackles",         source = "Nek'zali the Soulcoiler"           }, -- Wrist
            [10]= { itemID = 268234, name = "Ruthless Slaughtergrips",          source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 1
            [12]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 1
            [14]= { itemID = 273796, name = "Vile Vial of Volatile Venom",      source = "Altar of Fangs"                    }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 245769, name = "Aln'hara Lantern",                 source = "Crafting/Misc"                     }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271875, name = "Gaze of the Coiled Watcher",       source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 244572, name = "Silvermoon Agent's Mantle",        source = "Crafting/Misc"                     }, -- Shoulder
            [5]= { itemID = 251159, name = "War Trial Vestments",              source = "Den of Nalorakk"                   }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 268225, name = "Coiled Hex Legguards",             source = "The Coiled Altar"                  }, -- Legs
            [8]= { itemID = 251153, name = "Arctic Explorer's Legwraps",       source = "Den of Nalorakk"                   }, -- Feet
            [9]= { itemID = 268240, name = "Restless Spirit Shackles",         source = "Nek'zali the Soulcoiler"           }, -- Wrist
            [10]= { itemID = 268234, name = "Ruthless Slaughtergrips",          source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 1
            [12]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 1
            [14]= { itemID = 273796, name = "Vile Vial of Volatile Venom",      source = "Altar of Fangs"                    }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 245769, name = "Aln'hara Lantern",                 source = "Crafting/Misc"                     }, -- Off Hand
        },
    },
}
