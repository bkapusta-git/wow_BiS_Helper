-- BiS data: Windwalker Monk — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/monk/windwalker/bis-gear
-- Source: https://www.wowhead.com/guide/classes/monk/windwalker/stat-priority-pve-dps
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["MONK_WINDWALKER"] = {
    label = "Windwalker Monk",
    class = "MONK",
    spec  = "Windwalker",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
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
            [1]= { itemID = 250015, name = "Fearsome Visage of Ra-den's Chosen",source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall"                         }, -- Neck
            [3]= { itemID = 250013, name = "Aurastones of Ra-den's Chosen",    source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250018, name = "Battle Garb of Ra-den's Chosen",   source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Sporefall"                         }, -- Waist
            [7]= { itemID = 250014, name = "Swiftsweepers of Ra-den's Chosen", source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 250017, name = "Storm Crashers of Ra-den's Chosen",source = "The Catalyst"                      }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 249321, name = "Vaelgor's Fearsome Grasp",         source = "Vaelgor & Ezzorak · The Voidspire" }, -- Hands
            [11]= { itemID = 251513, name = "Loa Worshiper's Band",             source = "Crafted"                           }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 193701, name = "Algeth'ar Puzzle Box",             source = "Algeth'ar Academy"                 }, -- Trinket 2
            [15]= { itemID = 250010, name = "Windwrap of Ra-den's Chosen",      source = "The Catalyst"                      }, -- Back
            [16]= { itemID = 251162, name = "Traitor's Talon",                  source = "Maisara Caverns"                   }, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 250015, name = "Fearsome Visage of Ra-den's Chosen",source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall"                         }, -- Neck
            [3]= { itemID = 250013, name = "Aurastones of Ra-den's Chosen",    source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250018, name = "Battle Garb of Ra-den's Chosen",   source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Sporefall"                         }, -- Waist
            [7]= { itemID = 250014, name = "Swiftsweepers of Ra-den's Chosen", source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 250017, name = "Storm Crashers of Ra-den's Chosen",source = "The Catalyst"                      }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 249321, name = "Vaelgor's Fearsome Grasp",         source = "Vaelgor & Ezzorak · The Voidspire" }, -- Hands
            [11]= { itemID = 251513, name = "Loa Worshiper's Band",             source = "Crafted"                           }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 193701, name = "Algeth'ar Puzzle Box",             source = "Algeth'ar Academy"                 }, -- Trinket 2
            [15]= { itemID = 250010, name = "Windwrap of Ra-den's Chosen",      source = "The Catalyst"                      }, -- Back
            [16]= { itemID = 251162, name = "Traitor's Talon",                  source = "Maisara Caverns"                   }, -- Main Hand
        },
    },
}
