-- BiS data: Discipline Priest — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/priest/discipline/bis-gear
--         https://www.wowhead.com/guide/classes/priest/discipline/stat-priority-pve-healer
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["PRIEST_DISCIPLINE"] = {
    label = "Discipline Priest",
    class = "PRIEST",
    spec  = "Discipline",

    -- Oracle & Voidweaver: identical priority; no build differences
    -- M+: Versatility moves ahead of Mastery (survivability + damage value)
    statPriority = {
        raid = {
            note  = "Oracle & Voidweaver: identical. Secondaries after Haste are close",
            stats = {
                { name = "Haste",           op = ">>>", r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "M+: Versatility > Mastery for survivability and damage contribution",
            stats = {
                { name = "Haste",           op = ">>>", r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
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
            [1]  = { itemID = 250051, name = "Blind Oath's Winged Crest",          source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 249368, name = "Eternal Voidsong Chain",             source = "Crown of the Cosmos · Voidspire" }, -- Neck
            [3]  = { itemID = 250049, name = "Blind Oath's Seraphguards",          source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249912, name = "Robes of Endless Oblivion",          source = "Midnight Falls"                  }, -- Chest
            [6]  = { itemID = 239664, name = "Arcanoweave Cord",                   source = "Crafted"                         }, -- Waist
            [7]  = { itemID = 250050, name = "Blind Oath's Leggings",              source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 258584, name = "Lightbinder Treads",                 source = "Skyreach"                        }, -- Feet
            [9]  = { itemID = 249315, name = "Voracious Wristwraps",               source = "Vorasius"                        }, -- Wrist
            [10] = { itemID = 250052, name = "Blind Oath's Touch",                 source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                    source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 251093, name = "Omission of Light",                  source = "Nexus Point Xenas"               }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249346, name = "Vaelgor's Final Stare",              source = "Vaelgor & Ezzorak · Voidspire"   }, -- Trinket 2
            [15] = { itemID = 249370, name = "Draconic Nullcape",                  source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 249283, name = "Belo'melorn, the Shattered Talon",   source = "Belo'ren"                        }, -- Main Hand
            [17] = { itemID = 245769, name = "Aln'hara Lantern",                   source = "Crafted"                         }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Difference: Main Hand (Splitshroud Stinger preferred in M+)
        mythicplus = {
            [1]  = { itemID = 250051, name = "Blind Oath's Winged Crest",          source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 249368, name = "Eternal Voidsong Chain",             source = "Crown of the Cosmos · Voidspire" }, -- Neck
            [3]  = { itemID = 250049, name = "Blind Oath's Seraphguards",          source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 249912, name = "Robes of Endless Oblivion",          source = "Midnight Falls"                  }, -- Chest
            [6]  = { itemID = 239664, name = "Arcanoweave Cord",                   source = "Crafted"                         }, -- Waist
            [7]  = { itemID = 250050, name = "Blind Oath's Leggings",              source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 258584, name = "Lightbinder Treads",                 source = "Skyreach"                        }, -- Feet
            [9]  = { itemID = 249315, name = "Voracious Wristwraps",               source = "Vorasius"                        }, -- Wrist
            [10] = { itemID = 250052, name = "Blind Oath's Touch",                 source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                    source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 251093, name = "Omission of Light",                  source = "Nexus Point Xenas"               }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249346, name = "Vaelgor's Final Stare",              source = "Vaelgor & Ezzorak · Voidspire"   }, -- Trinket 2
            [15] = { itemID = 249370, name = "Draconic Nullcape",                  source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 251111, name = "Splitshroud Stinger",                source = "Mythic+"                         }, -- Main Hand (M+)
            [17] = { itemID = 245769, name = "Aln'hara Lantern",                   source = "Crafted"                         }, -- Off Hand
        },
    },
}
