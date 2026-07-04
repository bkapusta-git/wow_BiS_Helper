-- BiS data: Holy Priest — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/priest/holy/bis-gear
-- Source: https://www.wowhead.com/guide/classes/priest/holy/stat-priority-pve-healer
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["PRIEST_HOLY"] = {
    label = "Holy Priest",
    class = "PRIEST",
    spec  = "Holy",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery", op = "="  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Haste", op = nil  , r = 1.00, g = 0.82, b = 0.20 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery", op = "="  , r = 0.30, g = 0.75, b = 1.00 },
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
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall (Raid)"                  }, -- Neck
            [3]= { itemID = 250049, name = "Blind Oath's Seraphguards",        source = "Raid | Catalyst | Vault"           }, -- Shoulder
            [5]= { itemID = 250054, name = "Blind Oath's Raiment",             source = "Sporefall | Catalyst | Vault"      }, -- Chest
            [6]= { itemID = 239664, name = "Arcanoweave Cord",                 source = "Crafted"                           }, -- Waist
            [7]= { itemID = 250050, name = "Blind Oath's Leggings",            source = "Raid | Catalyst | Vault"           }, -- Legs
            [8]= { itemID = 268282, name = "Luxurious Loamstriders",           source = "Sporefall (Raid)"                  }, -- Feet
            [9]= { itemID = 250047, name = "Blind Oath's Wraps",               source = "Raid | Catalyst | Vault"           }, -- Wrist
            [10]= { itemID = 250052, name = "Blind Oath's Touch",               source = "Raid | Catalyst | Vault"           }, -- Hands
            [11]= { itemID = 249336, name = "Signet of the Starved Beast",      source = "Vorasius · The Voidspire"          }, -- Ring 1
            [12]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren (Raid)"                   }, -- Ring 2
            [13]= { itemID = 249809, name = "Locus-Walker's Ribbon",            source = "Crown of the Cosmos · The Voidspire"}, -- Trinket 1
            [14]= { itemID = 249808, name = "Litany of Lightblind Wrath",       source = "Lightblinded Vanguard · The Voidspire"}, -- Trinket 2
            [16]= { itemID = 249293, name = "Weight of Command",                source = "Imperator Averzian · The Voidspire"}, -- Main Hand
            [17]= { itemID = 245769, name = "Aln'hara Lantern",                 source = "Crafted"                           }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall (Raid)"                  }, -- Neck
            [3]= { itemID = 250049, name = "Blind Oath's Seraphguards",        source = "Raid | Catalyst | Vault"           }, -- Shoulder
            [5]= { itemID = 250054, name = "Blind Oath's Raiment",             source = "Sporefall | Catalyst | Vault"      }, -- Chest
            [6]= { itemID = 239664, name = "Arcanoweave Cord",                 source = "Crafted"                           }, -- Waist
            [7]= { itemID = 250050, name = "Blind Oath's Leggings",            source = "Raid | Catalyst | Vault"           }, -- Legs
            [8]= { itemID = 268282, name = "Luxurious Loamstriders",           source = "Sporefall (Raid)"                  }, -- Feet
            [9]= { itemID = 250047, name = "Blind Oath's Wraps",               source = "Raid | Catalyst | Vault"           }, -- Wrist
            [10]= { itemID = 250052, name = "Blind Oath's Touch",               source = "Raid | Catalyst | Vault"           }, -- Hands
            [11]= { itemID = 249336, name = "Signet of the Starved Beast",      source = "Vorasius · The Voidspire"          }, -- Ring 1
            [12]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren (Raid)"                   }, -- Ring 2
            [13]= { itemID = 249809, name = "Locus-Walker's Ribbon",            source = "Crown of the Cosmos · The Voidspire"}, -- Trinket 1
            [14]= { itemID = 249808, name = "Litany of Lightblind Wrath",       source = "Lightblinded Vanguard · The Voidspire"}, -- Trinket 2
            [16]= { itemID = 249293, name = "Weight of Command",                source = "Imperator Averzian · The Voidspire"}, -- Main Hand
            [17]= { itemID = 245769, name = "Aln'hara Lantern",                 source = "Crafted"                           }, -- Off Hand
        },
    },
}
