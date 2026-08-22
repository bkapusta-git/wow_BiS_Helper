-- BiS data: Fire Mage — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/mage/fire/bis-gear
-- Source: https://www.wowhead.com/guide/classes/mage/fire/stat-priority-pve-dps
-- Last updated: 2026-08-21

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["MAGE_FIRE"] = {
    label = "Fire Mage",
    class = "MAGE",
    spec  = "Fire",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = nil  , r = 1.00, g = 0.35, b = 0.35 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = nil  , r = 1.00, g = 0.35, b = 0.35 },
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
            [1]= { itemID = 271564, name = "Crown of the Primal Leywarden",    source = "Tier Set"                          }, -- Head
            [2]= { itemID = 251142, name = "Pendant of Malefic Fury",          source = "Murder Row"                        }, -- Neck
            [3]= { itemID = 271562, name = "Primal Leywarden's Manaflux",      source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 271567, name = "Crest of the Primal Leywarden",    source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268257, name = "Caustic Chain-Wrapped Sash",       source = "Sszorak"                           }, -- Waist
            [7]= { itemID = 271563, name = "Primal Leywarden's Tailored Legwraps",source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 268255, name = "Cackling Soultreads",              source = "The Coiled Altar"                  }, -- Feet
            [9]= { itemID = 239648, name = "Martyr's Bindings",                source = "Crafting/Misc"                     }, -- Wrist
            [10]= { itemID = 271565, name = "Primal Leywarden's Manashapers",   source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268266, name = "Alluring Bubbleband",              source = "Nymrissa Wavecaller"               }, -- Ring 1
            [12]= { itemID = 159459, name = "Ritual Binder's Ring",             source = "King's Rest"                       }, -- Ring 2
            [13]= { itemID = 273796, name = "Vile Vial of Volatile Venom",      source = "Altar of Fangs"                    }, -- Trinket 1
            [14]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 245769, name = "Aln'hara Lantern",                 source = "Crafting"                          }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271564, name = "Crown of the Primal Leywarden",    source = "Tier Set"                          }, -- Head
            [2]= { itemID = 251142, name = "Pendant of Malefic Fury",          source = "Murder Row"                        }, -- Neck
            [3]= { itemID = 271562, name = "Primal Leywarden's Manaflux",      source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 271567, name = "Crest of the Primal Leywarden",    source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268257, name = "Caustic Chain-Wrapped Sash",       source = "Sszorak"                           }, -- Waist
            [7]= { itemID = 271563, name = "Primal Leywarden's Tailored Legwraps",source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 268255, name = "Cackling Soultreads",              source = "The Coiled Altar"                  }, -- Feet
            [9]= { itemID = 239648, name = "Martyr's Bindings",                source = "Crafting/Misc"                     }, -- Wrist
            [10]= { itemID = 271565, name = "Primal Leywarden's Manashapers",   source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268266, name = "Alluring Bubbleband",              source = "Nymrissa Wavecaller"               }, -- Ring 1
            [12]= { itemID = 159459, name = "Ritual Binder's Ring",             source = "King's Rest"                       }, -- Ring 2
            [13]= { itemID = 273796, name = "Vile Vial of Volatile Venom",      source = "Altar of Fangs"                    }, -- Trinket 1
            [14]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 245769, name = "Aln'hara Lantern",                 source = "Crafting"                          }, -- Off Hand
        },
    },
}
