-- BiS data: Mistweaver Monk — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/monk/mistweaver/bis-gear
--         https://www.wowhead.com/guide/classes/monk/mistweaver/stat-priority-pve-healer
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["MONK_MISTWEAVER"] = {
    label = "Mistweaver Monk",
    class = "MONK",
    spec  = "Mistweaver",

    -- Shado-pan & Master of Harmony: identical priority
    statPriority = {
        raid = {
            note  = "Raid: Haste>Crit>Vers>Mastery. Crit generates Mana Tea stacks",
            stats = {
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Mastery",         op = nil,   r = 0.30, g = 0.75, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "M+: Vers moves above Crit (damage reduction value in high keys)",
            stats = {
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
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
        raid = {
            [1]  = { itemID = 249913, name = "Mask of Darkest Intent",            source = "Midnight Falls"                  }, -- Head
            [2]  = { itemID = 249337, name = "Ribbon of Coiled Malice",            source = "Fallen-King Salhadaar · Voidspire"}, -- Neck
            [3]  = { itemID = 250013, name = "Aurastones of Ra-den's Chosen",      source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250018, name = "Battle Garb of Ra-den's Chosen",     source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 251082, name = "Snapvine Cinch",                     source = "Windrunner Spire"                }, -- Waist
            [7]  = { itemID = 250014, name = "Swiftsweepers of Ra-den's Chosen",   source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249373, name = "Dream-Scorched Striders",            source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 251079, name = "Amberfrond Bracers",                 source = "Windrunner Spire"                }, -- Wrist
            [10] = { itemID = 250016, name = "Thunderfists of Ra-den's Chosen",    source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                    source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249919, name = "Sin'dorei Band of Hope",             source = "Belo'ren"                        }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249809, name = "Locus-Walker's Ribbon",              source = "Crown of the Cosmos · Voidspire" }, -- Trinket 2
            [15] = { itemID = 249370, name = "Draconic Nullcape",                  source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 258050, name = "Arcanic of the High Sage",           source = "Skyreach"                        }, -- Main Hand
            [17] = { itemID = 249276, name = "Grimoire of the Eternal Light",      source = "Vorasius"                        }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Differences: Trinket 1, Trinket 2
        mythicplus = {
            [1]  = { itemID = 249913, name = "Mask of Darkest Intent",            source = "Midnight Falls"                  }, -- Head
            [2]  = { itemID = 249337, name = "Ribbon of Coiled Malice",            source = "Fallen-King Salhadaar · Voidspire"}, -- Neck
            [3]  = { itemID = 250013, name = "Aurastones of Ra-den's Chosen",      source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250018, name = "Battle Garb of Ra-den's Chosen",     source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 251082, name = "Snapvine Cinch",                     source = "Windrunner Spire"                }, -- Waist
            [7]  = { itemID = 250014, name = "Swiftsweepers of Ra-den's Chosen",   source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249373, name = "Dream-Scorched Striders",            source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 251079, name = "Amberfrond Bracers",                 source = "Windrunner Spire"                }, -- Wrist
            [10] = { itemID = 250016, name = "Thunderfists of Ra-den's Chosen",    source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                    source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249919, name = "Sin'dorei Band of Hope",             source = "Belo'ren"                        }, -- Ring 2
            [13] = { itemID = 250256, name = "Heart of Wind",                      source = "Mythic+"                         }, -- Trinket 1 (M+)
            [14] = { itemID = 250144, name = "Emberwing Feather",                  source = "Windrunner Spire"                }, -- Trinket 2 (M+)
            [15] = { itemID = 249370, name = "Draconic Nullcape",                  source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 258050, name = "Arcanic of the High Sage",           source = "Skyreach"                        }, -- Main Hand
            [17] = { itemID = 249276, name = "Grimoire of the Eternal Light",      source = "Vorasius"                        }, -- Off Hand
        },
    },
}
