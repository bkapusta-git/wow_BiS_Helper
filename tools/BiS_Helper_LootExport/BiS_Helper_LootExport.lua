-- BiS_Helper_LootExport: exports current M+ loot from Encounter Journal
-- Usage: /bisexport in-game, then logout. Python parses WTF/Account/.../SavedVariables/

BiSHelperLootExportDB = BiSHelperLootExportDB or {}

local MYTHIC_DIFFICULTY = 23  -- DifficultyID for Mythic 5-man dungeon

-- Slot name from EJ filterType (maps to C_EncounterJournal loot filterType constants)
local SLOT_BY_FILTER = {
    [Enum.ItemSlotFilterType.Head]     = "Head",
    [Enum.ItemSlotFilterType.Neck]     = "Neck",
    [Enum.ItemSlotFilterType.Shoulder] = "Shoulder",
    [Enum.ItemSlotFilterType.Chest]    = "Chest",
    [Enum.ItemSlotFilterType.Waist]    = "Waist",
    [Enum.ItemSlotFilterType.Legs]     = "Legs",
    [Enum.ItemSlotFilterType.Feet]     = "Feet",
    [Enum.ItemSlotFilterType.Wrist]    = "Wrist",
    [Enum.ItemSlotFilterType.Hand]     = "Hands",
    [Enum.ItemSlotFilterType.Finger]   = "Finger",
    [Enum.ItemSlotFilterType.Trinket]  = "Trinket",
    [Enum.ItemSlotFilterType.Back]     = "Back",
    [Enum.ItemSlotFilterType.MainHand] = "Main Hand",
    [Enum.ItemSlotFilterType.OffHand]  = "Off Hand",
    [Enum.ItemSlotFilterType.Other]    = "Other",
}

local function FindJournalInstanceID(dungeonName)
    -- Iterate all EJ tiers to find a matching instance by name
    for tierIdx = 1, EJ_GetNumTiers() do
        EJ_SelectTier(tierIdx)
        local instanceIdx = 1
        while true do
            local id, name = EJ_GetInstanceByIndex(instanceIdx, true)  -- true = dungeon
            if not id then break end
            if name == dungeonName then
                return id
            end
            instanceIdx = instanceIdx + 1
        end
    end
    return nil
end

local function ExportLoot()
    local mapIDs = C_ChallengeMode.GetMapTable()
    if not mapIDs or #mapIDs == 0 then
        print("|cffff0000[LootExport]|r No M+ maps found. Are you logged into a character?")
        return
    end

    EJ_SetDifficulty(MYTHIC_DIFFICULTY)

    local dungeons = {}
    local items = {}
    local seenItems = {}
    local totalItems = 0

    for _, mapID in ipairs(mapIDs) do
        local name = C_ChallengeMode.GetMapUIInfo(mapID)
        if name then
            local journalID = FindJournalInstanceID(name)
            if journalID then
                table.insert(dungeons, name)
                EJ_SelectInstance(journalID)

                local encounterIdx = 1
                while true do
                    local eName, _, eID = EJ_GetEncounterInfoByIndex(encounterIdx)
                    if not eName then break end

                    EJ_SelectEncounter(eID)
                    local numLoot = EJ_GetNumLoot()

                    for lootIdx = 1, numLoot do
                        local info = C_EncounterJournal.GetLootInfoByIndex(lootIdx)
                        if info and info.itemID and not seenItems[info.itemID] then
                            seenItems[info.itemID] = true
                            totalItems = totalItems + 1

                            local slot = SLOT_BY_FILTER[info.filterType] or "Unknown"
                            table.insert(items, {
                                itemID  = info.itemID,
                                name    = info.name or "Unknown",
                                slot    = slot,
                                icon    = info.icon or "",
                                dungeon = name,
                                boss    = eName,
                            })
                        end
                    end

                    encounterIdx = encounterIdx + 1
                end

                print("|cff00ff00[LootExport]|r " .. name .. " — OK")
            else
                print("|cffff8800[LootExport]|r " .. name .. " — journal instance not found, skipping")
            end
        end
    end

    BiSHelperLootExportDB = {
        exportedAt = date("%Y-%m-%d %H:%M:%S"),
        dungeonCount = #dungeons,
        dungeons = dungeons,
        itemCount = totalItems,
        items = items,
    }

    print("|cff00ff00[LootExport]|r Done! Exported " .. totalItems .. " items from " .. #dungeons .. " dungeons.")
    print("|cff00ff00[LootExport]|r Log out or /reload to save. Then run: python tools/parse_loot_export.py")
end

-- Slash command
SLASH_BISEXPORT1 = "/bisexport"
SlashCmdList["BISEXPORT"] = function()
    ExportLoot()
end

-- Notify on load
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "BiS_Helper_LootExport" then
        print("|cff00ff00[LootExport]|r Loaded. Type /bisexport to export current M+ loot.")
        self:UnregisterEvent("ADDON_LOADED")
    end
end)
