-- BiS data: Restoration Druid — Midnight Season 1
-- Source: https://www.wowhead.com/guide/classes/druid/restoration/bis-gear
--         https://www.wowhead.com/guide/classes/druid/restoration/stat-priority-pve-healer
-- Last updated: 2026-03-14

BiSHelper_Data = BiSHelper_Data or {}

BiSHelper_Data["DRUID_RESTORATION"] = {
    label = "Restoration Druid",
    class = "DRUID",
    spec  = "Restoration",

    -- Keeper of the Grove & Wildstalker: identical priority
    statPriority = {
        raid = {
            note  = "Keeper & Wildstalker: identical. Haste boosts HoT ticks and cast speed",
            stats = {
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = nil,   r = 1.00, g = 0.35, b = 0.35 },
            },
        },
        mythicplus = {
            note  = "Same as Raid; very high keys may favor more Versatility",
            stats = {
                { name = "Haste",           op = ">",   r = 1.00, g = 0.82, b = 0.20 },
                { name = "Mastery",         op = ">",   r = 0.30, g = 0.75, b = 1.00 },
                { name = "Versatility",     op = ">",   r = 0.65, g = 0.40, b = 1.00 },
                { name = "Critical Strike", op = nil,   r = 1.00, g = 0.35, b = 0.35 },
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
        raid = {
            [1]  = { itemID = 250024, name = "Branches of the Luminous Bloom",    source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",         source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 250022, name = "Seedpods of the Luminous Bloom",     source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 251216, name = "Maledict Vest",                      source = "Nexus Point Xenas"               }, -- Chest
            [6]  = { itemID = 249314, name = "Twisted Twilight Sash",              source = "Vorasius"                        }, -- Waist
            [7]  = { itemID = 250023, name = "Phloemwraps of the Luminous Bloom",  source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 251210, name = "Eclipse Espadrilles",                source = "Nexus Point Xenas"               }, -- Feet
            [9]  = { itemID = 193714, name = "Frenzyroot Cuffs",                   source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 250025, name = "Arbortenders of the Luminous Bloom", source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                    source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 251115, name = "Bifurcation Band",                   source = "Magister's Terrace"              }, -- Ring 2
            [13] = { itemID = 249809, name = "Locus-Walker's Ribbon",              source = "Crown of the Cosmos · Voidspire" }, -- Trinket 1
            [14] = { itemID = 249346, name = "Vaelgor's Final Stare",              source = "Vaelgor & Ezzorak · Voidspire"   }, -- Trinket 2
            [15] = { itemID = 249370, name = "Draconic Nullcape",                  source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 249283, name = "Belo'melorn, the Shattered Talon",   source = "Belo'ren"                        }, -- Main Hand
            [17] = { itemID = 249922, name = "Tome of Alnscorned Regret",          source = "Chimaerus · The Dreamrift"       }, -- Off Hand
        },

        -- ── Mythic+ BiS ──────────────────────────────────────
        -- No full M+ list from Wowhead; same as Raid
        mythicplus = {
            [1]  = { itemID = 250024, name = "Branches of the Luminous Bloom",    source = "Tier Set"                        }, -- Head
            [2]  = { itemID = 250247, name = "Amulet of the Abyssal Hymn",         source = "Midnight Falls"                  }, -- Neck
            [3]  = { itemID = 250022, name = "Seedpods of the Luminous Bloom",     source = "Tier Set"                        }, -- Shoulder
            [5]  = { itemID = 251216, name = "Maledict Vest",                      source = "Nexus Point Xenas"               }, -- Chest
            [6]  = { itemID = 249314, name = "Twisted Twilight Sash",              source = "Vorasius"                        }, -- Waist
            [7]  = { itemID = 250023, name = "Phloemwraps of the Luminous Bloom",  source = "Tier Set"                        }, -- Legs
            [8]  = { itemID = 251210, name = "Eclipse Espadrilles",                source = "Nexus Point Xenas"               }, -- Feet
            [9]  = { itemID = 193714, name = "Frenzyroot Cuffs",                   source = "Crafted"                         }, -- Wrist
            [10] = { itemID = 250025, name = "Arbortenders of the Luminous Bloom", source = "Tier Set"                        }, -- Hands
            [11] = { itemID = 249920, name = "Eye of Midnight",                    source = "Midnight Falls"                  }, -- Ring 1
            [12] = { itemID = 251115, name = "Bifurcation Band",                   source = "Magister's Terrace"              }, -- Ring 2
            [13] = { itemID = 249809, name = "Locus-Walker's Ribbon",              source = "Crown of the Cosmos · Voidspire" }, -- Trinket 1
            [14] = { itemID = 249346, name = "Vaelgor's Final Stare",              source = "Vaelgor & Ezzorak · Voidspire"   }, -- Trinket 2
            [15] = { itemID = 249370, name = "Draconic Nullcape",                  source = "Vaelgor & Ezzorak · Voidspire"   }, -- Back
            [16] = { itemID = 249283, name = "Belo'melorn, the Shattered Talon",   source = "Belo'ren"                        }, -- Main Hand
            [17] = { itemID = 249922, name = "Tome of Alnscorned Regret",          source = "Chimaerus · The Dreamrift"       }, -- Off Hand
        },
    },
}
