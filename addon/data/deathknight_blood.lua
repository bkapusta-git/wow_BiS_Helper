-- BiS data: Blood Death Knight — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/death-knight/blood/bis-gear
-- Source: https://www.wowhead.com/guide/classes/death-knight/blood/stat-priority-pve-tank
-- Last updated: 2026-08-12

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DEATHKNIGHT_BLOOD"] = {
    label = "Blood Death Knight",
    class = "DEATHKNIGHT",
    spec  = "Blood",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = "="  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = "="  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = "="  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = "="  , r = 1.00, g = 0.35, b = 0.35 },
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
            [1]= { itemID = 271474, name = "Baleful Grave-Knight's Casque",    source = "Nek'zali the Soulcoiler"           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271472, name = "Baleful Grave-Knight's Gibbets",   source = "Temple of Sethraliss"              }, -- Shoulder
            [5]= { itemID = 271477, name = "Baleful Grave-Knight's Breastplate",source = "The Coiled Altar"                  }, -- Chest
            [6]= { itemID = 268259, name = "Girdle of Toxic Regret",           source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271878, name = "Chausses of Unbound Rancor",       source = "Ula'tek"                           }, -- Legs
            [8]= { itemID = 273777, name = "Poison-Proof Stompers",            source = "Altar of Fangs"                    }, -- Feet
            [9]= { itemID = 237834, name = "Spellbreaker's Bracers",           source = "Crafting"                          }, -- Wrist
            [10]= { itemID = 271475, name = "Baleful Grave-Knight's Deathgrips",source = "King's Rest"                       }, -- Hands
            [11]= { itemID = 240949, name = "Masterwork Sin'dorei Band",        source = "Crafting"                          }, -- Ring 1
            [12]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 2
            [13]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 1
            [14]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268213, name = "Maze-roa, Warlord's Fury",         source = "The Coiled Altar"                  }, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271474, name = "Baleful Grave-Knight's Casque",    source = "Nek'zali the Soulcoiler"           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271472, name = "Baleful Grave-Knight's Gibbets",   source = "Temple of Sethraliss"              }, -- Shoulder
            [5]= { itemID = 271477, name = "Baleful Grave-Knight's Breastplate",source = "The Coiled Altar"                  }, -- Chest
            [6]= { itemID = 268259, name = "Girdle of Toxic Regret",           source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271878, name = "Chausses of Unbound Rancor",       source = "Ula'tek"                           }, -- Legs
            [8]= { itemID = 273777, name = "Poison-Proof Stompers",            source = "Altar of Fangs"                    }, -- Feet
            [9]= { itemID = 237834, name = "Spellbreaker's Bracers",           source = "Crafting"                          }, -- Wrist
            [10]= { itemID = 271475, name = "Baleful Grave-Knight's Deathgrips",source = "King's Rest"                       }, -- Hands
            [11]= { itemID = 240949, name = "Masterwork Sin'dorei Band",        source = "Crafting"                          }, -- Ring 1
            [12]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 2
            [13]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 1
            [14]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268213, name = "Maze-roa, Warlord's Fury",         source = "The Coiled Altar"                  }, -- Main Hand
        },
    },
}
