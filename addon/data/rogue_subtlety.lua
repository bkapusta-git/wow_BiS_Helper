-- BiS data: Subtlety Rogue — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/rogue/subtlety/bis-gear
--         https://www.wowhead.com/guide/classes/rogue/subtlety/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["ROGUE_SUBTLETY"] = {
    label = "Subtlety Rogue",
    class = "ROGUE",
    spec  = "Subtlety",

    -- Deathstalker & Fatebound: Mastery > Haste (~18%) >= Crit >> Vers
    statPriority = {
        raid = {
            note  = "Mastery > Haste (~18%) >= Crit >> Vers. Mastery amplifies finishing move damage",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = ">=",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">>",  r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same as Raid — Mastery further ahead in AoE",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = ">=",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">>",  r = 1.00, g = 0.35, b = 0.35 },
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
        -- Subtlety dual-wields daggers
        raid = {
            [1]  = { itemID = 250006, name = "Masquerade of the Grim Jest",        source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 249368, name = "Eternal Voidsong Chain",              source = "Crown of the Cosmos · Voidspire" }, -- Neck
            [3]  = { itemID = 250004, name = "Venom Casks of the Grim Jest",        source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250009, name = "Fantastic Finery of the Grim Jest",   source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 244573, name = "Silvermoon Agent's Utility Belt",     source = "Crafted"                         }, -- Waist
            [7]  = { itemID = 133499, name = "Shaggy Wyrmleather Leggings",         source = "Pit of Saron"                    }, -- Legs
            [8]  = { itemID = 258577, name = "Boots of Burning Focus",              source = "Skyreach"                        }, -- Feet
            [9]  = { itemID = 249327, name = "Void-Skinned Bracers",                source = "Vorasius"                        }, -- Wrist
            [10] = { itemID = 250007, name = "Sleight of Hand of the Grim Jest",    source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 193708, name = "Platinum Star Band",                  source = "Algeth'ar Academy"               }, -- Ring 1
            [12] = { itemID = 251115, name = "Bifurcation Band",                    source = "Magister's Terrace"              }, -- Ring 2
            [13] = { itemID = 249344, name = "Light Company Guidon",                source = "Imperator Averzian"              }, -- Trinket 1
            [14] = { itemID = 249343, name = "Gaze of the Alnseer",                 source = "Chimaerus · The Dreamrift"       }, -- Trinket 2
            [15] = { itemID = 258575, name = "Rigid Scale Greatcloak",              source = "Skyreach"                        }, -- Back
            [16] = { itemID = 249925, name = "Hungering Victory",                   source = "Vorasius"                        }, -- Main Hand (dagger)
            [17] = { itemID = 237837, name = "Farstrider's Mercy",                  source = "Crafted"                         }, -- Off Hand (dagger)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Same as Raid
        mythicplus = {
            [1]  = { itemID = 250006, name = "Masquerade of the Grim Jest",        source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 249368, name = "Eternal Voidsong Chain",              source = "Crown of the Cosmos · Voidspire" }, -- Neck
            [3]  = { itemID = 250004, name = "Venom Casks of the Grim Jest",        source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250009, name = "Fantastic Finery of the Grim Jest",   source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 244573, name = "Silvermoon Agent's Utility Belt",     source = "Crafted"                         }, -- Waist
            [7]  = { itemID = 133499, name = "Shaggy Wyrmleather Leggings",         source = "Pit of Saron"                    }, -- Legs
            [8]  = { itemID = 258577, name = "Boots of Burning Focus",              source = "Skyreach"                        }, -- Feet
            [9]  = { itemID = 249327, name = "Void-Skinned Bracers",                source = "Vorasius"                        }, -- Wrist
            [10] = { itemID = 250007, name = "Sleight of Hand of the Grim Jest",    source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 193708, name = "Platinum Star Band",                  source = "Algeth'ar Academy"               }, -- Ring 1
            [12] = { itemID = 251115, name = "Bifurcation Band",                    source = "Magister's Terrace"              }, -- Ring 2
            [13] = { itemID = 249344, name = "Light Company Guidon",                source = "Imperator Averzian"              }, -- Trinket 1
            [14] = { itemID = 249343, name = "Gaze of the Alnseer",                 source = "Chimaerus · The Dreamrift"       }, -- Trinket 2
            [15] = { itemID = 258575, name = "Rigid Scale Greatcloak",              source = "Skyreach"                        }, -- Back
            [16] = { itemID = 249925, name = "Hungering Victory",                   source = "Vorasius"                        }, -- Main Hand
            [17] = { itemID = 237837, name = "Farstrider's Mercy",                  source = "Crafted"                         }, -- Off Hand
        },
    },
}
