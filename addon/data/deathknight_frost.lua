-- BiS data: Frost Death Knight — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/death-knight/frost/bis-gear
-- Source: https://www.wowhead.com/guide/classes/death-knight/frost/stat-priority-pve-dps
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DEATHKNIGHT_FROST"] = {
    label = "Frost Death Knight",
    class = "DEATHKNIGHT",
    spec  = "Frost",

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
            [1]= { itemID = 249970, name = "Relentless Rider's Crown",         source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall"                         }, -- Neck
            [3]= { itemID = 50234, name = "Shoulderplates of Frozen Blood",    source = "Pit of Saron"                      }, -- Shoulder
            [5]= { itemID = 249973, name = "Relentless Rider's Cuirass",       source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 249967, name = "Relentless Rider's Chain",         source = "Sporefall (Catalyst)"              }, -- Waist
            [7]= { itemID = 249969, name = "Relentless Rider's Legguards",     source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 249381, name = "Greaves of the Unformed",          source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Feet
            [9]= { itemID = 237834, name = "Spellbreaker's Bracers",           source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 249971, name = "Relentless Rider's Bonegrasps",    source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 1
            [12]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren"                          }, -- Ring 2
            [13]= { itemID = 249344, name = "Light Company Guidon",             source = "Imperator Averzian · The Voidspire"}, -- Trinket 1
            [14]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 2
            [15]= { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Crafted"                           }, -- Back
            [16]= { itemID = 249277, name = "Bellamy's Final Judgement",        source = "Lightblinded Vanguard · The Voidspire"}, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 249970, name = "Relentless Rider's Crown",         source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall"                         }, -- Neck
            [3]= { itemID = 50234, name = "Shoulderplates of Frozen Blood",    source = "Pit of Saron"                      }, -- Shoulder
            [5]= { itemID = 249973, name = "Relentless Rider's Cuirass",       source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 249967, name = "Relentless Rider's Chain",         source = "Sporefall (Catalyst)"              }, -- Waist
            [7]= { itemID = 249969, name = "Relentless Rider's Legguards",     source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 249381, name = "Greaves of the Unformed",          source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Feet
            [9]= { itemID = 237834, name = "Spellbreaker's Bracers",           source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 249971, name = "Relentless Rider's Bonegrasps",    source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 1
            [12]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren"                          }, -- Ring 2
            [13]= { itemID = 249344, name = "Light Company Guidon",             source = "Imperator Averzian · The Voidspire"}, -- Trinket 1
            [14]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 2
            [15]= { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Crafted"                           }, -- Back
            [16]= { itemID = 249277, name = "Bellamy's Final Judgement",        source = "Lightblinded Vanguard · The Voidspire"}, -- Main Hand
        },
    },
}
