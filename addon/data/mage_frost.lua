-- BiS data: Frost Mage — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/mage/frost/bis-gear
-- Source: https://www.wowhead.com/guide/classes/mage/frost/stat-priority-pve-dps
-- Last updated: 2026-08-21

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["MAGE_FROST"] = {
    label = "Frost Mage",
    class = "MAGE",
    spec  = "Frost",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
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
            [1]= { itemID = 271564, name = "Crown of the Primal Leywarden",    source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271562, name = "Primal Leywarden's Manaflux",      source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 271567, name = "Crest of the Primal Leywarden",    source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 239649, name = "Martyr's Waistwrap",               source = "Crafting/Misc"                     }, -- Waist
            [7]= { itemID = 271563, name = "Primal Leywarden's Tailored Legwraps",source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 268255, name = "Cackling Soultreads",              source = "The Coiled Altar"                  }, -- Feet
            [9]= { itemID = 239648, name = "Martyr's Bindings",                source = "Crafting/Misc"                     }, -- Wrist
            [10]= { itemID = 271565, name = "Primal Leywarden's Manashapers",   source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 1
            [12]= { itemID = 158366, name = "Charged Sandstone Band",           source = "Temple of Sethraliss"              }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 1
            [14]= { itemID = 270167, name = "Wavecaller's Seastone",            source = "Nymrissa Wavecaller"               }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 268263, name = "Frostscale's Mystic Frond",        source = "Nymrissa Wavecaller"               }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271564, name = "Crown of the Primal Leywarden",    source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271562, name = "Primal Leywarden's Manaflux",      source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 271567, name = "Crest of the Primal Leywarden",    source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 239649, name = "Martyr's Waistwrap",               source = "Crafting/Misc"                     }, -- Waist
            [7]= { itemID = 271563, name = "Primal Leywarden's Tailored Legwraps",source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 268255, name = "Cackling Soultreads",              source = "The Coiled Altar"                  }, -- Feet
            [9]= { itemID = 239648, name = "Martyr's Bindings",                source = "Crafting/Misc"                     }, -- Wrist
            [10]= { itemID = 271565, name = "Primal Leywarden's Manashapers",   source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 1
            [12]= { itemID = 158366, name = "Charged Sandstone Band",           source = "Temple of Sethraliss"              }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 1
            [14]= { itemID = 270167, name = "Wavecaller's Seastone",            source = "Nymrissa Wavecaller"               }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 268263, name = "Frostscale's Mystic Frond",        source = "Nymrissa Wavecaller"               }, -- Off Hand
        },
    },
}
