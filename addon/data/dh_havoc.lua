-- BiS data: Havoc Demon Hunter — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/demon-hunter/havoc/bis-gear
-- Source: https://www.wowhead.com/guide/classes/demon-hunter/havoc/stat-priority-pve-dps
-- Last updated: 2026-08-12

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DEMONHUNTER_HAVOC"] = {
    label = "Havoc Demon Hunter",
    class = "DEMONHUNTER",
    spec  = "Havoc",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
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
            [1]= { itemID = 271875, name = "Gaze of the Coiled Watcher",       source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271535, name = "Abyssal Doomhound's Jaws",         source = "Vashnik the Malignant"             }, -- Shoulder
            [5]= { itemID = 271540, name = "Abyssal Doomhound's Coreguard",    source = "King's Rest"                       }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271536, name = "Abyssal Doomhound's Legwraps",     source = "The Coiled Altar"                  }, -- Legs
            [8]= { itemID = 159327, name = "Sand-Shined Snakeskin Sandals",    source = "Temple of Sethraliss"              }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafting/Misc"                     }, -- Wrist
            [10]= { itemID = 271538, name = "Abyssal Doomhound's Studded Gauntlets",source = "Entombed Sentinels"                }, -- Hands
            [11]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 1
            [12]= { itemID = 158366, name = "Charged Sandstone Band",           source = "Temple of Sethraliss"              }, -- Ring 2
            [13]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 1
            [14]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268209, name = "Aman'muso, Warlord's Vengeance",   source = "The Coiled Altar"                  }, -- Main Hand
            [17]= { itemID = 237840, name = "Spellbreaker's Warglaive",         source = "Crafting/Misc"                     }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271875, name = "Gaze of the Coiled Watcher",       source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271535, name = "Abyssal Doomhound's Jaws",         source = "Vashnik the Malignant"             }, -- Shoulder
            [5]= { itemID = 271540, name = "Abyssal Doomhound's Coreguard",    source = "King's Rest"                       }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271536, name = "Abyssal Doomhound's Legwraps",     source = "The Coiled Altar"                  }, -- Legs
            [8]= { itemID = 159327, name = "Sand-Shined Snakeskin Sandals",    source = "Temple of Sethraliss"              }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafting/Misc"                     }, -- Wrist
            [10]= { itemID = 271538, name = "Abyssal Doomhound's Studded Gauntlets",source = "Entombed Sentinels"                }, -- Hands
            [11]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 1
            [12]= { itemID = 158366, name = "Charged Sandstone Band",           source = "Temple of Sethraliss"              }, -- Ring 2
            [13]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 1
            [14]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268209, name = "Aman'muso, Warlord's Vengeance",   source = "The Coiled Altar"                  }, -- Main Hand
            [17]= { itemID = 237840, name = "Spellbreaker's Warglaive",         source = "Crafting/Misc"                     }, -- Off Hand
        },
    },
}
