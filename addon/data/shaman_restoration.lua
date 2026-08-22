-- BiS data: Restoration Shaman — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/shaman/restoration/bis-gear
-- Source: https://www.wowhead.com/guide/classes/shaman/restoration/stat-priority-pve-healer
-- Last updated: 2026-08-21

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
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Mastery", op = nil  , r = 0.30, g = 0.75, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Mastery", op = nil  , r = 0.30, g = 0.75, b = 1.00 },
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
            [1]= { itemID = 271483, name = "Serpent Crown of the Ophidian Oracle",source = "Raid  /  Vault"                    }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek (Raid)"                    }, -- Neck
            [3]= { itemID = 271481, name = "Hissing Mantle of the Ophidian Oracle",source = "The Coiled Altar (Raid) & Catalyst"}, -- Shoulder
            [5]= { itemID = 271486, name = "Fanged Raiment of the Ophidian Oracle",source = "Ula'tek (Raid) & Catalyst"         }, -- Chest
            [6]= { itemID = 268216, name = "Cursed Reliquary Cincture",        source = "Nek'zali the Soulcoiler (Raid)"    }, -- Waist
            [7]= { itemID = 271482, name = "Leggings of the Ophidian Oracle",  source = "The Coiled Altar (Raid) & Catalyst"}, -- Legs
            [8]= { itemID = 251125, name = "Felsoaked Soles",                  source = "Murder Row"                        }, -- Feet
            [9]= { itemID = 251200, name = "Saptorbane Guards",                source = "The Blinding Vale"                 }, -- Wrist
            [10]= { itemID = 271484, name = "Hexing Grips of the Ophidian Oracle",source = "Nymrissa Wavebinder (Raid) & Catalyst"}, -- Hands
            [11]= { itemID = 268252, name = "Apex Brute's Claw Ring",           source = "Sszorak (Raid)"                    }, -- Ring 1
            [12]= { itemID = 159459, name = "Ritual Binder's Ring",             source = "Kings Rest"                        }, -- Ring 2
            [13]= { itemID = 270162, name = "Soulcoiler Ritual Vessel",         source = "Nek'zali the Soulcoiler (Raid)"    }, -- Trinket 1
            [14]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers (Raid)"         }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar (Raid)"           }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek (Raid)"                    }, -- Main Hand
            [17]= { itemID = 268196, name = "Venom-Slashed Scuteward",          source = "The Lost Explorers (Raid)"         }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271483, name = "Serpent Crown of the Ophidian Oracle",source = "Raid  /  Vault"                    }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek (Raid)"                    }, -- Neck
            [3]= { itemID = 271481, name = "Hissing Mantle of the Ophidian Oracle",source = "The Coiled Altar (Raid) & Catalyst"}, -- Shoulder
            [5]= { itemID = 271486, name = "Fanged Raiment of the Ophidian Oracle",source = "Ula'tek (Raid) & Catalyst"         }, -- Chest
            [6]= { itemID = 268216, name = "Cursed Reliquary Cincture",        source = "Nek'zali the Soulcoiler (Raid)"    }, -- Waist
            [7]= { itemID = 271482, name = "Leggings of the Ophidian Oracle",  source = "The Coiled Altar (Raid) & Catalyst"}, -- Legs
            [8]= { itemID = 251125, name = "Felsoaked Soles",                  source = "Murder Row"                        }, -- Feet
            [9]= { itemID = 251200, name = "Saptorbane Guards",                source = "The Blinding Vale"                 }, -- Wrist
            [10]= { itemID = 271484, name = "Hexing Grips of the Ophidian Oracle",source = "Nymrissa Wavebinder (Raid) & Catalyst"}, -- Hands
            [11]= { itemID = 268252, name = "Apex Brute's Claw Ring",           source = "Sszorak (Raid)"                    }, -- Ring 1
            [12]= { itemID = 159459, name = "Ritual Binder's Ring",             source = "Kings Rest"                        }, -- Ring 2
            [13]= { itemID = 270162, name = "Soulcoiler Ritual Vessel",         source = "Nek'zali the Soulcoiler (Raid)"    }, -- Trinket 1
            [14]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers (Raid)"         }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar (Raid)"           }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek (Raid)"                    }, -- Main Hand
            [17]= { itemID = 268196, name = "Venom-Slashed Scuteward",          source = "The Lost Explorers (Raid)"         }, -- Off Hand
        },
    },
}
