-- BiS data: Restoration Druid — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/druid/restoration/bis-gear
-- Source: https://www.wowhead.com/guide/classes/druid/restoration/stat-priority-pve-healer
-- Last updated: 2026-08-12

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DRUID_RESTORATION"] = {
    label = "Restoration Druid",
    class = "DRUID",
    spec  = "Restoration",

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
            [1]= { itemID = 271528, name = "Enigmatic Dreamwatcher's Somnolent Stare",source = "Ula'tek (Raid) & Catalyst"         }, -- Head
            [2]= { itemID = 268251, name = "Amulet of the Twin Fangs",         source = "The Twin Fangs (Raid)"             }, -- Neck
            [3]= { itemID = 244572, name = "Silvermoon Agent's Mantle",        source = "Leatherworking"                    }, -- Shoulder
            [5]= { itemID = 271531, name = "Enigmatic Dreamwatcher's Lunar Raiment",source = "Nek'zali the Soulcoiler (Raid) & Catalyst"}, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar (Raid)"           }, -- Waist
            [7]= { itemID = 271527, name = "Enigmatic Dreamwatcher's Leggings",source = "The Coiled Altar (Raid) & Catalyst"}, -- Legs
            [8]= { itemID = 244569, name = "Silvermoon Agent's Sneakers",      source = "Leatherworking"                    }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Leatherworking"                    }, -- Wrist
            [10]= { itemID = 271529, name = "Enigmatic Dreamwatcher's Gauntlets",source = "Entombed Sentinels (Raid)"         }, -- Hands
            [11]= { itemID = 268266, name = "Alluring Bubbleband",              source = "Nymrissa Wavebinder (Raid)"        }, -- Ring 1
            [12]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 2
            [13]= { itemID = 270167, name = "Wavecaller's Seastone",            source = "Nymrissa Wavebinder (Raid)"        }, -- Trinket 1
            [14]= { itemID = 270162, name = "Soulcoiler Ritual Vessel",         source = "Nek'zali the Soulcoiler (Raid)"    }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar (Raid)"           }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek (Raid)"                    }, -- Main Hand
            [17]= { itemID = 268197, name = "Spine of the Hissing Abyss",       source = "Entombed Sentinels (Raid)"         }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271528, name = "Enigmatic Dreamwatcher's Somnolent Stare",source = "Ula'tek (Raid) & Catalyst"         }, -- Head
            [2]= { itemID = 268251, name = "Amulet of the Twin Fangs",         source = "The Twin Fangs (Raid)"             }, -- Neck
            [3]= { itemID = 244572, name = "Silvermoon Agent's Mantle",        source = "Leatherworking"                    }, -- Shoulder
            [5]= { itemID = 271531, name = "Enigmatic Dreamwatcher's Lunar Raiment",source = "Nek'zali the Soulcoiler (Raid) & Catalyst"}, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar (Raid)"           }, -- Waist
            [7]= { itemID = 271527, name = "Enigmatic Dreamwatcher's Leggings",source = "The Coiled Altar (Raid) & Catalyst"}, -- Legs
            [8]= { itemID = 244569, name = "Silvermoon Agent's Sneakers",      source = "Leatherworking"                    }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Leatherworking"                    }, -- Wrist
            [10]= { itemID = 271529, name = "Enigmatic Dreamwatcher's Gauntlets",source = "Entombed Sentinels (Raid)"         }, -- Hands
            [11]= { itemID = 268266, name = "Alluring Bubbleband",              source = "Nymrissa Wavebinder (Raid)"        }, -- Ring 1
            [12]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 2
            [13]= { itemID = 270167, name = "Wavecaller's Seastone",            source = "Nymrissa Wavebinder (Raid)"        }, -- Trinket 1
            [14]= { itemID = 270162, name = "Soulcoiler Ritual Vessel",         source = "Nek'zali the Soulcoiler (Raid)"    }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar (Raid)"           }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek (Raid)"                    }, -- Main Hand
            [17]= { itemID = 268197, name = "Spine of the Hissing Abyss",       source = "Entombed Sentinels (Raid)"         }, -- Off Hand
        },
    },
}
