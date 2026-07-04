-- BiS data: Elemental Shaman — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/shaman/elemental/bis-gear
-- Source: https://www.wowhead.com/guide/classes/shaman/elemental/stat-priority-pve-dps
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["SHAMAN_ELEMENTAL"] = {
    label = "Elemental Shaman",
    class = "SHAMAN",
    spec  = "Elemental",

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
            [1]= { itemID = 249979, name = "Locus of the Primal Core",         source = "Tier Set"                          }, -- Head
            [2]= { itemID = 250247, name = "Amulet of the Abyssal Hymn",       source = "\r\nMidnight Falls"                }, -- Neck
            [3]= { itemID = 249977, name = "Tempests of the Primal Core",      source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 249982, name = "Embrace of the Primal Core",       source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 244611, name = "World Tender's Barkclasp",         source = "Crafted"                           }, -- Waist
            [7]= { itemID = 268288, name = "Fungarian Folly Faulds",           source = "Sporefall"                         }, -- Legs
            [8]= { itemID = 244610, name = "World Tender's Rootslippers",      source = "Crafted"                           }, -- Feet
            [9]= { itemID = 249304, name = "Fallen King's Cuffs",              source = "Fallen-King Salhadaar · The Voidspire"}, -- Wrist
            [10]= { itemID = 249980, name = "Earthgrips of the Primal Core",    source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 1
            [12]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "\r\nBelo'ren"                      }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 250144, name = "Emberwing Feather",                source = "Windrunner Spire"                  }, -- Trinket 2
            [15]= { itemID = 249974, name = "Guardian of the Primal Core",      source = "Catalyst"                          }, -- Back
            [16]= { itemID = 251083, name = "Excavating Cudgel",                source = "Windrunner Spire"                  }, -- Main Hand
            [17]= { itemID = 251105, name = "Ward of the Spellbreaker",         source = "Magisters' Terrace"                }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 249979, name = "Locus of the Primal Core",         source = "Tier Set"                          }, -- Head
            [2]= { itemID = 250247, name = "Amulet of the Abyssal Hymn",       source = "\r\nMidnight Falls"                }, -- Neck
            [3]= { itemID = 249977, name = "Tempests of the Primal Core",      source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 249982, name = "Embrace of the Primal Core",       source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 244611, name = "World Tender's Barkclasp",         source = "Crafted"                           }, -- Waist
            [7]= { itemID = 268288, name = "Fungarian Folly Faulds",           source = "Sporefall"                         }, -- Legs
            [8]= { itemID = 244610, name = "World Tender's Rootslippers",      source = "Crafted"                           }, -- Feet
            [9]= { itemID = 249304, name = "Fallen King's Cuffs",              source = "Fallen-King Salhadaar · The Voidspire"}, -- Wrist
            [10]= { itemID = 249980, name = "Earthgrips of the Primal Core",    source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 1
            [12]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "\r\nBelo'ren"                      }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 250144, name = "Emberwing Feather",                source = "Windrunner Spire"                  }, -- Trinket 2
            [15]= { itemID = 249974, name = "Guardian of the Primal Core",      source = "Catalyst"                          }, -- Back
            [16]= { itemID = 251083, name = "Excavating Cudgel",                source = "Windrunner Spire"                  }, -- Main Hand
            [17]= { itemID = 251105, name = "Ward of the Spellbreaker",         source = "Magisters' Terrace"                }, -- Off Hand
        },
    },
}
