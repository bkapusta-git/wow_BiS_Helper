-- BiS data: Retribution Paladin — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/paladin/retribution/bis-gear
--         https://www.wowhead.com/guide/classes/paladin/retribution/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["PALADIN_RETRIBUTION"] = {
    label = "Retribution Paladin",
    class = "PALADIN",
    spec  = "Retribution",

    -- Templar & Herald of the Sun: Mastery > Haste > Crit > Vers
    statPriority = {
        raid = {
            note  = "Templar & Herald of the Sun: identical. Mastery boosts Holy damage and Judgment",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same as Raid",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
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
        -- Retribution uses 2H weapon
        raid = {
            [1]  = { itemID = 249961, name = "Luminant Verdict's Unwavering Gaze",  source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",          source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 249959, name = "Luminant Verdict's Providence Watch",  source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249964, name = "Luminant Verdict's Divine Warplate",  source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249380, name = "Hate-Tied Waistchain",                source = "Crown of the Cosmos · Voidspire" }, -- Waist
            [7]  = { itemID = 249960, name = "Luminant Verdict's Greaves",          source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249381, name = "Greaves of the Unformed",             source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 237834, name = "Spellbreaker's Bracers",              source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 151332, name = "Voidclaw Gauntlets",                  source = "Seat of the Triumvirate"         }, -- Hands
            [11] = { itemID = 249919, name = "Sin'dorei Band of Hope",              source = "Belo'ren"                        }, -- Ring 1
            [12] = { itemID = 249920, name = "Eye of Midnight",                     source = "Midnight Falls"                  }, -- Ring 2
            [13] = { itemID = 260235, name = "Umbral Plume",                        source = "Belo'ren"                        }, -- Trinket 1
            [14] = { itemID = 249343, name = "Gaze of the Alnseer",                 source = "Chimaerus · The Dreamrift"       }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",            source = "Crafted"                         }, -- Back
            [16] = { itemID = 249277, name = "Bellamy's Final Judgement",           source = "Lightblinded Vanguard"           }, -- Main Hand (2H)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Difference: Trinkets (Omission of Light + Occlusion of Void preferred in M+)
        mythicplus = {
            [1]  = { itemID = 249961, name = "Luminant Verdict's Unwavering Gaze",  source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",          source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 249959, name = "Luminant Verdict's Providence Watch",  source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249964, name = "Luminant Verdict's Divine Warplate",  source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249380, name = "Hate-Tied Waistchain",                source = "Crown of the Cosmos · Voidspire" }, -- Waist
            [7]  = { itemID = 249960, name = "Luminant Verdict's Greaves",          source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249381, name = "Greaves of the Unformed",             source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 237834, name = "Spellbreaker's Bracers",              source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 151332, name = "Voidclaw Gauntlets",                  source = "Seat of the Triumvirate"         }, -- Hands
            [11] = { itemID = 249919, name = "Sin'dorei Band of Hope",              source = "Belo'ren"                        }, -- Ring 1
            [12] = { itemID = 249920, name = "Eye of Midnight",                     source = "Midnight Falls"                  }, -- Ring 2
            [13] = { itemID = 251093, name = "Omission of Light",                   source = "Nexus Point Xenas"               }, -- Trinket 1 (M+)
            [14] = { itemID = 251217, name = "Occlusion of Void",                   source = "Nexus Point Xenas"               }, -- Trinket 2 (M+)
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",            source = "Crafted"                         }, -- Back
            [16] = { itemID = 249277, name = "Bellamy's Final Judgement",           source = "Lightblinded Vanguard"           }, -- Main Hand (2H)
        },
    },
}
