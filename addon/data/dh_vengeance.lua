-- BiS data: Vengeance Demon Hunter — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/demon-hunter/vengeance/bis-gear
-- Source: https://www.wowhead.com/guide/classes/demon-hunter/vengeance/stat-priority-pve-tank
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DEMONHUNTER_VENGEANCE"] = {
    label = "Vengeance Demon Hunter",
    class = "DEMONHUNTER",
    spec  = "Vengeance",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Mastery", op = nil  , r = 0.30, g = 0.75, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Mastery", op = nil  , r = 0.30, g = 0.75, b = 1.00 },
            },
        },
        dr = {
            { name = "Haste", rating = 1320, r = 1.00, g = 0.82, b = 0.20 },
            { name = "Crit / Mastery", rating = 1380, r = 1.00, g = 0.60, b = 0.30 },
            { name = "Versatility", rating = 1620, r = 0.65, g = 0.40, b = 1.00 },
        },
    },

    content = {
        -- ── Raid BiS ────────────────────────────────────────
        raid = {
            [1]= { itemID = 268283, name = "Festerbloom Crown",                source = "Tier Set"                          }, -- Head
            [2]= { itemID = 151309, name = "Necklace of the Twisting Void",    source = "Seat of the Triumvirate"           }, -- Neck
            [3]= { itemID = 250031, name = "Devouring Reaver's Exhaustplates", source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 151313, name = "Vest of the Void's Embrace",       source = "Seat of the Triumvirate"           }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Tier Set"                          }, -- Waist
            [7]= { itemID = 250032, name = "Devouring Reaver's Pistons",       source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 251210, name = "Eclipse Espadrilles",              source = "Nexus-Point Xenas"                 }, -- Feet
            [9]= { itemID = 50264, name = "Chewed Leather Wristguards",        source = "Pit of Saron"                      }, -- Wrist
            [10]= { itemID = 250034, name = "Devouring Reaver's Essence Grips", source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls"                    }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 268292, name = "Sporelord's Mycelial Insignia",    source = "Sporefall"                         }, -- Trinket 2
            [15]= { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Crafted"                           }, -- Back
            [16]= { itemID = 260408, name = "Lightless Lament",                 source = "Midnight Falls"                    }, -- Main Hand
            [17]= { itemID = 249298, name = "Tormentor's Bladed Fists",         source = "Fallen-King Salhadaar · The Voidspire"}, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 268283, name = "Festerbloom Crown",                source = "Tier Set"                          }, -- Head
            [2]= { itemID = 151309, name = "Necklace of the Twisting Void",    source = "Seat of the Triumvirate"           }, -- Neck
            [3]= { itemID = 250031, name = "Devouring Reaver's Exhaustplates", source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 151313, name = "Vest of the Void's Embrace",       source = "Seat of the Triumvirate"           }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Tier Set"                          }, -- Waist
            [7]= { itemID = 250032, name = "Devouring Reaver's Pistons",       source = "Tier Set"                          }, -- Legs
            [8]= { itemID = 251210, name = "Eclipse Espadrilles",              source = "Nexus-Point Xenas"                 }, -- Feet
            [9]= { itemID = 50264, name = "Chewed Leather Wristguards",        source = "Pit of Saron"                      }, -- Wrist
            [10]= { itemID = 250034, name = "Devouring Reaver's Essence Grips", source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls"                    }, -- Ring 1
            [12]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Sporefall"                         }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 268292, name = "Sporelord's Mycelial Insignia",    source = "Sporefall"                         }, -- Trinket 2
            [15]= { itemID = 239656, name = "Adherent's Silken Shroud",         source = "Crafted"                           }, -- Back
            [16]= { itemID = 260408, name = "Lightless Lament",                 source = "Midnight Falls"                    }, -- Main Hand
            [17]= { itemID = 249298, name = "Tormentor's Bladed Fists",         source = "Fallen-King Salhadaar · The Voidspire"}, -- Off Hand
        },
    },
}
