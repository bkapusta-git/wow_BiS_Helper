-- BiS data: Enhancement Shaman — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/shaman/enhancement/bis-gear
--         https://www.wowhead.com/guide/classes/shaman/enhancement/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["SHAMAN_ENHANCEMENT"] = {
    label = "Enhancement Shaman",
    class = "SHAMAN",
    spec  = "Enhancement",

    -- Stormbringer: Haste > Mastery = Crit > Vers
    -- Totemic: Mastery > Haste > Crit > Vers
    statPriority = {
        raid = {
            note  = "Stormbringer: Haste>Mastery=Crit>Vers. Totemic: Mastery>Haste>Crit>Vers",
            stats = {
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = "=",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same as Raid — Stormbringer recommended for M+",
            stats = {
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = "=",   r = 0.30, g = 0.75, b = 1.00 },
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
        -- Enhancement dual-wields 1H weapons
        raid = {
            [1]  = { itemID = 249979, name = "Locus of the Primal Core",       source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",     source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 249977, name = "Tempests of the Primal Core",    source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249982, name = "Embrace of the Primal Core",     source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 244611, name = "World Tender's Barkclasp",       source = "Crafted"                         }, -- Waist
            [7]  = { itemID = 251215, name = "Greaves of the Divine Guile",    source = "Nexus Point Xenas"               }, -- Legs
            [8]  = { itemID = 244610, name = "World Tender's Rootslippers",    source = "Crafted"                         }, -- Feet
            [9]  = { itemID = 251079, name = "Amberfrond Bracers",             source = "Windrunner Spire"                }, -- Wrist
            [10] = { itemID = 249980, name = "Earthgrips of the Primal Core",  source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249919, name = "Sin'dorei Band of Hope",         source = "Belo'ren"                        }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",            source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 250144, name = "Emberwing Feather",              source = "Windrunner Spire"                }, -- Trinket 2
            [15] = { itemID = 249974, name = "Guardian of the Primal Core",    source = "Catalyst"                        }, -- Back
            [16] = { itemID = 249287, name = "Clutchmates' Caress",            source = "Midnight Falls"                  }, -- Main Hand
            [17] = { itemID = 251175, name = "Soulblight Cleaver",             source = "Maisara Caverns"                 }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- M+: Blazing Sunclaws weapons
        mythicplus = {
            [1]  = { itemID = 249979, name = "Locus of the Primal Core",       source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",     source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 249977, name = "Tempests of the Primal Core",    source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249982, name = "Embrace of the Primal Core",     source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 244611, name = "World Tender's Barkclasp",       source = "Crafted"                         }, -- Waist
            [7]  = { itemID = 251215, name = "Greaves of the Divine Guile",    source = "Nexus Point Xenas"               }, -- Legs
            [8]  = { itemID = 244610, name = "World Tender's Rootslippers",    source = "Crafted"                         }, -- Feet
            [9]  = { itemID = 251079, name = "Amberfrond Bracers",             source = "Windrunner Spire"                }, -- Wrist
            [10] = { itemID = 249980, name = "Earthgrips of the Primal Core",  source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249919, name = "Sin'dorei Band of Hope",         source = "Belo'ren"                        }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",            source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 193701, name = "Algeth'ar Puzzle Box",           source = "Algeth'ar Academy"               }, -- Trinket 2 (M+)
            [15] = { itemID = 249974, name = "Guardian of the Primal Core",    source = "Catalyst"                        }, -- Back
            [16] = { itemID = 258438, name = "Blazing Sunclaws",               source = "Mythic+"                         }, -- Main Hand (M+)
            [17] = { itemID = 258438, name = "Blazing Sunclaws",               source = "Mythic+"                         }, -- Off Hand (M+)
        },
    },
}
