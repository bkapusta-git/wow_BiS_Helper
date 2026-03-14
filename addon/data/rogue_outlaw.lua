-- BiS data: Outlaw Rogue — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/rogue/outlaw/bis-gear
--         https://www.wowhead.com/guide/classes/rogue/outlaw/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["ROGUE_OUTLAW"] = {
    label = "Outlaw Rogue",
    class = "ROGUE",
    spec  = "Outlaw",

    -- Deathstalker & Fatebound: Haste (to 25%) >= Crit > Vers >> Mastery
    statPriority = {
        raid = {
            note  = "Haste >= Crit > Vers >> Mastery. Haste priority until ~25%",
            stats = {
                { name = "Haste",           op = ">=",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = ">>",  r = 0.65, g = 0.40, b = 1.00 },
                { name = "Mastery",         op = nil,   r = 0.30, g = 0.75, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same as Raid — Mastery lowest priority",
            stats = {
                { name = "Haste",           op = ">=",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = ">>",  r = 0.65, g = 0.40, b = 1.00 },
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
        -- Outlaw dual-wields 1H weapons
        raid = {
            [1]  = { itemID = 151336, name = "Voidlashed Hood",                     source = "Seat of the Triumvirate"         }, -- Head
            [2]  = { itemID = 50228,  name = "Barbed Ymirheim Choker",              source = "Pit of Saron"                    }, -- Neck
            [3]  = { itemID = 250004, name = "Venom Casks of the Grim Jest",        source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250009, name = "Fantastic Finery of the Grim Jest",   source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249374, name = "Scorn-Scarred Shul'ka's Belt",        source = "Chimaerus · The Dreamrift"       }, -- Waist
            [7]  = { itemID = 250005, name = "Blade Holsters of the Grim Jest",     source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 244569, name = "Silvermoon Agent's Sneakers",         source = "Crafted"                         }, -- Feet
            [9]  = { itemID = 50264,  name = "Chewed Leather Wristguards",          source = "Pit of Saron"                    }, -- Wrist
            [10] = { itemID = 250007, name = "Sleight of Hand of the Grim Jest",    source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249336, name = "Signet of the Starved Beast",         source = "Vorasius"                        }, -- Ring 1
            [12] = { itemID = 240949, name = "Masterwork Sin'dorei Band",           source = "Crafted"                         }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                 source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 260235, name = "Umbral Plume",                        source = "Belo'ren"                        }, -- Trinket 2
            [15] = { itemID = 249335, name = "Imperator's Banner",                  source = "Imperator Averzian"              }, -- Back
            [16] = { itemID = 260423, name = "Arator's Swift Remembrance",          source = "Crown of the Cosmos · Voidspire" }, -- Main Hand
            [17] = { itemID = 133491, name = "Krick's Beetle Stabber",              source = "Pit of Saron"                    }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Same as Raid
        mythicplus = {
            [1]  = { itemID = 151336, name = "Voidlashed Hood",                     source = "Seat of the Triumvirate"         }, -- Head
            [2]  = { itemID = 50228,  name = "Barbed Ymirheim Choker",              source = "Pit of Saron"                    }, -- Neck
            [3]  = { itemID = 250004, name = "Venom Casks of the Grim Jest",        source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250009, name = "Fantastic Finery of the Grim Jest",   source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249374, name = "Scorn-Scarred Shul'ka's Belt",        source = "Chimaerus · The Dreamrift"       }, -- Waist
            [7]  = { itemID = 250005, name = "Blade Holsters of the Grim Jest",     source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 244569, name = "Silvermoon Agent's Sneakers",         source = "Crafted"                         }, -- Feet
            [9]  = { itemID = 50264,  name = "Chewed Leather Wristguards",          source = "Pit of Saron"                    }, -- Wrist
            [10] = { itemID = 250007, name = "Sleight of Hand of the Grim Jest",    source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249336, name = "Signet of the Starved Beast",         source = "Vorasius"                        }, -- Ring 1
            [12] = { itemID = 240949, name = "Masterwork Sin'dorei Band",           source = "Crafted"                         }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                 source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 260235, name = "Umbral Plume",                        source = "Belo'ren"                        }, -- Trinket 2
            [15] = { itemID = 249335, name = "Imperator's Banner",                  source = "Imperator Averzian"              }, -- Back
            [16] = { itemID = 260423, name = "Arator's Swift Remembrance",          source = "Crown of the Cosmos · Voidspire" }, -- Main Hand
            [17] = { itemID = 133491, name = "Krick's Beetle Stabber",              source = "Pit of Saron"                    }, -- Off Hand
        },
    },
}
