-- BiS data: Discipline Priest — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/priest/discipline/bis-gear
-- Source: https://www.wowhead.com/guide/classes/priest/discipline/stat-priority-pve-healer
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["PRIEST_DISCIPLINE"] = {
    label = "Discipline Priest",
    class = "PRIEST",
    spec  = "Discipline",

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
            [2]= { itemID = 249368, name = "Eternal Voidsong Chain",           source = "Crown of the Cosmos · The Voidspire"}, -- Neck
            [3]= { itemID = 250049, name = "Blind Oath's Seraphguards",        source = "Raid | Catalyst | Vault"           }, -- Shoulder
            [5]= { itemID = 268284, name = "Mycomancer's Rot Robes",           source = "Sporefall"                         }, -- Chest
            [6]= { itemID = 239664, name = "Arcanoweave Cord",                 source = "Crafted"                           }, -- Waist
            [7]= { itemID = 250050, name = "Blind Oath's Leggings",            source = "Raid | Catalyst | Vault"           }, -- Legs
            [8]= { itemID = 268282, name = "Luxurious Loamstriders",           source = "Sporefall (Raid)"                  }, -- Feet
            [9]= { itemID = 249315, name = "Voracious Wristwraps",             source = "Vorasius · The Voidspire"          }, -- Wrist
            [10]= { itemID = 250052, name = "Blind Oath's Touch",               source = "Raid | Catalyst | Vault"           }, -- Hands
            [11]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls (Raid)"             }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall (Raid)"                  }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 249346, name = "Vaelgor's Final Stare",            source = "Vaelgor & Ezzorak · The Voidspire" }, -- Trinket 2
            [16]= { itemID = 249283, name = "Belo'melorn, the Shattered Talon", source = "Belo'ren (Raid)"                   }, -- Main Hand
            [17]= { itemID = 245769, name = "Aln'hara Lantern",                 source = "Crafted"                           }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [2]= { itemID = 249368, name = "Eternal Voidsong Chain",           source = "Crown of the Cosmos · The Voidspire"}, -- Neck
            [3]= { itemID = 250049, name = "Blind Oath's Seraphguards",        source = "Raid | Catalyst | Vault"           }, -- Shoulder
            [5]= { itemID = 268284, name = "Mycomancer's Rot Robes",           source = "Sporefall"                         }, -- Chest
            [6]= { itemID = 239664, name = "Arcanoweave Cord",                 source = "Crafted"                           }, -- Waist
            [7]= { itemID = 250050, name = "Blind Oath's Leggings",            source = "Raid | Catalyst | Vault"           }, -- Legs
            [8]= { itemID = 268282, name = "Luxurious Loamstriders",           source = "Sporefall (Raid)"                  }, -- Feet
            [9]= { itemID = 249315, name = "Voracious Wristwraps",             source = "Vorasius · The Voidspire"          }, -- Wrist
            [10]= { itemID = 250052, name = "Blind Oath's Touch",               source = "Raid | Catalyst | Vault"           }, -- Hands
            [11]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls (Raid)"             }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall (Raid)"                  }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 249346, name = "Vaelgor's Final Stare",            source = "Vaelgor & Ezzorak · The Voidspire" }, -- Trinket 2
            [16]= { itemID = 249283, name = "Belo'melorn, the Shattered Talon", source = "Belo'ren (Raid)"                   }, -- Main Hand
            [17]= { itemID = 245769, name = "Aln'hara Lantern",                 source = "Crafted"                           }, -- Off Hand
        },
    },
}
