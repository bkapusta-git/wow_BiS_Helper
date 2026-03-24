-- BiS data: Devourer Demon Hunter — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/demon-hunter/devourer/bis-gear
--         https://www.wowhead.com/guide/classes/demon-hunter/devourer/stat-priority-pve-dps
-- Last updated: 2026-03-24

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DEMONHUNTER_DEVOURER"] = {
    label = "Devourer Demon Hunter",
    class = "DEMONHUNTER",
    spec  = "Devourer",

    -- Stat priority per content type — source: wowhead.com/guide/.../stat-priority-pve-dps
    -- op = operator AFTER this stat (nil = last in chain)
    -- Collapsing Star always crits in Midnight → Crit loses value
    -- Mastery doubles in value during Void Metamorphosis
    statPriority = {
        raid = {
            note  = "Annihilator: Haste >= Mastery  |  Void-Scarred: Mastery >= Haste",
            stats = {
                { name = "Haste",           op = ">=",  r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">>>", r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "AoE: Mastery increases in value above Haste",
            stats = {
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">>>", r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        -- Diminishing returns thresholds (Midnight)
        dr = {
            { name = "Haste",           rating = 1320, r = 1.00, g = 0.82, b = 0.20 },
            { name = "Crit / Mastery",  rating = 1380, r = 1.00, g = 0.60, b = 0.30 },
            { name = "Versatility",     rating = 1620, r = 0.65, g = 0.40, b = 1.00 },
        },
    },

    content = {
        -- ── Raid BiS ────────────────────────────────────────
        raid = {
            [1]  = { itemID = 250033, name = "Devouring Reaver's Intake",          source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 249368, name = "Eternal Voidsong Chain",             source = "Crown of the Cosmos · Voidspire"  }, -- Neck
            [3]  = { itemID = 250031, name = "Devouring Reaver's Exhaustplates",   source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250036, name = "Devouring Reaver's Engine",          source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 244573, name = "Silvermoon Agent's Utility Belt",    source = "Crafted"                         }, -- Waist
            [7]  = { itemID = 49817,  name = "Shaggy Wyrmleather Leggings",        source = "Pit of Saron"                    }, -- Legs
            [8]  = { itemID = 250035, name = "Devouring Reaver's Soul Flatteners", source = "Catalyst"                        }, -- Feet
            [9]  = { itemID = 193714, name = "Frenzyroot Cuffs",                   source = "Algeth'ar Academy"               }, -- Wrist
            [10] = { itemID = 250034, name = "Devouring Reaver's Essence Grips",   source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249369, name = "Bond of Light",                      source = "Lightblinded Vanguard · Voidspire"}, -- Ring 1
            [12] = { itemID = 249920, name = "Eye of Midnight",                    source = "Midnight Falls"                  }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249346, name = "Vaelgor's Final Stare",              source = "Vaelgor & Ezzorak · Voidspire"   }, -- Trinket 2
            [15] = { itemID = 249370, name = "Draconic Nullcape",                  source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 260408, name = "Lightless Lament",                   source = "Midnight Falls"                  }, -- Main Hand
            [17] = { itemID = 237840, name = "Spellbreaker's Warglaive",           source = "Crafted"                         }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Differences: Trinket 1, Trinket 2
        mythicplus = {
            [1]  = { itemID = 250033, name = "Devouring Reaver's Intake",          source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 249368, name = "Eternal Voidsong Chain",             source = "Crown of the Cosmos · Voidspire"  }, -- Neck
            [3]  = { itemID = 250031, name = "Devouring Reaver's Exhaustplates",   source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 250036, name = "Devouring Reaver's Engine",          source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 244573, name = "Silvermoon Agent's Utility Belt",    source = "Crafted"                         }, -- Waist
            [7]  = { itemID = 49817,  name = "Shaggy Wyrmleather Leggings",        source = "Pit of Saron"                    }, -- Legs
            [8]  = { itemID = 250035, name = "Devouring Reaver's Soul Flatteners", source = "Catalyst"                        }, -- Feet
            [9]  = { itemID = 193714, name = "Frenzyroot Cuffs",                   source = "Algeth'ar Academy"               }, -- Wrist
            [10] = { itemID = 250034, name = "Devouring Reaver's Essence Grips",   source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249369, name = "Bond of Light",                      source = "Lightblinded Vanguard · Voidspire"}, -- Ring 1
            [12] = { itemID = 249920, name = "Eye of Midnight",                    source = "Midnight Falls"                  }, -- Ring 2
            [13] = { itemID = 250144, name = "Emberwing Feather",                  source = "Emberdawn"                       }, -- Trinket 1 (M+)
            [14] = { itemID = 250256, name = "Heart of Wind",                      source = "Restless Heart"                  }, -- Trinket 2 (M+)
            [15] = { itemID = 249370, name = "Draconic Nullcape",                  source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 260408, name = "Lightless Lament",                   source = "Midnight Falls"                  }, -- Main Hand
            [17] = { itemID = 237840, name = "Spellbreaker's Warglaive",           source = "Crafted"                         }, -- Off Hand
        },
    },
}
