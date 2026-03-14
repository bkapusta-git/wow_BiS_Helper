-- BiS data: Blood Death Knight — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/death-knight/blood/bis-gear
--         https://www.wowhead.com/guide/classes/death-knight/blood/stat-priority-pve-tank
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DEATHKNIGHT_BLOOD"] = {
    label = "Blood Death Knight",
    class = "DEATHKNIGHT",
    spec  = "Blood",

    -- San'layn: Haste dominant; Deathbringer: Crit > Mastery > Vers >> Haste
    -- Both builds: same priority in Raid and M+
    statPriority = {
        raid = {
            note  = "San'layn: Haste>>rest. Deathbringer: Crit>=Mastery>=Vers>>Haste",
            stats = {
                { name = "Haste",           op = ">>",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">=",  r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery",         op = ">=",  r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same priority as Raid — both builds identical in M+",
            stats = {
                { name = "Haste",           op = ">>",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">=",  r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery",         op = ">=",  r = 0.30, g = 0.75, b = 1.00 },
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
        raid = {
            [1]  = { itemID = 249970, name = "Relentless Rider's Crown",       source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 249368, name = "Eternal Voidsong Chain",         source = "Crown of the Cosmos · Voidspire" }, -- Neck
            [3]  = { itemID = 249968, name = "Relentless Rider's Dreadthorns", source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249973, name = "Relentless Rider's Cuirass",     source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 49808,  name = "Bent Gold Belt",                 source = "Pit of Saron"                    }, -- Waist
            [7]  = { itemID = 249969, name = "Relentless Rider's Legguards",   source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249381, name = "Greaves of the Unformed",        source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 237834, name = "Spellbreaker's Bracers",         source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 151332, name = "Voidclaw Gauntlets",             source = "Seat of the Triumvirate"         }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 251513, name = "Loa Worshiper's Band",           source = "Crafted"                         }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",            source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249344, name = "Light Company Guidon",           source = "Imperator Averzian"              }, -- Trinket 2
            [15] = { itemID = 260312, name = "Defiant Defender's Drape",       source = "Magister's Terrace"              }, -- Back
            [16] = { itemID = 49802,  name = "Garfrost's Two-Ton Hammer",      source = "Pit of Saron"                    }, -- Main Hand (2H)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Difference: Trinket 1 (Solarflare Prism preferred in M+)
        mythicplus = {
            [1]  = { itemID = 249970, name = "Relentless Rider's Crown",       source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 249368, name = "Eternal Voidsong Chain",         source = "Crown of the Cosmos · Voidspire" }, -- Neck
            [3]  = { itemID = 249968, name = "Relentless Rider's Dreadthorns", source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249973, name = "Relentless Rider's Cuirass",     source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 49808,  name = "Bent Gold Belt",                 source = "Pit of Saron"                    }, -- Waist
            [7]  = { itemID = 249969, name = "Relentless Rider's Legguards",   source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249381, name = "Greaves of the Unformed",        source = "Chimaerus · The Dreamrift"       }, -- Feet
            [9]  = { itemID = 237834, name = "Spellbreaker's Bracers",         source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 151332, name = "Voidclaw Gauntlets",             source = "Seat of the Triumvirate"         }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 251513, name = "Loa Worshiper's Band",           source = "Crafted"                         }, -- Ring 2
            [13] = { itemID = 252420, name = "Solarflare Prism",               source = "Mythic+"                         }, -- Trinket 1 (M+)
            [14] = { itemID = 249344, name = "Light Company Guidon",           source = "Imperator Averzian"              }, -- Trinket 2
            [15] = { itemID = 260312, name = "Defiant Defender's Drape",       source = "Magister's Terrace"              }, -- Back
            [16] = { itemID = 49802,  name = "Garfrost's Two-Ton Hammer",      source = "Pit of Saron"                    }, -- Main Hand (2H)
        },
    },
}
