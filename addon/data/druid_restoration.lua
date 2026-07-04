-- BiS data: Restoration Druid — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/druid/restoration/bis-gear
-- Source: https://www.wowhead.com/guide/classes/druid/restoration/stat-priority-pve-healer
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DRUID_RESTORATION"] = {
    label = "Restoration Druid",
    class = "DRUID",
    spec  = "Restoration",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = nil  , r = 1.00, g = 0.35, b = 0.35 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = nil  , r = 1.00, g = 0.35, b = 0.35 },
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
            [3]= { itemID = 250022, name = "Seedpods of the Luminous Bloom",   source = "Raid | Catalyst | Vault"           }, -- Shoulder
            [5]= { itemID = 251216, name = "Maledict Vest",                    source = "Nexus-Point Xenas"                 }, -- Chest
            [6]= { itemID = 249314, name = "Twisted Twilight Sash",            source = "Fallen-King Salhadaar · The Voidspire"}, -- Waist
            [7]= { itemID = 250023, name = "Phloemwraps of the Luminous Bloom",source = "Raid | Catalyst | Vault"           }, -- Legs
            [8]= { itemID = 251210, name = "Eclipse Espadrilles",              source = "Nexus-Point Xenas"                 }, -- Feet
            [9]= { itemID = 193714, name = "Frenzyroot Cuffs",                 source = "Algeth'ar Academy"                 }, -- Wrist
            [10]= { itemID = 250025, name = "Arbortenders of the Luminous Bloom",source = "Raid | Catalyst | Vault"           }, -- Hands
            [11]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls (Raid)"             }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall (Raid)"                  }, -- Ring 2
            [13]= { itemID = 249809, name = "Locus-Walker's Ribbon",            source = "Crown of the Cosmos · The Voidspire"}, -- Trinket 1
            [14]= { itemID = 249346, name = "Vaelgor's Final Stare",            source = "Vaelgor & Ezzorak · The Voidspire" }, -- Trinket 2
            [16]= { itemID = 249283, name = "Belo'melorn, the Shattered Talon", source = "Belo'ren (Raid)"                   }, -- Main Hand
            [17]= { itemID = 249922, name = "Tome of Alnscorned Regret",        source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall (Raid)"                  }, -- Neck
            [3]= { itemID = 250022, name = "Seedpods of the Luminous Bloom",   source = "Raid | Catalyst | Vault"           }, -- Shoulder
            [5]= { itemID = 251216, name = "Maledict Vest",                    source = "Nexus-Point Xenas"                 }, -- Chest
            [6]= { itemID = 249314, name = "Twisted Twilight Sash",            source = "Fallen-King Salhadaar · The Voidspire"}, -- Waist
            [7]= { itemID = 250023, name = "Phloemwraps of the Luminous Bloom",source = "Raid | Catalyst | Vault"           }, -- Legs
            [8]= { itemID = 251210, name = "Eclipse Espadrilles",              source = "Nexus-Point Xenas"                 }, -- Feet
            [9]= { itemID = 193714, name = "Frenzyroot Cuffs",                 source = "Algeth'ar Academy"                 }, -- Wrist
            [10]= { itemID = 250025, name = "Arbortenders of the Luminous Bloom",source = "Raid | Catalyst | Vault"           }, -- Hands
            [11]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls (Raid)"             }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall (Raid)"                  }, -- Ring 2
            [13]= { itemID = 249809, name = "Locus-Walker's Ribbon",            source = "Crown of the Cosmos · The Voidspire"}, -- Trinket 1
            [14]= { itemID = 249346, name = "Vaelgor's Final Stare",            source = "Vaelgor & Ezzorak · The Voidspire" }, -- Trinket 2
            [16]= { itemID = 249283, name = "Belo'melorn, the Shattered Talon", source = "Belo'ren (Raid)"                   }, -- Main Hand
            [17]= { itemID = 249922, name = "Tome of Alnscorned Regret",        source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Off Hand
        },
    },
}
