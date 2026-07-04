-- BiS data: Arcane Mage — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/mage/arcane/bis-gear
-- Source: https://www.wowhead.com/guide/classes/mage/arcane/stat-priority-pve-dps
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["MAGE_ARCANE"] = {
    label = "Arcane Mage",
    class = "MAGE",
    spec  = "Arcane",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
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
            [1]= { itemID = 250060, name = "Voidbreaker's Veil",               source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall"                         }, -- Neck
            [3]= { itemID = 250058, name = "Voidbreaker's Leyline Nexi",       source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250063, name = "Voidbreaker's Robe",               source = "Sporefall (Catalyze it!)"          }, -- Chest
            [6]= { itemID = 249376, name = "Whisper-Inscribed Sash",           source = "Belo'ren"                          }, -- Waist
            [7]= { itemID = 251090, name = "Commander's Faded Breeches",       source = "Windrunner Spire"                  }, -- Legs
            [8]= { itemID = 268282, name = "Luxurious Loamstriders",           source = "Sporefall"                         }, -- Feet
            [9]= { itemID = 239660, name = "Arcanoweave Bracers",              source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 250061, name = "Voidbreaker's Gloves",             source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren"                          }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 2
            [13]= { itemID = 249346, name = "Vaelgor's Final Stare",            source = "Vaelgor & Ezzorak · The Voidspire" }, -- Trinket 1
            [14]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 2
            [15]= { itemID = 239661, name = "Arcanoweave Cloak",                source = "Crafted"                           }, -- Back
            [16]= { itemID = 258218, name = "Skybreaker's Blade",               source = "Skyreach"                          }, -- Main Hand
            [17]= { itemID = 251094, name = "Sigil of the Restless Heart",      source = "Windrunner Spire"                  }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 250060, name = "Voidbreaker's Veil",               source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268291, name = "Rotmire's Sporeheart",             source = "Sporefall"                         }, -- Neck
            [3]= { itemID = 250058, name = "Voidbreaker's Leyline Nexi",       source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 250063, name = "Voidbreaker's Robe",               source = "Sporefall (Catalyze it!)"          }, -- Chest
            [6]= { itemID = 249376, name = "Whisper-Inscribed Sash",           source = "Belo'ren"                          }, -- Waist
            [7]= { itemID = 251090, name = "Commander's Faded Breeches",       source = "Windrunner Spire"                  }, -- Legs
            [8]= { itemID = 268282, name = "Luxurious Loamstriders",           source = "Sporefall"                         }, -- Feet
            [9]= { itemID = 239660, name = "Arcanoweave Bracers",              source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 250061, name = "Voidbreaker's Gloves",             source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 249919, name = "Sin'dorei Band of Hope",           source = "Belo'ren"                          }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 2
            [13]= { itemID = 249346, name = "Vaelgor's Final Stare",            source = "Vaelgor & Ezzorak · The Voidspire" }, -- Trinket 1
            [14]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 2
            [15]= { itemID = 239661, name = "Arcanoweave Cloak",                source = "Crafted"                           }, -- Back
            [16]= { itemID = 258218, name = "Skybreaker's Blade",               source = "Skyreach"                          }, -- Main Hand
            [17]= { itemID = 251094, name = "Sigil of the Restless Heart",      source = "Windrunner Spire"                  }, -- Off Hand
        },
    },
}
