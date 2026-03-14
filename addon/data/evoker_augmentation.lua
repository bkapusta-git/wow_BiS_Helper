-- BiS data: Augmentation Evoker — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/evoker/augmentation/bis-gear
--         https://www.wowhead.com/guide/classes/evoker/augmentation/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["EVOKER_AUGMENTATION"] = {
    label = "Augmentation Evoker",
    class = "EVOKER",
    spec  = "Augmentation",

    -- Chronowarden & Scalecommander: identical priority
    statPriority = {
        raid = {
            note  = "Chronowarden & Scalecommander: identical. Mastery buffs allies via Shifting Sands",
            stats = {
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same as Raid — Versatility provides no ally buffing value",
            stats = {
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
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
        raid = {
            [1]  = { itemID = 249997, name = "Hornhelm of the Black Talon",       source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",         source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 249995, name = "Beacons of the Black Talon",         source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250000, name = "Frenzyward of the Black Talon",      source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 49810,  name = "Scabrous Zombie Leather Belt",       source = "Pit of Saron"                    }, -- Waist
            [7]  = { itemID = 249996, name = "Greaves of the Black Talon",         source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249999, name = "Spelltreads of the Black Talon",     source = "Catalyst"                        }, -- Feet
            [9]  = { itemID = 244584, name = "Farstrider's Plated Bracers",        source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 249325, name = "Untethered Berserker's Grips",       source = "Crown of the Cosmos · Voidspire" }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                    source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249919, name = "Sin'dorei Band of Hope",             source = "Belo'ren"                        }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249810, name = "Shadow of the Empyrean Requiem",     source = "Midnight Falls"                  }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",           source = "Crafted"                         }, -- Back
            [16] = { itemID = 251178, name = "Ceremonial Hexblade",                source = "Maisara Caverns"                 }, -- Main Hand
            [17] = { itemID = 249276, name = "Grimoire of the Eternal Light",      source = "Vorasius"                        }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- No full M+ list from Wowhead; same as Raid
        mythicplus = {
            [1]  = { itemID = 249997, name = "Hornhelm of the Black Talon",       source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",         source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 249995, name = "Beacons of the Black Talon",         source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250000, name = "Frenzyward of the Black Talon",      source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 49810,  name = "Scabrous Zombie Leather Belt",       source = "Pit of Saron"                    }, -- Waist
            [7]  = { itemID = 249996, name = "Greaves of the Black Talon",         source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249999, name = "Spelltreads of the Black Talon",     source = "Catalyst"                        }, -- Feet
            [9]  = { itemID = 244584, name = "Farstrider's Plated Bracers",        source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 249325, name = "Untethered Berserker's Grips",       source = "Crown of the Cosmos · Voidspire" }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                    source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 249919, name = "Sin'dorei Band of Hope",             source = "Belo'ren"                        }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249810, name = "Shadow of the Empyrean Requiem",     source = "Midnight Falls"                  }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",           source = "Crafted"                         }, -- Back
            [16] = { itemID = 251178, name = "Ceremonial Hexblade",                source = "Maisara Caverns"                 }, -- Main Hand
            [17] = { itemID = 249276, name = "Grimoire of the Eternal Light",      source = "Vorasius"                        }, -- Off Hand
        },
    },
}
