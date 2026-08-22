-- BiS data: Holy Priest — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/priest/holy/bis-gear
-- Source: https://www.wowhead.com/guide/classes/priest/holy/stat-priority-pve-healer
-- Last updated: 2026-08-21

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["PRIEST_HOLY"] = {
    label = "Holy Priest",
    class = "PRIEST",
    spec  = "Holy",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Mastery", op = "="  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Haste", op = nil  , r = 1.00, g = 0.82, b = 0.20 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Versatility", op = ">"  , r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
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
            [1]= { itemID = 271874, name = "Venomkeeper's Horrific Cowl",      source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271553, name = "Cosmic Penitent's Echoing Screams",source = "Mor'zahi"                          }, -- Shoulder
            [5]= { itemID = 271558, name = "Cosmic Penitent's Eclipsing Robes",source = "Nymrissa Wavecaller"               }, -- Chest
            [6]= { itemID = 239649, name = "Martyr's Waistwrap",               source = "Crafting"                          }, -- Waist
            [7]= { itemID = 271554, name = "Enveloping Legwraps of the Cosmic Penitent",source = "Kings' Rest"                       }, -- Legs
            [8]= { itemID = 268218, name = "Nek'zali's Spiritwalkers",         source = "Nek'zali the Soulcoiler"           }, -- Feet
            [9]= { itemID = 239648, name = "Martyr's Bindings",                source = "Crafting"                          }, -- Wrist
            [10]= { itemID = 271556, name = "Cosmic Penitent's Celestial Grips",source = "Breath of Ula'tek"                 }, -- Hands
            [11]= { itemID = 268252, name = "Apex Brute's Claw Ring",           source = "Sszorak"                           }, -- Ring 1
            [12]= { itemID = 251148, name = "Pilfered Precious Band",           source = "Den of Nalorakk"                   }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "Mor'zahi"                          }, -- Trinket 1
            [14]= { itemID = 270162, name = "Soulcoiler Ritual Vessel",         source = "Nek'zali the Soulcoiler"           }, -- Trinket 2
            [15]= { itemID = 251132, name = "Speakeasy Shroud",                 source = "Murder Row"                        }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 268263, name = "Frostscale's Mystic Frond",        source = "Nymrissa Wavecaller"               }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271874, name = "Venomkeeper's Horrific Cowl",      source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 271553, name = "Cosmic Penitent's Echoing Screams",source = "Mor'zahi"                          }, -- Shoulder
            [5]= { itemID = 271558, name = "Cosmic Penitent's Eclipsing Robes",source = "Nymrissa Wavecaller"               }, -- Chest
            [6]= { itemID = 239649, name = "Martyr's Waistwrap",               source = "Crafting"                          }, -- Waist
            [7]= { itemID = 271554, name = "Enveloping Legwraps of the Cosmic Penitent",source = "Kings' Rest"                       }, -- Legs
            [8]= { itemID = 268218, name = "Nek'zali's Spiritwalkers",         source = "Nek'zali the Soulcoiler"           }, -- Feet
            [9]= { itemID = 239648, name = "Martyr's Bindings",                source = "Crafting"                          }, -- Wrist
            [10]= { itemID = 271556, name = "Cosmic Penitent's Celestial Grips",source = "Breath of Ula'tek"                 }, -- Hands
            [11]= { itemID = 268252, name = "Apex Brute's Claw Ring",           source = "Sszorak"                           }, -- Ring 1
            [12]= { itemID = 251148, name = "Pilfered Precious Band",           source = "Den of Nalorakk"                   }, -- Ring 2
            [13]= { itemID = 270164, name = "Gebbo's Bottomless Bag",           source = "Mor'zahi"                          }, -- Trinket 1
            [14]= { itemID = 270162, name = "Soulcoiler Ritual Vessel",         source = "Nek'zali the Soulcoiler"           }, -- Trinket 2
            [15]= { itemID = 251132, name = "Speakeasy Shroud",                 source = "Murder Row"                        }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 268263, name = "Frostscale's Mystic Frond",        source = "Nymrissa Wavecaller"               }, -- Off Hand
        },
    },
}
