-- BiS data: Devastation Evoker — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/evoker/devastation/bis-gear
-- Source: https://www.wowhead.com/guide/classes/evoker/devastation/stat-priority-pve-dps
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["EVOKER_DEVASTATION"] = {
    label = "Devastation Evoker",
    class = "EVOKER",
    spec  = "Devastation",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
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
            [1]= { itemID = 249997, name = "Hornhelm of the Black Talon",      source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall"                         }, -- Neck
            [3]= { itemID = 249995, name = "Beacons of the Black Talon",       source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250000, name = "Frenzyward of the Black Talon",    source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 49810, name = "Scabrous Zombie Leather Belt",      source = "Pit of Saron"                      }, -- Waist
            [7]= { itemID = 249996, name = "Greaves of the Black Talon",       source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 268287, name = "Grudgefiend Stompers",             source = "Sporefall"                         }, -- Feet
            [9]= { itemID = 244584, name = "Farstrider's Plated Bracers",      source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 249325, name = "Untethered Berserker's Grips",     source = "Crown of the Cosmos · The Voidspire"}, -- Hands
            [11]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren"                          }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 2
            [13]= { itemID = 249346, name = "Vaelgor's Final Stare",            source = "Vaelgor & Ezzorak · The Voidspire" }, -- Trinket 1
            [14]= { itemID = 249809, name = "Locus-Walker's Ribbon",            source = "Crown of the Cosmos · The Voidspire"}, -- Trinket 2
            [15]= { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Crafted"                           }, -- Back
            [16]= { itemID = 249283, name = "Belo'melorn, the Shattered Talon", source = "Belo'ren"                          }, -- Main Hand
            [17]= { itemID = 249276, name = "Grimoire of the Eternal Light",    source = "Vorasius · The Voidspire"          }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 249997, name = "Hornhelm of the Black Talon",      source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall"                         }, -- Neck
            [3]= { itemID = 249995, name = "Beacons of the Black Talon",       source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250000, name = "Frenzyward of the Black Talon",    source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 49810, name = "Scabrous Zombie Leather Belt",      source = "Pit of Saron"                      }, -- Waist
            [7]= { itemID = 249996, name = "Greaves of the Black Talon",       source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 268287, name = "Grudgefiend Stompers",             source = "Sporefall"                         }, -- Feet
            [9]= { itemID = 244584, name = "Farstrider's Plated Bracers",      source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 249325, name = "Untethered Berserker's Grips",     source = "Crown of the Cosmos · The Voidspire"}, -- Hands
            [11]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren"                          }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 2
            [13]= { itemID = 249346, name = "Vaelgor's Final Stare",            source = "Vaelgor & Ezzorak · The Voidspire" }, -- Trinket 1
            [14]= { itemID = 249809, name = "Locus-Walker's Ribbon",            source = "Crown of the Cosmos · The Voidspire"}, -- Trinket 2
            [15]= { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Crafted"                           }, -- Back
            [16]= { itemID = 249283, name = "Belo'melorn, the Shattered Talon", source = "Belo'ren"                          }, -- Main Hand
            [17]= { itemID = 249276, name = "Grimoire of the Eternal Light",    source = "Vorasius · The Voidspire"          }, -- Off Hand
        },
    },
}
