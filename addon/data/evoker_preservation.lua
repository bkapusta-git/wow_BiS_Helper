-- BiS data: Preservation Evoker — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/evoker/preservation/bis-gear
-- Source: https://www.wowhead.com/guide/classes/evoker/preservation/stat-priority-pve-healer
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["EVOKER_PRESERVATION"] = {
    label = "Preservation Evoker",
    class = "EVOKER",
    spec  = "Preservation",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
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
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall (Raid)"                  }, -- Neck
            [3]= { itemID = 249995, name = "Beacons of the Black Talon",       source = "Raid | Catalyst | Vault"           }, -- Shoulder
            [5]= { itemID = 250000, name = "Frenzyward of the Black Talon",    source = "Raid | Catalyst | Vault"           }, -- Chest
            [6]= { itemID = 193722, name = "Azure Belt of Competition",        source = "Algeth'ar Academy"                 }, -- Waist
            [7]= { itemID = 249996, name = "Greaves of the Black Talon",       source = "Raid | Catalyst | Vault"           }, -- Legs
            [8]= { itemID = 268287, name = "Grudgefiend Stompers",             source = "Sporefall (Raid)"                  }, -- Feet
            [9]= { itemID = 251079, name = "Amberfrond Bracers",               source = "Windrunner Spire"                  }, -- Wrist
            [10]= { itemID = 249998, name = "Enforcer's Grips of the Black Talon",source = "Raid | Catalyst | Vault"           }, -- Hands
            [11]= { itemID = 249369, name = "Bond of Light",                    source = "Lightblinded Vanguard · The Voidspire"}, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall (Raid)"                  }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 249809, name = "Locus-Walker's Ribbon",            source = "Crown of the Cosmos · The Voidspire"}, -- Trinket 2
            [16]= { itemID = 258514, name = "Umbral Spire of Zuraal",           source = "Seat of the Triumvirate"           }, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall (Raid)"                  }, -- Neck
            [3]= { itemID = 249995, name = "Beacons of the Black Talon",       source = "Raid | Catalyst | Vault"           }, -- Shoulder
            [5]= { itemID = 250000, name = "Frenzyward of the Black Talon",    source = "Raid | Catalyst | Vault"           }, -- Chest
            [6]= { itemID = 193722, name = "Azure Belt of Competition",        source = "Algeth'ar Academy"                 }, -- Waist
            [7]= { itemID = 249996, name = "Greaves of the Black Talon",       source = "Raid | Catalyst | Vault"           }, -- Legs
            [8]= { itemID = 268287, name = "Grudgefiend Stompers",             source = "Sporefall (Raid)"                  }, -- Feet
            [9]= { itemID = 251079, name = "Amberfrond Bracers",               source = "Windrunner Spire"                  }, -- Wrist
            [10]= { itemID = 249998, name = "Enforcer's Grips of the Black Talon",source = "Raid | Catalyst | Vault"           }, -- Hands
            [11]= { itemID = 249369, name = "Bond of Light",                    source = "Lightblinded Vanguard · The Voidspire"}, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall (Raid)"                  }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 249809, name = "Locus-Walker's Ribbon",            source = "Crown of the Cosmos · The Voidspire"}, -- Trinket 2
            [16]= { itemID = 258514, name = "Umbral Spire of Zuraal",           source = "Seat of the Triumvirate"           }, -- Main Hand
        },
    },
}
