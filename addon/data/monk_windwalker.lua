-- BiS data: Windwalker Monk — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/monk/windwalker/bis-gear
--         https://www.wowhead.com/guide/classes/monk/windwalker/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["MONK_WINDWALKER"] = {
    label = "Windwalker Monk",
    class = "MONK",
    spec  = "Windwalker",

    -- Shado-pan: Haste > Crit > Mastery > Vers
    -- Conduit of the Celestials: Haste > Mastery > Crit > Vers
    statPriority = {
        raid = {
            note  = "Shado-pan: Haste>Crit>Mastery>Vers. Conduit: Haste>Mastery>Crit>Vers",
            stats = {
                { name = "Haste",           op = ">>",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same as Raid — Haste >>> all others",
            stats = {
                { name = "Haste",           op = ">>",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
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
        -- Windwalker dual-wields fist weapons
        raid = {
            [1]  = { itemID = 250015, name = "Fearsome Visage of Ra-den's Chosen", source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",         source = "Seat of the Triumvirate"         }, -- Neck
            [3]  = { itemID = 250013, name = "Aurastones of Ra-den's Chosen",       source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250018, name = "Battle Garb of Ra-den's Chosen",      source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 251082, name = "Snapvine Cinch",                      source = "Windrunner Spire"                }, -- Waist
            [7]  = { itemID = 250014, name = "Swiftsweepers of Ra-den's Chosen",    source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 250017, name = "Storm Crashers of Ra-den's Chosen",   source = "Catalyst"                        }, -- Feet
            [9]  = { itemID = 249327, name = "Void-Skinned Bracers",                source = "Vorasius"                        }, -- Wrist
            [10] = { itemID = 249321, name = "Vaelgor's Fearsome Grasp",            source = "Vaelgor & Ezzorak · Voidspire"   }, -- Hands
            [11] = { itemID = 249919, name = "Sin'dorei Band of Hope",              source = "Belo'ren"                        }, -- Ring 1
            [12] = { itemID = 249920, name = "Eye of Midnight",                     source = "Midnight Falls"                  }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                 source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 193701, name = "Algeth'ar Puzzle Box",                source = "Algeth'ar Academy"               }, -- Trinket 2
            [15] = { itemID = 250010, name = "Windwrap of Ra-den's Chosen",         source = "Catalyst"                        }, -- Back
            [16] = { itemID = 237845, name = "Bloomforged Claw",                    source = "Crafted"                         }, -- Main Hand (fist)
            [17] = { itemID = 237845, name = "Bloomforged Claw",                    source = "Crafted"                         }, -- Off Hand (fist, dual wield)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- No full M+ list from Wowhead; same as Raid
        mythicplus = {
            [1]  = { itemID = 250015, name = "Fearsome Visage of Ra-den's Chosen", source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",         source = "Seat of the Triumvirate"         }, -- Neck
            [3]  = { itemID = 250013, name = "Aurastones of Ra-den's Chosen",       source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250018, name = "Battle Garb of Ra-den's Chosen",      source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 251082, name = "Snapvine Cinch",                      source = "Windrunner Spire"                }, -- Waist
            [7]  = { itemID = 250014, name = "Swiftsweepers of Ra-den's Chosen",    source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 250017, name = "Storm Crashers of Ra-den's Chosen",   source = "Catalyst"                        }, -- Feet
            [9]  = { itemID = 249327, name = "Void-Skinned Bracers",                source = "Vorasius"                        }, -- Wrist
            [10] = { itemID = 249321, name = "Vaelgor's Fearsome Grasp",            source = "Vaelgor & Ezzorak · Voidspire"   }, -- Hands
            [11] = { itemID = 249919, name = "Sin'dorei Band of Hope",              source = "Belo'ren"                        }, -- Ring 1
            [12] = { itemID = 249920, name = "Eye of Midnight",                     source = "Midnight Falls"                  }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                 source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 193701, name = "Algeth'ar Puzzle Box",                source = "Algeth'ar Academy"               }, -- Trinket 2
            [15] = { itemID = 250010, name = "Windwrap of Ra-den's Chosen",         source = "Catalyst"                        }, -- Back
            [16] = { itemID = 237845, name = "Bloomforged Claw",                    source = "Crafted"                         }, -- Main Hand
            [17] = { itemID = 237845, name = "Bloomforged Claw",                    source = "Crafted"                         }, -- Off Hand
        },
    },
}
