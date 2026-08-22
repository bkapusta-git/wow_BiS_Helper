-- BiS data: Mistweaver Monk — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/monk/mistweaver/bis-gear
-- Source: https://www.wowhead.com/guide/classes/monk/mistweaver/stat-priority-pve-healer
-- Last updated: 2026-08-21

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["MONK_MISTWEAVER"] = {
    label = "Mistweaver Monk",
    class = "MONK",
    spec  = "Mistweaver",

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
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
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
            [1]= { itemID = 271519, name = "Monkey King's Unyielding Visage",  source = "Ula'tek & Catalyst"                }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271517, name = "Tassels of the Monkey King",       source = "Den of Nalorakk & Catalyst"        }, -- Shoulder
            [5]= { itemID = 271522, name = "Battle Gi of the Monkey King",     source = "Voidscar Arena & Catalyst"         }, -- Chest
            [6]= { itemID = 251189, name = "Rootwalker Harness",               source = "The Blinding Vale"                 }, -- Waist
            [7]= { itemID = 271518, name = "Pantaloons of the Monkey King",    source = "Kings' Rest & Catalyst"            }, -- Legs
            [8]= { itemID = 268247, name = "Breakwater Boots",                 source = "Nymrissa Wavebinder"               }, -- Feet
            [9]= { itemID = 251135, name = "Fury-fletched Armlets",            source = "Murder Row"                        }, -- Wrist
            [10]= { itemID = 271520, name = "Monkey King's Fighting Fists",     source = "Murder Row & Catalyst"             }, -- Hands
            [11]= { itemID = 268266, name = "Alluring Bubbleband",              source = "Nymrissa Wavebinder"               }, -- Ring 1
            [12]= { itemID = 159459, name = "Ritual Binder's Ring",             source = "Kings' Rest"                       }, -- Ring 2
            [13]= { itemID = 270167, name = "Wavecaller's Seastone",            source = "Nymrissa Wavebinder"               }, -- Trinket 1
            [14]= { itemID = 270162, name = "Soulcoiler Ritual Vessel",         source = "Nek'zali the Soulcoiler"           }, -- Trinket 2
            [15]= { itemID = 193763, name = "Fireproof Drape",                  source = "Ruby Life Pools"                   }, -- Back
            [16]= { itemID = 268211, name = "Baleful Hexblade",                 source = "The Coiled Altar"                  }, -- Main Hand
            [17]= { itemID = 159667, name = "Vessel of Last Rites",             source = "Kings' Rest"                       }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271519, name = "Monkey King's Unyielding Visage",  source = "Ula'tek & Catalyst"                }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271517, name = "Tassels of the Monkey King",       source = "Den of Nalorakk & Catalyst"        }, -- Shoulder
            [5]= { itemID = 271522, name = "Battle Gi of the Monkey King",     source = "Voidscar Arena & Catalyst"         }, -- Chest
            [6]= { itemID = 251189, name = "Rootwalker Harness",               source = "The Blinding Vale"                 }, -- Waist
            [7]= { itemID = 271518, name = "Pantaloons of the Monkey King",    source = "Kings' Rest & Catalyst"            }, -- Legs
            [8]= { itemID = 268247, name = "Breakwater Boots",                 source = "Nymrissa Wavebinder"               }, -- Feet
            [9]= { itemID = 251135, name = "Fury-fletched Armlets",            source = "Murder Row"                        }, -- Wrist
            [10]= { itemID = 271520, name = "Monkey King's Fighting Fists",     source = "Murder Row & Catalyst"             }, -- Hands
            [11]= { itemID = 268266, name = "Alluring Bubbleband",              source = "Nymrissa Wavebinder"               }, -- Ring 1
            [12]= { itemID = 159459, name = "Ritual Binder's Ring",             source = "Kings' Rest"                       }, -- Ring 2
            [13]= { itemID = 270167, name = "Wavecaller's Seastone",            source = "Nymrissa Wavebinder"               }, -- Trinket 1
            [14]= { itemID = 270162, name = "Soulcoiler Ritual Vessel",         source = "Nek'zali the Soulcoiler"           }, -- Trinket 2
            [15]= { itemID = 193763, name = "Fireproof Drape",                  source = "Ruby Life Pools"                   }, -- Back
            [16]= { itemID = 268211, name = "Baleful Hexblade",                 source = "The Coiled Altar"                  }, -- Main Hand
            [17]= { itemID = 159667, name = "Vessel of Last Rites",             source = "Kings' Rest"                       }, -- Off Hand
        },
    },
}
