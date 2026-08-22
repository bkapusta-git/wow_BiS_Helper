-- BiS data: Brewmaster Monk — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/monk/brewmaster/bis-gear
-- Source: https://www.wowhead.com/guide/classes/monk/brewmaster/stat-priority-pve-tank
-- Last updated: 2026-08-21

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["MONK_BREWMASTER"] = {
    label = "Brewmaster Monk",
    class = "MONK",
    spec  = "Brewmaster",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = "="  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = "="  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Haste", op = nil  , r = 1.00, g = 0.82, b = 0.20 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Mastery", op = "="  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = "="  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Haste", op = nil  , r = 1.00, g = 0.82, b = 0.20 },
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
            [1]= { itemID = 271519, name = "Monkey King's Unyielding Visage",  source = "Catalyst / Raid / Vault"           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271517, name = "Tassels of the Monkey King",       source = "Catalyst / Mythic+ / Vault"        }, -- Shoulder
            [5]= { itemID = 271522, name = "Battle Gi of the Monkey King",     source = "Catalyst / Mythic+ / Vault"        }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271518, name = "Pantaloons of the Monkey King",    source = "Catalyst / Raid / Vault"           }, -- Legs
            [8]= { itemID = 159304, name = "Goldfeather Boots",                source = "Kings' Rest"                       }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Leatherworking"                    }, -- Wrist
            [10]= { itemID = 271520, name = "Monkey King's Fighting Fists",     source = "Catalyst / Mythic+ / Vault"        }, -- Hands
            [11]= { itemID = 251148, name = "Pilfered Precious Band",           source = "Den of Nalorakk"                   }, -- Ring 1
            [12]= { itemID = 251513, name = "Loa Worshiper's Band",             source = "Jewelcrafting"                     }, -- Ring 2
            [13]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 1
            [14]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268215, name = "Abyssal Broodfiend's Bardiche",    source = "Ula'tek"                           }, -- Main Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271519, name = "Monkey King's Unyielding Visage",  source = "Catalyst / Raid / Vault"           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271517, name = "Tassels of the Monkey King",       source = "Catalyst / Mythic+ / Vault"        }, -- Shoulder
            [5]= { itemID = 271522, name = "Battle Gi of the Monkey King",     source = "Catalyst / Mythic+ / Vault"        }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271518, name = "Pantaloons of the Monkey King",    source = "Catalyst / Raid / Vault"           }, -- Legs
            [8]= { itemID = 159304, name = "Goldfeather Boots",                source = "Kings' Rest"                       }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Leatherworking"                    }, -- Wrist
            [10]= { itemID = 271520, name = "Monkey King's Fighting Fists",     source = "Catalyst / Mythic+ / Vault"        }, -- Hands
            [11]= { itemID = 251148, name = "Pilfered Precious Band",           source = "Den of Nalorakk"                   }, -- Ring 1
            [12]= { itemID = 251513, name = "Loa Worshiper's Band",             source = "Jewelcrafting"                     }, -- Ring 2
            [13]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 1
            [14]= { itemID = 270173, name = "Zul'jin's Guillotine Technique",   source = "The Coiled Altar"                  }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268215, name = "Abyssal Broodfiend's Bardiche",    source = "Ula'tek"                           }, -- Main Hand
        },
    },
}
