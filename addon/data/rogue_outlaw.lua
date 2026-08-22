-- BiS data: Outlaw Rogue — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/rogue/outlaw/bis-gear
-- Source: https://www.wowhead.com/guide/classes/rogue/outlaw/stat-priority-pve-dps
-- Last updated: 2026-08-21

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["ROGUE_OUTLAW"] = {
    label = "Outlaw Rogue",
    class = "ROGUE",
    spec  = "Outlaw",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Mastery", op = nil  , r = 0.30, g = 0.75, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
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
            [3]= { itemID = 271508, name = "Chosen Bloodslayer's Voodoo Guards",source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 271513, name = "Chosen Bloodslayer's Banded Poncho",source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 244573, name = "Silvermoon Agent's Utility Belt",  source = "Crafting/Misc"                     }, -- Waist
            [7]= { itemID = 271509, name = "Chosen Bloodslayer's Reinforced Pants",source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 244569, name = "Silvermoon Agent's Sneakers",      source = "Crafting/Misc"                     }, -- Feet
            [9]= { itemID = 268240, name = "Restless Spirit Shackles",         source = "Nek'zali the Soulcoiler"           }, -- Wrist
            [10]= { itemID = 271511, name = "Chosen Bloodslayer's Fanged Grips",source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268266, name = "Alluring Bubbleband",              source = "Nymrissa Wavecaller"               }, -- Ring 1
            [12]= { itemID = 268252, name = "Apex Brute's Claw Ring",           source = "Sszorak"                           }, -- Ring 2
            [13]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 1
            [14]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 2
            [15]= { itemID = 268248, name = "Amani Summoning Shawl",            source = "Nek'zali the Soulcoiler"           }, -- Back
            [16]= { itemID = 268209, name = "Aman'muso, Warlord's Vengeance",   source = "The Coiled Altar"                  }, -- Main Hand
            [17]= { itemID = 275070, name = "Sharpened Lightwood Slasher",      source = "Altar of Fangs"                    }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271875, name = "Gaze of the Coiled Watcher",       source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271508, name = "Chosen Bloodslayer's Voodoo Guards",source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 271513, name = "Chosen Bloodslayer's Banded Poncho",source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 244573, name = "Silvermoon Agent's Utility Belt",  source = "Crafting/Misc"                     }, -- Waist
            [7]= { itemID = 271509, name = "Chosen Bloodslayer's Reinforced Pants",source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 244569, name = "Silvermoon Agent's Sneakers",      source = "Crafting/Misc"                     }, -- Feet
            [9]= { itemID = 268240, name = "Restless Spirit Shackles",         source = "Nek'zali the Soulcoiler"           }, -- Wrist
            [10]= { itemID = 271511, name = "Chosen Bloodslayer's Fanged Grips",source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268266, name = "Alluring Bubbleband",              source = "Nymrissa Wavecaller"               }, -- Ring 1
            [12]= { itemID = 268252, name = "Apex Brute's Claw Ring",           source = "Sszorak"                           }, -- Ring 2
            [13]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 1
            [14]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 2
            [15]= { itemID = 268248, name = "Amani Summoning Shawl",            source = "Nek'zali the Soulcoiler"           }, -- Back
            [16]= { itemID = 268209, name = "Aman'muso, Warlord's Vengeance",   source = "The Coiled Altar"                  }, -- Main Hand
            [17]= { itemID = 275070, name = "Sharpened Lightwood Slasher",      source = "Altar of Fangs"                    }, -- Off Hand
        },
    },
}
