-- BiS data: Destruction Warlock — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/warlock/destruction/bis-gear
-- Source: https://www.wowhead.com/guide/classes/warlock/destruction/stat-priority-pve-dps
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["WARLOCK_DESTRUCTION"] = {
    label = "Destruction Warlock",
    class = "WARLOCK",
    spec  = "Destruction",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = "="  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = "="  , r = 0.30, g = 0.75, b = 1.00 },
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
            [1]= { itemID = 250042, name = "Abyssal Immolator's Smoldering Flames",source = "Tier Set"                          }, -- Head
            [2]= { itemID = 249368, name = "Eternal Voidsong Chain",           source = "Crown of the Cosmos · The Voidspire"}, -- Neck
            [3]= { itemID = 251085, name = "Mantle of Dark Devotion",          source = "Windrunner Spire"                  }, -- Shoulder
            [5]= { itemID = 250045, name = "Abyssal Immolator's Dreadrobe",    source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 249376, name = "Whisper-Inscribed Sash",           source = "Belo'ren"                          }, -- Waist
            [7]= { itemID = 250041, name = "Abyssal Immolator's Pillars",      source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 268282, name = "Luxurious Loamstriders",           source = "Sporefall (Raid)"                  }, -- Feet
            [9]= { itemID = 239648, name = "Martyr's Bindings",                source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 250043, name = "Abyssal Immolator's Grasps",       source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls"                    }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall (Raid)"                  }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 249346, name = "Vaelgor's Final Stare",            source = "Vaelgor & Ezzorak · The Voidspire" }, -- Trinket 2
            [15]= { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Crafted"                           }, -- Back
            [16]= { itemID = 249283, name = "Belo'melorn, the Shattered Talon", source = "Belo'ren"                          }, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 250042, name = "Abyssal Immolator's Smoldering Flames",source = "Tier Set"                          }, -- Head
            [2]= { itemID = 249368, name = "Eternal Voidsong Chain",           source = "Crown of the Cosmos · The Voidspire"}, -- Neck
            [3]= { itemID = 251085, name = "Mantle of Dark Devotion",          source = "Windrunner Spire"                  }, -- Shoulder
            [5]= { itemID = 250045, name = "Abyssal Immolator's Dreadrobe",    source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 249376, name = "Whisper-Inscribed Sash",           source = "Belo'ren"                          }, -- Waist
            [7]= { itemID = 250041, name = "Abyssal Immolator's Pillars",      source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 268282, name = "Luxurious Loamstriders",           source = "Sporefall (Raid)"                  }, -- Feet
            [9]= { itemID = 239648, name = "Martyr's Bindings",                source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 250043, name = "Abyssal Immolator's Grasps",       source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls"                    }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall (Raid)"                  }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 249346, name = "Vaelgor's Final Stare",            source = "Vaelgor & Ezzorak · The Voidspire" }, -- Trinket 2
            [15]= { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Crafted"                           }, -- Back
            [16]= { itemID = 249283, name = "Belo'melorn, the Shattered Talon", source = "Belo'ren"                          }, -- Main Hand
        },
    },
}
