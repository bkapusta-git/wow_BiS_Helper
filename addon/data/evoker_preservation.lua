-- BiS data: Preservation Evoker — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/evoker/preservation/bis-gear
-- Source: https://www.wowhead.com/guide/classes/evoker/preservation/stat-priority-pve-healer
-- Last updated: 2026-08-12

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["EVOKER_PRESERVATION"] = {
    label = "Preservation Evoker",
    class = "EVOKER",
    spec  = "Preservation",

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
            [1]= { itemID = 271501, name = "Calamitous Echo's Magmashapers",   source = "Temple of Sethraliss & Catalyst"   }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271499, name = "Calamitous Echo's Sundered Peaks", source = "The Coiled Altar & Catalyst"       }, -- Shoulder
            [5]= { itemID = 271504, name = "Searing Caldera of Calamity",      source = "Ula'tek & Catalyst"                }, -- Chest
            [6]= { itemID = 268254, name = "Serpentine Mixing Belt",           source = "Vashnik the Malignant"             }, -- Waist
            [7]= { itemID = 271500, name = "Earthen Pillars of Calamity",      source = "The Coiled Altar & Catalyst"       }, -- Legs
            [8]= { itemID = 159388, name = "Sabatons of Coruscating Energy",   source = "Temple of Sethraliss"              }, -- Feet
            [9]= { itemID = 268217, name = "Rising Tide Wristguards",          source = "Nymrissa Wavebinder"               }, -- Wrist
            [10]= { itemID = 271502, name = "Calamitous Echo's Ebon Greathorns",source = "King's Rest & Catalyst"            }, -- Hands
            [11]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 1
            [12]= { itemID = 158366, name = "Charged Sandstone Band",           source = "Temple of Sethraliss"              }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 1
            [14]= { itemID = 270162, name = "Soulcoiler Ritual Vessel",         source = "Nek'zali the Soulcoiler"           }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 268197, name = "Spine of the Hissing Abyss",       source = "Entombed Sentinels"                }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271501, name = "Calamitous Echo's Magmashapers",   source = "Temple of Sethraliss & Catalyst"   }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271499, name = "Calamitous Echo's Sundered Peaks", source = "The Coiled Altar & Catalyst"       }, -- Shoulder
            [5]= { itemID = 271504, name = "Searing Caldera of Calamity",      source = "Ula'tek & Catalyst"                }, -- Chest
            [6]= { itemID = 268254, name = "Serpentine Mixing Belt",           source = "Vashnik the Malignant"             }, -- Waist
            [7]= { itemID = 271500, name = "Earthen Pillars of Calamity",      source = "The Coiled Altar & Catalyst"       }, -- Legs
            [8]= { itemID = 159388, name = "Sabatons of Coruscating Energy",   source = "Temple of Sethraliss"              }, -- Feet
            [9]= { itemID = 268217, name = "Rising Tide Wristguards",          source = "Nymrissa Wavebinder"               }, -- Wrist
            [10]= { itemID = 271502, name = "Calamitous Echo's Ebon Greathorns",source = "King's Rest & Catalyst"            }, -- Hands
            [11]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 1
            [12]= { itemID = 158366, name = "Charged Sandstone Band",           source = "Temple of Sethraliss"              }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 1
            [14]= { itemID = 270162, name = "Soulcoiler Ritual Vessel",         source = "Nek'zali the Soulcoiler"           }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 268197, name = "Spine of the Hissing Abyss",       source = "Entombed Sentinels"                }, -- Off Hand
        },
    },
}
