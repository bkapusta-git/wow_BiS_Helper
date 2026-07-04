-- BiS data: Brewmaster Monk — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/monk/brewmaster/bis-gear
-- Source: https://www.wowhead.com/guide/classes/monk/brewmaster/stat-priority-pve-tank
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["MONK_BREWMASTER"] = {
    label = "Brewmaster Monk",
    class = "MONK",
    spec  = "Brewmaster",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = "="  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = "="  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Haste", op = nil  , r = 1.00, g = 0.82, b = 0.20 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = "="  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = "="  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Haste", op = nil  , r = 1.00, g = 0.82, b = 0.20 },
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
            [1]= { itemID = 250015, name = "Fearsome Visage of Ra-den's Chosen",source = "Catalyst|Raid|Vault"               }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Rotmire"                           }, -- Neck
            [3]= { itemID = 250013, name = "Aurastones of Ra-den's Chosen",    source = "Catalyst|Raid|Vault"               }, -- Shoulder
            [5]= { itemID = 250018, name = "Battle Garb of Ra-den's Chosen",   source = "Catalyst|Raid|Vault"               }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Rotmire"                           }, -- Waist
            [7]= { itemID = 151314, name = "Shifting Stalker Hide Pants",      source = "Seat of the Triumvirate"           }, -- Legs
            [8]= { itemID = 244569, name = "Silvermoon Agent's Sneakers",      source = "Leatherworking"                    }, -- Feet
            [9]= { itemID = 250011, name = "Strikeguards of Ra-den's Chosen",  source = "Catalyst"                          }, -- Wrist
            [10]= { itemID = 250016, name = "Thunderfists of Ra-den's Chosen",  source = "Catalyst|Raid|Vault"               }, -- Hands
            [11]= { itemID = 249336, name = "Signet of the Starved Beast",      source = "Vorasius · The Voidspire"          }, -- Ring 1
            [12]= { itemID = 251513, name = "Loa Worshiper's Band",             source = "Crafted"                           }, -- Ring 2
            [13]= { itemID = 260235, name = "Umbral Plume",                     source = "Belo'ren"                          }, -- Trinket 1
            [14]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 2
            [15]= { itemID = 249335, name = "Imperator's Banner",               source = "Imperator Averzian · The Voidspire"}, -- Back
            [16]= { itemID = 249302, name = "Inescapable Reach",                source = "Vorasius · The Voidspire"          }, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 250015, name = "Fearsome Visage of Ra-den's Chosen",source = "Catalyst|Raid|Vault"               }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Rotmire"                           }, -- Neck
            [3]= { itemID = 250013, name = "Aurastones of Ra-den's Chosen",    source = "Catalyst|Raid|Vault"               }, -- Shoulder
            [5]= { itemID = 250018, name = "Battle Garb of Ra-den's Chosen",   source = "Catalyst|Raid|Vault"               }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Rotmire"                           }, -- Waist
            [7]= { itemID = 151314, name = "Shifting Stalker Hide Pants",      source = "Seat of the Triumvirate"           }, -- Legs
            [8]= { itemID = 244569, name = "Silvermoon Agent's Sneakers",      source = "Leatherworking"                    }, -- Feet
            [9]= { itemID = 250011, name = "Strikeguards of Ra-den's Chosen",  source = "Catalyst"                          }, -- Wrist
            [10]= { itemID = 250016, name = "Thunderfists of Ra-den's Chosen",  source = "Catalyst|Raid|Vault"               }, -- Hands
            [11]= { itemID = 249336, name = "Signet of the Starved Beast",      source = "Vorasius · The Voidspire"          }, -- Ring 1
            [12]= { itemID = 251513, name = "Loa Worshiper's Band",             source = "Crafted"                           }, -- Ring 2
            [13]= { itemID = 260235, name = "Umbral Plume",                     source = "Belo'ren"                          }, -- Trinket 1
            [14]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 2
            [15]= { itemID = 249335, name = "Imperator's Banner",               source = "Imperator Averzian · The Voidspire"}, -- Back
            [16]= { itemID = 249302, name = "Inescapable Reach",                source = "Vorasius · The Voidspire"          }, -- Main Hand
        },
    },
}
