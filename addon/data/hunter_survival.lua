-- BiS data: Survival Hunter — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/hunter/survival/bis-gear
--         https://www.wowhead.com/guide/classes/hunter/survival/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["HUNTER_SURVIVAL"] = {
    label = "Survival Hunter",
    class = "HUNTER",
    spec  = "Survival",

    -- Pack Leader: Mastery > Crit = Haste > Vers
    -- Sentinel:    Mastery > Crit > Haste > Vers
    statPriority = {
        raid = {
            note  = "Pack Leader & Sentinel: Mastery first. Pack Leader: Crit=Haste; Sentinel: Crit>Haste",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">=",  r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same as Raid — no AoE difference",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">=",  r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
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
        -- Survival is melee; uses 2H polearm
        raid = {
            [1]  = { itemID = 249988, name = "Primal Sentry's Maw",              source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",        source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 151323, name = "Pauldrons of the Void Hunter",       source = "Seat of the Triumvirate"         }, -- Shoulder
            [5]  = { itemID = 249991, name = "Primal Sentry's Scaleplate",        source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249371, name = "Scornbane Waistguard",              source = "Chimaerus · The Dreamrift"       }, -- Waist
            [7]  = { itemID = 249987, name = "Primal Sentry's Legguards",         source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 244577, name = "Farstrider's Razor Talons",         source = "Crafted"                         }, -- Feet
            [9]  = { itemID = 249304, name = "Fallen King's Cuffs",               source = "Fallen-King Salhadaar · Voidspire"}, -- Wrist
            [10] = { itemID = 249989, name = "Primal Sentry's Talonguards",       source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 251093, name = "Omission of Light",                 source = "Nexus Point Xenas"               }, -- Ring 1
            [12] = { itemID = 251217, name = "Occlusion of Void",                 source = "Nexus Point Xenas"               }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",               source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249806, name = "Radiant Plume",                     source = "Belo'ren"                        }, -- Trinket 2
            [15] = { itemID = 249370, name = "Draconic Nullcape",                 source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 251077, name = "Roostwarden's Bough",               source = "Windrunner Spire"                }, -- Main Hand (2H polearm)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- No full M+ list from Wowhead; same as Raid
        mythicplus = {
            [1]  = { itemID = 249988, name = "Primal Sentry's Maw",              source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",        source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 151323, name = "Pauldrons of the Void Hunter",       source = "Seat of the Triumvirate"         }, -- Shoulder
            [5]  = { itemID = 249991, name = "Primal Sentry's Scaleplate",        source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249371, name = "Scornbane Waistguard",              source = "Chimaerus · The Dreamrift"       }, -- Waist
            [7]  = { itemID = 249987, name = "Primal Sentry's Legguards",         source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 244577, name = "Farstrider's Razor Talons",         source = "Crafted"                         }, -- Feet
            [9]  = { itemID = 249304, name = "Fallen King's Cuffs",               source = "Fallen-King Salhadaar · Voidspire"}, -- Wrist
            [10] = { itemID = 249989, name = "Primal Sentry's Talonguards",       source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 251093, name = "Omission of Light",                 source = "Nexus Point Xenas"               }, -- Ring 1
            [12] = { itemID = 251217, name = "Occlusion of Void",                 source = "Nexus Point Xenas"               }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",               source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249806, name = "Radiant Plume",                     source = "Belo'ren"                        }, -- Trinket 2
            [15] = { itemID = 249370, name = "Draconic Nullcape",                 source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 251077, name = "Roostwarden's Bough",               source = "Windrunner Spire"                }, -- Main Hand (2H polearm)
        },
    },
}
