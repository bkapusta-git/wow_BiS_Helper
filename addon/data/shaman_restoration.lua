-- BiS data: Restoration Shaman — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/shaman/restoration/bis-gear
-- Source: https://www.wowhead.com/guide/classes/shaman/restoration/stat-priority-pve-healer
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["SHAMAN_RESTORATION"] = {
    label = "Restoration Shaman",
    class = "SHAMAN",
    spec  = "Restoration",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste", op = "="  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = "="  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste", op = "="  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = "="  , r = 0.30, g = 0.75, b = 1.00 },
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
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Rotmire (Raid)"                    }, -- Neck
            [3]= { itemID = 249977, name = "Tempests of the Primal Core",      source = "Raid | Catalyst | Vault"           }, -- Shoulder
            [5]= { itemID = 249982, name = "Embrace of the Primal Core",       source = "Raid | Catalyst | Vault"           }, -- Chest
            [6]= { itemID = 249303, name = "Waistcord of the Judged",          source = "Lightblinded Vanguard · The Voidspire"}, -- Waist
            [7]= { itemID = 249978, name = "Leggings of the Primal Core",      source = "Catalyst (from )"                  }, -- Legs
            [8]= { itemID = 268287, name = "Grudgefiend Stompers",             source = "Rotmire (Raid)"                    }, -- Feet
            [9]= { itemID = 249975, name = "Cuffs of the Primal Core",         source = "Catalyst"                          }, -- Wrist
            [10]= { itemID = 249980, name = "Earthgrips of the Primal Core",    source = "Raid | Catalyst | Vault"           }, -- Hands
            [11]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren (Raid)"                   }, -- Ring 1
            [12]= { itemID = 193708, name = "Platinum Star Band",               source = "Algeth'ar Academy"                 }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 249809, name = "Locus-Walker's Ribbon",            source = "Crown of the Cosmos · The Voidspire"}, -- Trinket 2
            [16]= { itemID = 249293, name = "Weight of Command",                source = "Imperator Averzian · The Voidspire"}, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Rotmire (Raid)"                    }, -- Neck
            [3]= { itemID = 249977, name = "Tempests of the Primal Core",      source = "Raid | Catalyst | Vault"           }, -- Shoulder
            [5]= { itemID = 249982, name = "Embrace of the Primal Core",       source = "Raid | Catalyst | Vault"           }, -- Chest
            [6]= { itemID = 249303, name = "Waistcord of the Judged",          source = "Lightblinded Vanguard · The Voidspire"}, -- Waist
            [7]= { itemID = 249978, name = "Leggings of the Primal Core",      source = "Catalyst (from )"                  }, -- Legs
            [8]= { itemID = 268287, name = "Grudgefiend Stompers",             source = "Rotmire (Raid)"                    }, -- Feet
            [9]= { itemID = 249975, name = "Cuffs of the Primal Core",         source = "Catalyst"                          }, -- Wrist
            [10]= { itemID = 249980, name = "Earthgrips of the Primal Core",    source = "Raid | Catalyst | Vault"           }, -- Hands
            [11]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren (Raid)"                   }, -- Ring 1
            [12]= { itemID = 193708, name = "Platinum Star Band",               source = "Algeth'ar Academy"                 }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 249809, name = "Locus-Walker's Ribbon",            source = "Crown of the Cosmos · The Voidspire"}, -- Trinket 2
            [16]= { itemID = 249293, name = "Weight of Command",                source = "Imperator Averzian · The Voidspire"}, -- Main Hand
        },
    },
}
