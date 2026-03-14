-- BiS data: Brewmaster Monk — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/monk/brewmaster/bis-gear
--         https://www.wowhead.com/guide/classes/monk/brewmaster/stat-priority-pve-tank
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["MONK_BREWMASTER"] = {
    label = "Brewmaster Monk",
    class = "MONK",
    spec  = "Brewmaster",

    -- Shado-pan & Master of Harmony: identical priority
    statPriority = {
        raid = {
            note  = "Shado-pan & Master of Harmony: identical. Item level > stat optimization",
            stats = {
                { name = "Versatility",     op = ">=",  r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = ">=",  r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = nil,   r = 1.00, g = 0.82, b = 0.20 },
            },
        },
        mythicplus = {
            note  = "M+: Crit moves to #1 (offensive Crit>Mastery>Vers>Haste)",
            stats = {
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Haste",           op = nil,   r = 1.00, g = 0.82, b = 0.20 },
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
        -- Raid: 2H polearm
        raid = {
            [1]  = { itemID = 250015, name = "Fearsome Visage of Ra-den's Chosen", source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 240950, name = "Masterwork Sin'dorei Amulet",         source = "Crafted"                         }, -- Neck
            [3]  = { itemID = 250013, name = "Aurastones of Ra-den's Chosen",       source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250018, name = "Battle Garb of Ra-den's Chosen",      source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 251082, name = "Snapvine Cinch",                      source = "Windrunner Spire"                }, -- Waist
            [7]  = { itemID = 151314, name = "Shifting Stalker Hide Pants",         source = "Seat of the Triumvirate"         }, -- Legs
            [8]  = { itemID = 151317, name = "Footpads of Seeping Dread",           source = "Seat of the Triumvirate"         }, -- Feet
            [9]  = { itemID = 250011, name = "Strikeguards of Ra-den's Chosen",     source = "Catalyst"                        }, -- Wrist
            [10] = { itemID = 250016, name = "Thunderfists of Ra-den's Chosen",     source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249336, name = "Signet of the Starved Beast",         source = "Vorasius"                        }, -- Ring 1
            [12] = { itemID = 251513, name = "Loa Worshiper's Band",                source = "Crafted"                         }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                 source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249806, name = "Radiant Plume",                       source = "Belo'ren"                        }, -- Trinket 2
            [15] = { itemID = 249335, name = "Imperator's Banner",                  source = "Imperator Averzian"              }, -- Back
            [16] = { itemID = 249302, name = "Inescapable Reach",                   source = "Vorasius"                        }, -- Main Hand (2H)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- M+: Switches to dual-wield, different trinkets, different head
        mythicplus = {
            [1]  = { itemID = 251177, name = "Fetid Vilecrown",                     source = "Mythic+"                         }, -- Head (M+)
            [2]  = { itemID = 240950, name = "Masterwork Sin'dorei Amulet",         source = "Crafted"                         }, -- Neck
            [3]  = { itemID = 250013, name = "Aurastones of Ra-den's Chosen",       source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250018, name = "Battle Garb of Ra-den's Chosen",      source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 251082, name = "Snapvine Cinch",                      source = "Windrunner Spire"                }, -- Waist
            [7]  = { itemID = 151314, name = "Shifting Stalker Hide Pants",         source = "Seat of the Triumvirate"         }, -- Legs
            [8]  = { itemID = 151317, name = "Footpads of Seeping Dread",           source = "Seat of the Triumvirate"         }, -- Feet
            [9]  = { itemID = 250011, name = "Strikeguards of Ra-den's Chosen",     source = "Catalyst"                        }, -- Wrist
            [10] = { itemID = 250016, name = "Thunderfists of Ra-den's Chosen",     source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249336, name = "Signet of the Starved Beast",         source = "Vorasius"                        }, -- Ring 1
            [12] = { itemID = 251513, name = "Loa Worshiper's Band",                source = "Crafted"                         }, -- Ring 2
            [13] = { itemID = 151312, name = "Ampoule of Pure Void",                source = "Seat of the Triumvirate"         }, -- Trinket 1 (M+)
            [14] = { itemID = 151307, name = "Void Stalker's Contract",             source = "Seat of the Triumvirate"         }, -- Trinket 2 (M+)
            [15] = { itemID = 249335, name = "Imperator's Banner",                  source = "Imperator Averzian"              }, -- Back
            [16] = { itemID = 251207, name = "Dreadflail Bludgeon",                 source = "Nexus Point Xenas"               }, -- Main Hand (M+ dual wield)
            [17] = { itemID = 251175, name = "Soulblight Cleaver",                  source = "Maisara Caverns"                 }, -- Off Hand (M+ dual wield)
        },
    },
}
