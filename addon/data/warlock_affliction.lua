-- BiS data: Affliction Warlock — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/warlock/affliction/bis-gear
-- Source: https://www.wowhead.com/guide/classes/warlock/affliction/stat-priority-pve-dps
-- Last updated: 2026-08-21

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["WARLOCK_AFFLICTION"] = {
    label = "Affliction Warlock",
    class = "WARLOCK",
    spec  = "Affliction",

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
            [1]= { itemID = 271874, name = "Venomkeeper's Horrific Cowl",      source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271544, name = "Spires of the Damned Necrolyte",   source = "The Lost Explorers"                }, -- Shoulder
            [5]= { itemID = 271549, name = "Damned Necrolyte's Rattling Robes",source = "Vashnik the Malignant"             }, -- Chest
            [6]= { itemID = 239649, name = "Martyr's Waistwrap",               source = "Crafting"                          }, -- Waist
            [7]= { itemID = 271545, name = "Damned Necrolyte's Leg Bindings",  source = "Sszorak"                           }, -- Legs
            [8]= { itemID = 268255, name = "Cackling Soultreads",              source = "The Coiled Altar"                  }, -- Feet
            [9]= { itemID = 239648, name = "Martyr's Bindings",                source = "Crafting"                          }, -- Wrist
            [10]= { itemID = 271547, name = "Damned Necrolyte's Charred Grasps",source = "Entombed Sentinels"                }, -- Hands
            [11]= { itemID = 268252, name = "Apex Brute's Claw Ring",           source = "Sszorak"                           }, -- Ring 1
            [12]= { itemID = 273792, name = "Band of the Amani Warlord",        source = "The Coiled Altar"                  }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 1
            [14]= { itemID = 273649, name = "Stormbound Emblem of Dazar",       source = "King Dazar"                        }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 245769, name = "Aln'hara Lantern",                 source = "Crafting"                          }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271874, name = "Venomkeeper's Horrific Cowl",      source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271544, name = "Spires of the Damned Necrolyte",   source = "The Lost Explorers"                }, -- Shoulder
            [5]= { itemID = 271549, name = "Damned Necrolyte's Rattling Robes",source = "Vashnik the Malignant"             }, -- Chest
            [6]= { itemID = 239649, name = "Martyr's Waistwrap",               source = "Crafting"                          }, -- Waist
            [7]= { itemID = 271545, name = "Damned Necrolyte's Leg Bindings",  source = "Sszorak"                           }, -- Legs
            [8]= { itemID = 268255, name = "Cackling Soultreads",              source = "The Coiled Altar"                  }, -- Feet
            [9]= { itemID = 239648, name = "Martyr's Bindings",                source = "Crafting"                          }, -- Wrist
            [10]= { itemID = 271547, name = "Damned Necrolyte's Charred Grasps",source = "Entombed Sentinels"                }, -- Hands
            [11]= { itemID = 268252, name = "Apex Brute's Claw Ring",           source = "Sszorak"                           }, -- Ring 1
            [12]= { itemID = 273792, name = "Band of the Amani Warlord",        source = "The Coiled Altar"                  }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 1
            [14]= { itemID = 273649, name = "Stormbound Emblem of Dazar",       source = "King Dazar"                        }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 245769, name = "Aln'hara Lantern",                 source = "Crafting"                          }, -- Off Hand
        },
    },
}
