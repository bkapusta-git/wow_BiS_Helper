-- BiS data: Survival Hunter — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/hunter/survival/bis-gear
-- Source: https://www.wowhead.com/guide/classes/hunter/survival/stat-priority-pve-dps
-- Last updated: 2026-08-12

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["HUNTER_SURVIVAL"] = {
    label = "Survival Hunter",
    class = "HUNTER",
    spec  = "Survival",

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
            [1]= { itemID = 271492, name = "Skulking Viper's Weeping Fangs",   source = "Tier Set / Voidscar Arena"         }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271490, name = "Jaws of the Skulking Viper",       source = "Tier Set / The Coiled Altar"       }, -- Shoulder
            [5]= { itemID = 271876, name = "Awoken Dreadfang Cuirass",         source = "Ula'tek"                           }, -- Chest
            [6]= { itemID = 244581, name = "Farstrider's Trophy Belt",         source = "Crafting"                          }, -- Waist
            [7]= { itemID = 271491, name = "Skulking Viper's Coiled Legwraps", source = "Tier Set / The Coiled Altar"       }, -- Legs
            [8]= { itemID = 268233, name = "Ferocious Scaleboots",             source = "Sszorak"                           }, -- Feet
            [9]= { itemID = 244584, name = "Farstrider's Plated Bracers",      source = "Crafting"                          }, -- Wrist
            [10]= { itemID = 271493, name = "Skulking Viper's Hidepiercers",    source = "Tier Set / King's Rest"            }, -- Hands
            [11]= { itemID = 273792, name = "Band of the Amani Warlord",        source = "The Coiled Altar"                  }, -- Ring 1
            [12]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 2
            [13]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 1
            [14]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268215, name = "Abyssal Broodfiend's Bardiche",    source = "Ula'tek"                           }, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271492, name = "Skulking Viper's Weeping Fangs",   source = "Tier Set / Voidscar Arena"         }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271490, name = "Jaws of the Skulking Viper",       source = "Tier Set / The Coiled Altar"       }, -- Shoulder
            [5]= { itemID = 271876, name = "Awoken Dreadfang Cuirass",         source = "Ula'tek"                           }, -- Chest
            [6]= { itemID = 244581, name = "Farstrider's Trophy Belt",         source = "Crafting"                          }, -- Waist
            [7]= { itemID = 271491, name = "Skulking Viper's Coiled Legwraps", source = "Tier Set / The Coiled Altar"       }, -- Legs
            [8]= { itemID = 268233, name = "Ferocious Scaleboots",             source = "Sszorak"                           }, -- Feet
            [9]= { itemID = 244584, name = "Farstrider's Plated Bracers",      source = "Crafting"                          }, -- Wrist
            [10]= { itemID = 271493, name = "Skulking Viper's Hidepiercers",    source = "Tier Set / King's Rest"            }, -- Hands
            [11]= { itemID = 273792, name = "Band of the Amani Warlord",        source = "The Coiled Altar"                  }, -- Ring 1
            [12]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 2
            [13]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 1
            [14]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268215, name = "Abyssal Broodfiend's Bardiche",    source = "Ula'tek"                           }, -- Main Hand
        },
    },
}
