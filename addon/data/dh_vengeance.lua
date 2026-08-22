-- BiS data: Vengeance Demon Hunter — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/demon-hunter/vengeance/bis-gear
-- Source: https://www.wowhead.com/guide/classes/demon-hunter/vengeance/stat-priority-pve-tank
-- Last updated: 2026-08-12

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
            [1]= { itemID = 271537, name = "Abyssal Doomhound's Relentless Stare",source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271535, name = "Abyssal Doomhound's Jaws",         source = "Voidscar Arena"                    }, -- Shoulder
            [5]= { itemID = 271540, name = "Abyssal Doomhound's Coreguard",    source = "Vashnik the Malignant"             }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271536, name = "Abyssal Doomhound's Legwraps",     source = "The Coiled Altar"                  }, -- Legs
            [8]= { itemID = 251153, name = "Arctic Explorer's Legwraps",       source = "Den of Nalorakk"                   }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 271538, name = "Abyssal Doomhound's Studded Gauntlets",source = "Murder Row"                        }, -- Hands
            [11]= { itemID = 268252, name = "Apex Brute's Claw Ring",           source = "Sszorak"                           }, -- Ring 1
            [12]= { itemID = 159459, name = "Ritual Binder's Ring",             source = "King's Rest"                       }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 1
            [14]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268209, name = "Aman'muso, Warlord's Vengeance",   source = "The Coiled Altar"                  }, -- Main Hand
            [17]= { itemID = 237840, name = "Spellbreaker's Warglaive",         source = "Crafted"                           }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271537, name = "Abyssal Doomhound's Relentless Stare",source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271535, name = "Abyssal Doomhound's Jaws",         source = "Voidscar Arena"                    }, -- Shoulder
            [5]= { itemID = 271540, name = "Abyssal Doomhound's Coreguard",    source = "Vashnik the Malignant"             }, -- Chest
            [6]= { itemID = 268256, name = "Sash of the Forlorn Vessel",       source = "The Coiled Altar"                  }, -- Waist
            [7]= { itemID = 271536, name = "Abyssal Doomhound's Legwraps",     source = "The Coiled Altar"                  }, -- Legs
            [8]= { itemID = 251153, name = "Arctic Explorer's Legwraps",       source = "Den of Nalorakk"                   }, -- Feet
            [9]= { itemID = 244576, name = "Silvermoon Agent's Deflectors",    source = "Crafted"                           }, -- Wrist
            [10]= { itemID = 271538, name = "Abyssal Doomhound's Studded Gauntlets",source = "Murder Row"                        }, -- Hands
            [11]= { itemID = 268252, name = "Apex Brute's Claw Ring",           source = "Sszorak"                           }, -- Ring 1
            [12]= { itemID = 159459, name = "Ritual Binder's Ring",             source = "King's Rest"                       }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "The Lost Explorers"                }, -- Trinket 1
            [14]= { itemID = 270175, name = "Voracious Heart of Ula'tek",       source = "Ula'tek"                           }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 268209, name = "Aman'muso, Warlord's Vengeance",   source = "The Coiled Altar"                  }, -- Main Hand
            [17]= { itemID = 237840, name = "Spellbreaker's Warglaive",         source = "Crafted"                           }, -- Off Hand
        },
    },
}
