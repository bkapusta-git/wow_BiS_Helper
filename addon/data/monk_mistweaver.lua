-- BiS data: Mistweaver Monk — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/monk/mistweaver/bis-gear
-- Source: https://www.wowhead.com/guide/classes/monk/mistweaver/stat-priority-pve-healer
-- Last updated: 2026-07-04

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["MONK_MISTWEAVER"] = {
    label = "Mistweaver Monk",
    class = "MONK",
    spec  = "Mistweaver",

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
            [2]= { itemID = 50228, name = "Barbed Ymirheim Choker",            source = "Pit of Saron"                      }, -- Neck
            [3]= { itemID = 249333, name = "Blooming Barklight Spaulders",     source = "Lightblinded Vanguard · The Voidspire"}, -- Shoulder
            [5]= { itemID = 250018, name = "Battle Garb of Ra-den's Chosen",   source = "Raid | Catalyst | Vault"           }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Rotmire (Raid)"                    }, -- Waist
            [7]= { itemID = 250014, name = "Swiftsweepers of Ra-den's Chosen", source = "Raid | Catalyst | Vault"           }, -- Legs
            [8]= { itemID = 250017, name = "Storm Crashers of Ra-den's Chosen",source = "Catalyst"                          }, -- Feet
            [9]= { itemID = 50264, name = "Chewed Leather Wristguards",        source = "Pit of Saron"                      }, -- Wrist
            [10]= { itemID = 250016, name = "Thunderfists of Ra-den's Chosen",  source = "Raid | Catalyst | Vault"           }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Rotmire (Raid)"                    }, -- Ring 1
            [12]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls (Raid)"             }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 249808, name = "Litany of Lightblind Wrath",       source = "Lightblinded Vanguard · The Voidspire"}, -- Trinket 2
            [16]= { itemID = 258050, name = "Arcanic of the High Sage",         source = "Skyreach"                          }, -- Main Hand
            [17]= { itemID = 249276, name = "Grimoire of the Eternal Light",    source = "Vorasius · The Voidspire"          }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [2]= { itemID = 50228, name = "Barbed Ymirheim Choker",            source = "Pit of Saron"                      }, -- Neck
            [3]= { itemID = 249333, name = "Blooming Barklight Spaulders",     source = "Lightblinded Vanguard · The Voidspire"}, -- Shoulder
            [5]= { itemID = 250018, name = "Battle Garb of Ra-den's Chosen",   source = "Raid | Catalyst | Vault"           }, -- Chest
            [6]= { itemID = 268286, name = "Sash of the Putrid Giant",         source = "Rotmire (Raid)"                    }, -- Waist
            [7]= { itemID = 250014, name = "Swiftsweepers of Ra-den's Chosen", source = "Raid | Catalyst | Vault"           }, -- Legs
            [8]= { itemID = 250017, name = "Storm Crashers of Ra-den's Chosen",source = "Catalyst"                          }, -- Feet
            [9]= { itemID = 50264, name = "Chewed Leather Wristguards",        source = "Pit of Saron"                      }, -- Wrist
            [10]= { itemID = 250016, name = "Thunderfists of Ra-den's Chosen",  source = "Raid | Catalyst | Vault"           }, -- Hands
            [11]= { itemID = 268290, name = "Sporecaller's Blooming Loop",      source = "Rotmire (Raid)"                    }, -- Ring 1
            [12]= { itemID = 249920, name = "Eye of Midnight",                  source = "Midnight Falls (Raid)"             }, -- Ring 2
            [13]= { itemID = 249343, name = "Gaze of the Alnseer",              source = "Chimaerus the Undreamt God · The Dreamrift"}, -- Trinket 1
            [14]= { itemID = 249808, name = "Litany of Lightblind Wrath",       source = "Lightblinded Vanguard · The Voidspire"}, -- Trinket 2
            [16]= { itemID = 258050, name = "Arcanic of the High Sage",         source = "Skyreach"                          }, -- Main Hand
            [17]= { itemID = 249276, name = "Grimoire of the Eternal Light",    source = "Vorasius · The Voidspire"          }, -- Off Hand
        },
    },
}
