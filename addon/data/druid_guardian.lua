-- BiS data: Guardian Druid — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/druid/guardian/bis-gear
-- Source: https://www.wowhead.com/guide/classes/druid/guardian/stat-priority-pve-tank
-- Last updated: 2026-08-12

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DRUID_GUARDIAN"] = {
    label = "Guardian Druid",
    class = "DRUID",
    spec  = "Guardian",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery", op = nil  , r = 0.30, g = 0.75, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery", op = nil  , r = 0.30, g = 0.75, b = 1.00 },
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
            [3]= { itemID = 271526, name = "Enigmatic Dreamwatcher's Plumage", source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 271531, name = "Enigmatic Dreamwatcher's Lunar Raiment",source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271527, name = "Enigmatic Dreamwatcher's Leggings",source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 268261, name = "Bespittled Slitherslippers",       source = "The Twin Fangs"                    }, -- Feet
            [9]= { itemID = 268240, name = "Restless Spirit Shackles",         source = "Nek'zali the Soulcoiler"           }, -- Wrist
            [10]= { itemID = 271529, name = "Enigmatic Dreamwatcher's Gauntlets",source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268252, name = "Apex Brute's Claw Ring",           source = "Sszorak"                           }, -- Ring 1
            [12]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 1
            [14]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268215, name = "Abyssal Broodfiend's Bardiche",    source = "Ula'tek"                           }, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271875, name = "Gaze of the Coiled Watcher",       source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271526, name = "Enigmatic Dreamwatcher's Plumage", source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 271531, name = "Enigmatic Dreamwatcher's Lunar Raiment",source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271527, name = "Enigmatic Dreamwatcher's Leggings",source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 268261, name = "Bespittled Slitherslippers",       source = "The Twin Fangs"                    }, -- Feet
            [9]= { itemID = 268240, name = "Restless Spirit Shackles",         source = "Nek'zali the Soulcoiler"           }, -- Wrist
            [10]= { itemID = 271529, name = "Enigmatic Dreamwatcher's Gauntlets",source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268252, name = "Apex Brute's Claw Ring",           source = "Sszorak"                           }, -- Ring 1
            [12]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 1
            [14]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268215, name = "Abyssal Broodfiend's Bardiche",    source = "Ula'tek"                           }, -- Main Hand
        },
    },
}
