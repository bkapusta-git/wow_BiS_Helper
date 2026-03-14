-- BiS data: Holy Paladin — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/paladin/holy/bis-gear
--         https://www.wowhead.com/guide/classes/paladin/holy/stat-priority-pve-healer
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["PALADIN_HOLY"] = {
    label = "Holy Paladin",
    class = "PALADIN",
    spec  = "Holy",

    -- Herald of the Sun & Lightsmith: identical priority
    statPriority = {
        raid = {
            note  = "Herald & Lightsmith: identical. Mastery: Lightbringer scales with proximity",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = "=",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same as Raid",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = "=",   r = 1.00, g = 0.82, b = 0.20 },
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
        -- Holy Paladin uses 1H weapon + shield
        raid = {
            [1]  = { itemID = 249961, name = "Luminant Verdict's Unwavering Gaze",  source = "Lightblinded Vanguard"           }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",          source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 249959, name = "Luminant Verdict's Providence Watch",  source = "Fallen-King Salhadaar · Voidspire"}, -- Shoulder
            [5]  = { itemID = 249964, name = "Luminant Verdict's Divine Warplate",  source = "Chimaerus · The Dreamrift"       }, -- Chest
            [6]  = { itemID = 249331, name = "Ezzorak's Gloombind",                 source = "Vaelgor & Ezzorak · Voidspire"   }, -- Waist
            [7]  = { itemID = 249915, name = "Extinction Guards",                   source = "Midnight Falls"                  }, -- Legs
            [8]  = { itemID = 249332, name = "Parasite Stompers",                   source = "Vorasius"                        }, -- Feet
            [9]  = { itemID = 263193, name = "Trollhunter's Bands",                 source = "Maisara Caverns"                 }, -- Wrist
            [10] = { itemID = 249962, name = "Luminant Verdict's Gauntlets",        source = "Vorasius"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                     source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249919, name = "Sin'dorei Band of Hope",              source = "Belo'ren"                        }, -- Ring 2
            [13] = { itemID = 249346, name = "Vaelgor's Final Stare",               source = "Vaelgor & Ezzorak · Voidspire"   }, -- Trinket 1
            [14] = { itemID = 249343, name = "Gaze of the Alnseer",                 source = "Chimaerus · The Dreamrift"       }, -- Trinket 2
            [15] = { itemID = 258575, name = "Rigid Scale Greatcloak",              source = "Skyreach"                        }, -- Back
            [16] = { itemID = 193710, name = "Spellboon Saber",                     source = "Algeth'ar Academy"               }, -- Main Hand
            [17] = { itemID = 258049, name = "Viryx's Indomitable Bulwark",         source = "Skyreach"                        }, -- Off Hand (shield)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Difference: Trinket 1 (Omission of Light preferred in M+)
        mythicplus = {
            [1]  = { itemID = 249961, name = "Luminant Verdict's Unwavering Gaze",  source = "Lightblinded Vanguard"           }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",          source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 249959, name = "Luminant Verdict's Providence Watch",  source = "Fallen-King Salhadaar · Voidspire"}, -- Shoulder
            [5]  = { itemID = 249964, name = "Luminant Verdict's Divine Warplate",  source = "Chimaerus · The Dreamrift"       }, -- Chest
            [6]  = { itemID = 249331, name = "Ezzorak's Gloombind",                 source = "Vaelgor & Ezzorak · Voidspire"   }, -- Waist
            [7]  = { itemID = 249915, name = "Extinction Guards",                   source = "Midnight Falls"                  }, -- Legs
            [8]  = { itemID = 249332, name = "Parasite Stompers",                   source = "Vorasius"                        }, -- Feet
            [9]  = { itemID = 263193, name = "Trollhunter's Bands",                 source = "Maisara Caverns"                 }, -- Wrist
            [10] = { itemID = 249962, name = "Luminant Verdict's Gauntlets",        source = "Vorasius"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                     source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249919, name = "Sin'dorei Band of Hope",              source = "Belo'ren"                        }, -- Ring 2
            [13] = { itemID = 251093, name = "Omission of Light",                   source = "Nexus Point Xenas"               }, -- Trinket 1 (M+)
            [14] = { itemID = 249343, name = "Gaze of the Alnseer",                 source = "Chimaerus · The Dreamrift"       }, -- Trinket 2
            [15] = { itemID = 258575, name = "Rigid Scale Greatcloak",              source = "Skyreach"                        }, -- Back
            [16] = { itemID = 193710, name = "Spellboon Saber",                     source = "Algeth'ar Academy"               }, -- Main Hand
            [17] = { itemID = 258049, name = "Viryx's Indomitable Bulwark",         source = "Skyreach"                        }, -- Off Hand (shield)
        },
    },
}
