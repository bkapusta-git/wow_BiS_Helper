-- BiS data: Balance Druid — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/druid/balance/bis-gear
--         https://www.wowhead.com/guide/classes/druid/balance/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DRUID_BALANCE"] = {
    label = "Balance Druid",
    class = "DRUID",
    spec  = "Balance",

    -- Keeper of the Grove: Mastery > Haste = Crit > Vers
    -- Elune's Chosen:      Mastery > Haste > Crit > Vers
    statPriority = {
        raid = {
            note  = "Keeper: Haste=Crit after Mastery. Elune's: Haste>Crit",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = "=",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same priority as Raid — M+ uses dungeon weapon alternative",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = "=",   r = 1.00, g = 0.82, b = 0.20 },
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
        raid = {
            [1]  = { itemID = 250024, name = "Branches of the Luminous Bloom",    source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",         source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 250022, name = "Seedpods of the Luminous Bloom",     source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250027, name = "Trunk of the Luminous Bloom",        source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 251082, name = "Snapvine Cinch",                     source = "Windrunner Spire"                }, -- Waist
            [7]  = { itemID = 250023, name = "Phloemwraps of the Luminous Bloom",  source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249382, name = "Canopy Walker's Footwraps",          source = "Crown of the Cosmos · Voidspire" }, -- Feet
            [9]  = { itemID = 244576, name = "Silvermoon Agent's Deflectors",      source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 251113, name = "Gloves of Viscous Goo",              source = "Magister's Terrace"              }, -- Hands
            [11] = { itemID = 193708, name = "Platinum Star Band",                 source = "Algeth'ar Academy"               }, -- Ring 1
            [12] = { itemID = 251217, name = "Occlusion of Void",                  source = "Nexus Point Xenas"               }, -- Ring 2
            [13] = { itemID = 249346, name = "Vaelgor's Final Stare",              source = "Vaelgor & Ezzorak · Voidspire"   }, -- Trinket 1
            [14] = { itemID = 249343, name = "Gaze of the Alnseer",                source = "Chimaerus · The Dreamrift"       }, -- Trinket 2
            [15] = { itemID = 249370, name = "Draconic Nullcape",                  source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 249283, name = "Belo'melorn, the Shattered Talon",   source = "Belo'ren"                        }, -- Main Hand
            [17] = { itemID = 245769, name = "Aln'hara Lantern",                   source = "Crafted"                         }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Difference: Main Hand (Final Grade preferred in M+)
        mythicplus = {
            [1]  = { itemID = 250024, name = "Branches of the Luminous Bloom",    source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",         source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 250022, name = "Seedpods of the Luminous Bloom",     source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250027, name = "Trunk of the Luminous Bloom",        source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 251082, name = "Snapvine Cinch",                     source = "Windrunner Spire"                }, -- Waist
            [7]  = { itemID = 250023, name = "Phloemwraps of the Luminous Bloom",  source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249382, name = "Canopy Walker's Footwraps",          source = "Crown of the Cosmos · Voidspire" }, -- Feet
            [9]  = { itemID = 244576, name = "Silvermoon Agent's Deflectors",      source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 251113, name = "Gloves of Viscous Goo",              source = "Magister's Terrace"              }, -- Hands
            [11] = { itemID = 193708, name = "Platinum Star Band",                 source = "Algeth'ar Academy"               }, -- Ring 1
            [12] = { itemID = 251217, name = "Occlusion of Void",                  source = "Nexus Point Xenas"               }, -- Ring 2
            [13] = { itemID = 249346, name = "Vaelgor's Final Stare",              source = "Vaelgor & Ezzorak · Voidspire"   }, -- Trinket 1
            [14] = { itemID = 249343, name = "Gaze of the Alnseer",                source = "Chimaerus · The Dreamrift"       }, -- Trinket 2
            [15] = { itemID = 249370, name = "Draconic Nullcape",                  source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 193707, name = "Final Grade",                        source = "Mythic+"                         }, -- Main Hand (M+)
            [17] = { itemID = 245769, name = "Aln'hara Lantern",                   source = "Crafted"                         }, -- Off Hand
        },
    },
}
