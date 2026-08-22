-- BiS data: Feral Druid — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/druid/feral/bis-gear
-- Source: https://www.wowhead.com/guide/classes/druid/feral/stat-priority-pve-dps
-- Last updated: 2026-08-12

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DRUID_FERAL"] = {
    label = "Feral Druid",
    class = "DRUID",
    spec  = "Feral",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
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
            [1]= { itemID = 271528, name = "Enigmatic Dreamwatcher's Somnolent Stare",source = "Catalyst"                          }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271526, name = "Enigmatic Dreamwatcher's Plumage", source = "Catalyst"                          }, -- Shoulder
            [5]= { itemID = 271531, name = "Enigmatic Dreamwatcher's Lunar Raiment",source = "Vashnik the Malignant"             }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271527, name = "Enigmatic Dreamwatcher's Leggings",source = "Catalyst"                          }, -- Legs
            [8]= { itemID = 268261, name = "Bespittled Slitherslippers",       source = "The Twin Fangs"                    }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafting/Misc"                     }, -- Wrist
            [10]= { itemID = 244575, name = "Silvermoon Agent's Handwraps",     source = "Crafting/Misc"                     }, -- Hands
            [11]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 1
            [12]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 2
            [13]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 1
            [14]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268215, name = "Abyssal Broodfiend's Bardiche",    source = "Ula'tek"                           }, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271528, name = "Enigmatic Dreamwatcher's Somnolent Stare",source = "Catalyst"                          }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271526, name = "Enigmatic Dreamwatcher's Plumage", source = "Catalyst"                          }, -- Shoulder
            [5]= { itemID = 271531, name = "Enigmatic Dreamwatcher's Lunar Raiment",source = "Vashnik the Malignant"             }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271527, name = "Enigmatic Dreamwatcher's Leggings",source = "Catalyst"                          }, -- Legs
            [8]= { itemID = 268261, name = "Bespittled Slitherslippers",       source = "The Twin Fangs"                    }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafting/Misc"                     }, -- Wrist
            [10]= { itemID = 244575, name = "Silvermoon Agent's Handwraps",     source = "Crafting/Misc"                     }, -- Hands
            [11]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 1
            [12]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 2
            [13]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 1
            [14]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268215, name = "Abyssal Broodfiend's Bardiche",    source = "Ula'tek"                           }, -- Main Hand
        },
    },
}
