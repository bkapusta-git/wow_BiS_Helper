-- BiS data: Destruction Warlock — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/warlock/destruction/bis-gear
--         https://www.wowhead.com/guide/classes/warlock/destruction/stat-priority-pve-dps
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["WARLOCK_DESTRUCTION"] = {
    label = "Destruction Warlock",
    class = "WARLOCK",
    spec  = "Destruction",

    -- Hellcaller & Soul Harvester: Haste > Mastery = Crit > Vers
    statPriority = {
        raid = {
            note  = "Haste > Mastery = Crit > Vers. Both hero talents share identical priority",
            stats = {
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = "=",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
            },
        },
        mythicplus = {
            note  = "Same as Raid",
            stats = {
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = "=",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Critical Strike", op = ">",   r = 1.00, g = 0.35, b = 0.35 },
                { name = "Versatility",     op = nil,   r = 0.65, g = 0.40, b = 1.00 },
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
        -- Destruction uses 1H sword + grimoire offhand
        raid = {
            [1]  = { itemID = 250042, name = "Abyssal Immolator's Smoldering Flames", source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 249368, name = "Eternal Voidsong Chain",                source = "Crown of the Cosmos · Voidspire" }, -- Neck
            [3]  = { itemID = 249328, name = "Echoing Void Mantle",                   source = "Belo'ren"                        }, -- Shoulder
            [5]  = { itemID = 250045, name = "Abyssal Immolator's Dreadrobe",         source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249376, name = "Whisper-Inscribed Sash",                source = "Belo'ren"                        }, -- Waist
            [7]  = { itemID = 250041, name = "Abyssal Immolator's Pillars",           source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249305, name = "Slippers of the Midnight Flame",        source = "Vaelgor & Ezzorak · Voidspire"   }, -- Feet
            [9]  = { itemID = 249315, name = "Voracious Wristwraps",                  source = "Vorasius"                        }, -- Wrist
            [10] = { itemID = 250043, name = "Abyssal Immolator's Grasps",            source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                       source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 241140, name = "Signet of Azerothian Blessings",        source = "Crafted"                         }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                   source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249346, name = "Vaelgor's Final Stare",                 source = "Vaelgor & Ezzorak · Voidspire"   }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",              source = "Crafted"                         }, -- Back
            [16] = { itemID = 249283, name = "Belo'melorn, the Shattered Talon",      source = "Belo'ren"                        }, -- Main Hand
            [17] = { itemID = 249276, name = "Grimoire of the Eternal Light",         source = "Vorasius"                        }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- Same as Raid
        mythicplus = {
            [1]  = { itemID = 250042, name = "Abyssal Immolator's Smoldering Flames", source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 249368, name = "Eternal Voidsong Chain",                source = "Crown of the Cosmos · Voidspire" }, -- Neck
            [3]  = { itemID = 249328, name = "Echoing Void Mantle",                   source = "Belo'ren"                        }, -- Shoulder
            [5]  = { itemID = 250045, name = "Abyssal Immolator's Dreadrobe",         source = "Tier Set"                        }, -- Chest
            [6]  = { itemID = 249376, name = "Whisper-Inscribed Sash",                source = "Belo'ren"                        }, -- Waist
            [7]  = { itemID = 250041, name = "Abyssal Immolator's Pillars",           source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 249305, name = "Slippers of the Midnight Flame",        source = "Vaelgor & Ezzorak · Voidspire"   }, -- Feet
            [9]  = { itemID = 249315, name = "Voracious Wristwraps",                  source = "Vorasius"                        }, -- Wrist
            [10] = { itemID = 250043, name = "Abyssal Immolator's Grasps",            source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                       source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 241140, name = "Signet of Azerothian Blessings",        source = "Crafted"                         }, -- Ring 2
            [13] = { itemID = 249343, name = "Gaze of the Alnseer",                   source = "Chimaerus · The Dreamrift"       }, -- Trinket 1
            [14] = { itemID = 249346, name = "Vaelgor's Final Stare",                 source = "Vaelgor & Ezzorak · Voidspire"   }, -- Trinket 2
            [15] = { itemID = 239656, name = "Adherent's Silken Shroud",              source = "Crafted"                         }, -- Back
            [16] = { itemID = 249283, name = "Belo'melorn, the Shattered Talon",      source = "Belo'ren"                        }, -- Main Hand
            [17] = { itemID = 249276, name = "Grimoire of the Eternal Light",         source = "Vorasius"                        }, -- Off Hand
        },
    },
}
