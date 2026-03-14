-- BiS data: Protection Warrior — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/warrior/protection/bis-gear
--         https://www.wowhead.com/guide/classes/warrior/protection/stat-priority-pve-tank
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["WARRIOR_PROTECTION"] = {
    label = "Protection Warrior",
    class = "WARRIOR",
    spec  = "Protection",

    -- Colossus & Mountain Thane: Haste >> Crit = Vers > Mastery
    statPriority = {
        raid = {
            note  = "Haste #1 by wide margin: reduces GCD, boosts Rage gen & Shield Block uptime",
            stats = {
                { name = "Haste",           op = ">>",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = "=",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Mastery",         op = nil,   r = 0.30, g = 0.75, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same as Raid",
            stats = {
                { name = "Haste",           op = ">>",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = "=",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Mastery",         op = nil,   r = 0.30, g = 0.75, b = 1.00 },
            },
        },
        dr = {
            { name = "Haste",          rating = 1320, r = 1.00, g = 0.82, b = 0.20 },
            { name = "Crit / Mastery", rating = 1380, r = 1.00, g = 0.60, b = 0.30 },
            { name = "Versatility",    rating = 1620, r = 0.65, g = 0.40, b = 1.00 },
        },
    },

    content = {
        -- ── Raid BiS ────────────────────────────────────────
        -- Protection uses 1H weapon + shield
        raid = {
            [1]  = { itemID = 249316, name = "Crown of the Fractured Tyrant",  source = "Fallen-King Salhadaar · Voidspire"}, -- Head
            [2]  = { itemID = 249368, name = "Eternal Voidsong Chain",          source = "Crown of the Cosmos · Voidspire" }, -- Neck
            [3]  = { itemID = 249950, name = "Night Ender's Pauldrons",         source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249955, name = "Night Ender's Breastplate",       source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249331, name = "Ezzorak's Gloombind",             source = "Vaelgor & Ezzorak · Voidspire"   }, -- Waist
            [7]  = { itemID = 249951, name = "Night Ender's Chausses",          source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249381, name = "Greaves of the Unformed",         source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 249326, name = "Light's March Bracers",           source = "Imperator Averzian"              }, -- Wrist
            [10] = { itemID = 249953, name = "Night Ender's Fists",             source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                 source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 151311, name = "Band of the Triumvirate",         source = "Seat of the Triumvirate"         }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",             source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249342, name = "Heart of Ancient Hunger",         source = "Vorasius"                        }, -- Trinket 2
            [15] = { itemID = 249370, name = "Draconic Nullcape",               source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 249295, name = "Turalyon's False Echo",           source = "Crown of the Cosmos · Voidspire" }, -- Main Hand
            [17] = { itemID = 249921, name = "Thalassian Dawnguard",            source = "Belo'ren"                        }, -- Off Hand (shield)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Same as Raid (M+: Heart of Wind is strong alternative Trinket 2)
        mythicplus = {
            [1]  = { itemID = 249316, name = "Crown of the Fractured Tyrant",  source = "Fallen-King Salhadaar · Voidspire"}, -- Head
            [2]  = { itemID = 249368, name = "Eternal Voidsong Chain",          source = "Crown of the Cosmos · Voidspire" }, -- Neck
            [3]  = { itemID = 249950, name = "Night Ender's Pauldrons",         source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249955, name = "Night Ender's Breastplate",       source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249331, name = "Ezzorak's Gloombind",             source = "Vaelgor & Ezzorak · Voidspire"   }, -- Waist
            [7]  = { itemID = 249951, name = "Night Ender's Chausses",          source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249381, name = "Greaves of the Unformed",         source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 249326, name = "Light's March Bracers",           source = "Imperator Averzian"              }, -- Wrist
            [10] = { itemID = 249953, name = "Night Ender's Fists",             source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                 source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 151311, name = "Band of the Triumvirate",         source = "Seat of the Triumvirate"         }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",             source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 250256, name = "Heart of Wind",                   source = "Mythic+"                         }, -- Trinket 2 (M+)
            [15] = { itemID = 249370, name = "Draconic Nullcape",               source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 249295, name = "Turalyon's False Echo",           source = "Crown of the Cosmos · Voidspire" }, -- Main Hand
            [17] = { itemID = 249921, name = "Thalassian Dawnguard",            source = "Belo'ren"                        }, -- Off Hand (shield)
        },
    },
}
