-- BiS data: Restoration Shaman — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/shaman/restoration/bis-gear
--         https://www.wowhead.com/guide/classes/shaman/restoration/stat-priority-pve-healer
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["SHAMAN_RESTORATION"] = {
    label = "Restoration Shaman",
    class = "SHAMAN",
    spec  = "Restoration",

    -- Farseer (recommended): Crit > Haste = Mastery = Vers
    -- Totemic: Crit > Vers > Haste = Mastery
    statPriority = {
        raid = {
            note  = "Farseer (recommended): Crit > Haste = Mastery = Vers. Crit procs Resurgence mana",
            stats = {
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste",           op = "=",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = "=",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "M+: Crit > Vers > Haste = Mastery (Totemic preferred in high keys)",
            stats = {
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Haste",           op = "=",   r = 1.00, g = 0.82, b = 0.20 },
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
        -- Restoration uses 1H weapon + shield
        raid = {
            [1]  = { itemID = 249914, name = "Oblivion Guise",                 source = "Midnight Falls"                  }, -- Head
            [2]  = { itemID = 251096, name = "Pendant of Aching Grief",        source = "Windrunner Spire"                }, -- Neck
            [3]  = { itemID = 249977, name = "Tempests of the Primal Core",    source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249982, name = "Embrace of the Primal Core",     source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 193722, name = "Azure Belt of Competition",      source = "Algeth'ar Academy"               }, -- Waist
            [7]  = { itemID = 249978, name = "Leggings of the Primal Core",    source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249981, name = "Sollerets of the Primal Core",   source = "Catalyst"                        }, -- Feet
            [9]  = { itemID = 249975, name = "Cuffs of the Primal Core",       source = "Catalyst"                        }, -- Wrist
            [10] = { itemID = 249980, name = "Earthgrips of the Primal Core",  source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249336, name = "Signet of the Starved Beast",    source = "Vorasius"                        }, -- Ring 1
            [12] = { itemID = 193708, name = "Platinum Star Band",             source = "Algeth'ar Academy"               }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",            source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249809, name = "Locus-Walker's Ribbon",          source = "Crown of the Cosmos · Voidspire" }, -- Trinket 2
            [15] = { itemID = 251161, name = "Soulhunter's Mask",              source = "Maisara Caverns"                 }, -- Back
            [16] = { itemID = 251178, name = "Ceremonial Hexblade",            source = "Maisara Caverns"                 }, -- Main Hand
            [17] = { itemID = 249921, name = "Thalassian Dawnguard",           source = "Belo'ren"                        }, -- Off Hand (shield)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Same as Raid
        mythicplus = {
            [1]  = { itemID = 249914, name = "Oblivion Guise",                 source = "Midnight Falls"                  }, -- Head
            [2]  = { itemID = 251096, name = "Pendant of Aching Grief",        source = "Windrunner Spire"                }, -- Neck
            [3]  = { itemID = 249977, name = "Tempests of the Primal Core",    source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249982, name = "Embrace of the Primal Core",     source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 193722, name = "Azure Belt of Competition",      source = "Algeth'ar Academy"               }, -- Waist
            [7]  = { itemID = 249978, name = "Leggings of the Primal Core",    source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249981, name = "Sollerets of the Primal Core",   source = "Catalyst"                        }, -- Feet
            [9]  = { itemID = 249975, name = "Cuffs of the Primal Core",       source = "Catalyst"                        }, -- Wrist
            [10] = { itemID = 249980, name = "Earthgrips of the Primal Core",  source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249336, name = "Signet of the Starved Beast",    source = "Vorasius"                        }, -- Ring 1
            [12] = { itemID = 193708, name = "Platinum Star Band",             source = "Algeth'ar Academy"               }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",            source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249809, name = "Locus-Walker's Ribbon",          source = "Crown of the Cosmos · Voidspire" }, -- Trinket 2
            [15] = { itemID = 251161, name = "Soulhunter's Mask",              source = "Maisara Caverns"                 }, -- Back
            [16] = { itemID = 251178, name = "Ceremonial Hexblade",            source = "Maisara Caverns"                 }, -- Main Hand
            [17] = { itemID = 249921, name = "Thalassian Dawnguard",           source = "Belo'ren"                        }, -- Off Hand (shield)
        },
    },
}
