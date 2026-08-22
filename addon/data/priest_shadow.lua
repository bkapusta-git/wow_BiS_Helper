-- BiS data: Shadow Priest — Midnight Season 2
-- Source: https://www.wowhead.com/guide/classes/priest/shadow/bis-gear
-- Source: https://www.wowhead.com/guide/classes/priest/shadow/stat-priority-pve-dps
-- Last updated: 2026-08-21

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["PRIEST_SHADOW"] = {
    label = "Shadow Priest",
    class = "PRIEST",
    spec  = "Shadow",

    statPriority = {
        raid = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility", op = nil  , r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Parsed from Wowhead stats guide",
            stats = {
                { name = "Haste", op = ">"  , r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery", op = ">"  , r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">"  , r = 1.00, g = 0.35, b = 0.35 },
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
            [1]= { itemID = 271555, name = "Cosmic Penitent's Truesight",      source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 239045, name = "Mantle of Ceremonial Ascension",   source = "King's Rest"                       }, -- Shoulder
            [5]= { itemID = 271558, name = "Cosmic Penitent's Eclipsing Robes",source = "Vashnik the Malignant"             }, -- Chest
            [6]= { itemID = 239649, name = "Martyr's Waistwrap",               source = "Crafting/Misc"                     }, -- Waist
            [7]= { itemID = 271554, name = "Enveloping Legwraps of the Cosmic Penitent",source = "Den of Nalorakk"                   }, -- Legs
            [8]= { itemID = 268255, name = "Cackling Soultreads",              source = "The Coiled Altar"                  }, -- Feet
            [9]= { itemID = 239648, name = "Martyr's Bindings",                source = "Crafting/Misc"                     }, -- Wrist
            [10]= { itemID = 271556, name = "Cosmic Penitent's Celestial Grips",source = "The Coiled Altar"                  }, -- Hands
            [11]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 1
            [12]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 2
            [13]= { itemID = 270167, name = "Wavecaller's Seastone",            source = "Nymrissa Wavecaller"               }, -- Trinket 1
            [14]= { itemID = 250215, name = "Freightrunner's Flask",            source = "Murder Row"                        }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 268197, name = "Spine of the Hissing Abyss",       source = "Entombed Sentinels"                }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        mythicplus = {
            [1]= { itemID = 271555, name = "Cosmic Penitent's Truesight",      source = "Ula'tek"                           }, -- Head
            [2]= { itemID = 268265, name = "Aqirbane Reliquary",               source = "Ula'tek"                           }, -- Neck
            [3]= { itemID = 239045, name = "Mantle of Ceremonial Ascension",   source = "King's Rest"                       }, -- Shoulder
            [5]= { itemID = 271558, name = "Cosmic Penitent's Eclipsing Robes",source = "Vashnik the Malignant"             }, -- Chest
            [6]= { itemID = 239649, name = "Martyr's Waistwrap",               source = "Crafting/Misc"                     }, -- Waist
            [7]= { itemID = 271554, name = "Enveloping Legwraps of the Cosmic Penitent",source = "Den of Nalorakk"                   }, -- Legs
            [8]= { itemID = 268255, name = "Cackling Soultreads",              source = "The Coiled Altar"                  }, -- Feet
            [9]= { itemID = 239648, name = "Martyr's Bindings",                source = "Crafting/Misc"                     }, -- Wrist
            [10]= { itemID = 271556, name = "Cosmic Penitent's Celestial Grips",source = "The Coiled Altar"                  }, -- Hands
            [11]= { itemID = 252258, name = "Sickening Signet of Atroxus",      source = "Voidscar Arena"                    }, -- Ring 1
            [12]= { itemID = 268249, name = "Vile Alchemist's Band",            source = "Vashnik the Malignant"             }, -- Ring 2
            [13]= { itemID = 270167, name = "Wavecaller's Seastone",            source = "Nymrissa Wavecaller"               }, -- Trinket 1
            [14]= { itemID = 250215, name = "Freightrunner's Flask",            source = "Murder Row"                        }, -- Trinket 2
            [15]= { itemID = 268253, name = "Silken Voodoo Drape",              source = "The Coiled Altar"                  }, -- Back
            [16]= { itemID = 271092, name = "Jan'thrazet, the Soul Fang",       source = "Ula'tek"                           }, -- Main Hand
            [17]= { itemID = 268197, name = "Spine of the Hissing Abyss",       source = "Entombed Sentinels"                }, -- Off Hand
        },
    },
}
