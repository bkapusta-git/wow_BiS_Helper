-- BiS data: Preservation Evoker — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/evoker/preservation/bis-gear
--         https://www.wowhead.com/guide/classes/evoker/preservation/stat-priority-pve-healer
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["EVOKER_PRESERVATION"] = {
    label = "Preservation Evoker",
    class = "EVOKER",
    spec  = "Preservation",

    -- Flameshaper & Chronowarden: identical priority
    statPriority = {
        raid = {
            note  = "Flameshaper & Chronowarden: identical. Mastery is pass/fail based on target HP",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same as Raid — no difference between Raid and M+",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
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
        -- Preservation uses a staff (2H, slot 16 only)
        raid = {
            [1]  = { itemID = 249914, name = "Oblivion Guise",                     source = "Midnight Falls"                  }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",         source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 249995, name = "Beacons of the Black Talon",         source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250000, name = "Frenzyward of the Black Talon",      source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 193722, name = "Azure Belt of Competition",           source = "Algeth'ar Academy"               }, -- Waist
            [7]  = { itemID = 249996, name = "Greaves of the Black Talon",         source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 251084, name = "Whipcoil Sabatons",                  source = "Windrunner Spire"                }, -- Feet
            [9]  = { itemID = 251079, name = "Amberfrond Bracers",                 source = "Windrunner Spire"                }, -- Wrist
            [10] = { itemID = 249998, name = "Enforcer's Grips of the Black Talon",source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249369, name = "Bond of Light",                      source = "Lightblinded Vanguard"           }, -- Ring 1
            [12] = { itemID = 249920, name = "Eye of Midnight",                    source = "Midnight Falls"                  }, -- Ring 2
            [13] = { itemID = 249346, name = "Vaelgor's Final Stare",              source = "Vaelgor & Ezzorak · Voidspire"   }, -- Trinket 1
            [14] = { itemID = 249809, name = "Locus-Walker's Ribbon",              source = "Crown of the Cosmos · Voidspire" }, -- Trinket 2
            [15] = { itemID = 251206, name = "Fluxweave Cloak",                    source = "Nexus Point Xenas"               }, -- Back
            [16] = { itemID = 258514, name = "Umbral Spire of Zuraal",             source = "Seat of the Triumvirate"         }, -- Main Hand (staff)
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- No full M+ list from Wowhead; same as Raid
        mythicplus = {
            [1]  = { itemID = 249914, name = "Oblivion Guise",                     source = "Midnight Falls"                  }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",         source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 249995, name = "Beacons of the Black Talon",         source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250000, name = "Frenzyward of the Black Talon",      source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 193722, name = "Azure Belt of Competition",           source = "Algeth'ar Academy"               }, -- Waist
            [7]  = { itemID = 249996, name = "Greaves of the Black Talon",         source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 251084, name = "Whipcoil Sabatons",                  source = "Windrunner Spire"                }, -- Feet
            [9]  = { itemID = 251079, name = "Amberfrond Bracers",                 source = "Windrunner Spire"                }, -- Wrist
            [10] = { itemID = 249998, name = "Enforcer's Grips of the Black Talon",source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249369, name = "Bond of Light",                      source = "Lightblinded Vanguard"           }, -- Ring 1
            [12] = { itemID = 249920, name = "Eye of Midnight",                    source = "Midnight Falls"                  }, -- Ring 2
            [13] = { itemID = 249346, name = "Vaelgor's Final Stare",              source = "Vaelgor & Ezzorak · Voidspire"   }, -- Trinket 1
            [14] = { itemID = 249809, name = "Locus-Walker's Ribbon",              source = "Crown of the Cosmos · Voidspire" }, -- Trinket 2
            [15] = { itemID = 251206, name = "Fluxweave Cloak",                    source = "Nexus Point Xenas"               }, -- Back
            [16] = { itemID = 258514, name = "Umbral Spire of Zuraal",             source = "Seat of the Triumvirate"         }, -- Main Hand (staff)
        },
    },
}
