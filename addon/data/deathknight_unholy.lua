-- BiS data: Unholy Death Knight — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/death-knight/unholy/bis-gear
-- Source: https://www.wowhead.com/guide/classes/death-knight/unholy/stat-priority-pve-dps
-- Last updated: 2026-08-12

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DEATHKNIGHT_UNHOLY"] = {
    label = "Unholy Death Knight",
    class = "DEATHKNIGHT",
    spec  = "Unholy",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
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
            [1]= { itemID = 271474, name = "Baleful Grave-Knight's Casque",    source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271472, name = "Baleful Grave-Knight's Gibbets",   source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 271477, name = "Baleful Grave-Knight's Breastplate",source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268259, name = "Girdle of Toxic Regret",           source = "Ula'tek"                           }, -- Waist
            [7]= { itemID = 271878, name = "Chausses of Unbound Rancor",       source = "Ula'tek"                           }, -- Legs
            [8]= { itemID = 237828, name = "Spellbreaker's March",             source = "Crafting"                          }, -- Feet
            [9]= { itemID = 237834, name = "Spellbreaker's Bracers",           source = "Crafting"                          }, -- Wrist
            [10]= { itemID = 271475, name = "Baleful Grave-Knight's Deathgrips",source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 273792, name = "Band of the Amani Warlord",        source = "Altar of Fangs"                    }, -- Ring 1
            [12]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 2
            [13]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 1
            [14]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268213, name = "Maze-roa, Warlord's Fury",         source = "Ula'tek"                           }, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271474, name = "Baleful Grave-Knight's Casque",    source = "Tier Set"                          }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271472, name = "Baleful Grave-Knight's Gibbets",   source = "Tier Set"                          }, -- Shoulder
            [5]= { itemID = 271477, name = "Baleful Grave-Knight's Breastplate",source = "Tier Set"                          }, -- Chest
            [6]= { itemID = 268259, name = "Girdle of Toxic Regret",           source = "Ula'tek"                           }, -- Waist
            [7]= { itemID = 271878, name = "Chausses of Unbound Rancor",       source = "Ula'tek"                           }, -- Legs
            [8]= { itemID = 237828, name = "Spellbreaker's March",             source = "Crafting"                          }, -- Feet
            [9]= { itemID = 237834, name = "Spellbreaker's Bracers",           source = "Crafting"                          }, -- Wrist
            [10]= { itemID = 271475, name = "Baleful Grave-Knight's Deathgrips",source = "Tier Set"                          }, -- Hands
            [11]= { itemID = 273792, name = "Band of the Amani Warlord",        source = "Altar of Fangs"                    }, -- Ring 1
            [12]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 2
            [13]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 1
            [14]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268213, name = "Maze-roa, Warlord's Fury",         source = "Ula'tek"                           }, -- Main Hand
        },
    },
}
