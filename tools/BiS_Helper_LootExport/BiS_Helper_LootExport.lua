-- BiS_Helper_LootExport: exports current M+ loot from Encounter Journal
-- Usage: /bisexport in-game, then logout. Python parses WTF/Account/.../SavedVariables/

BiSHelperLootExportDB = BiSHelperLootExportDB or {}

local MYTHIC_DIFFICULTY = 23  -- DifficultyID for Mythic 5-man dungeon

-- Slot name from EJ filterType — built dynamically to avoid nil enum keys
local SLOT_BY_FILTER = {}
local slotDefs = {
    { "Head",      "Head" },
    { "Neck",      "Neck" },
    { "Shoulder",  "Shoulder" },
    { "Chest",     "Chest" },
    { "Waist",     "Waist" },
    { "Legs",      "Legs" },
    { "Feet",      "Feet" },
    { "Wrist",     "Wrist" },
    { "Hand",      "Hands" },
    { "Finger",    "Finger" },
    { "Trinket",   "Trinket" },
    { "Back",      "Back" },
    { "MainHand",  "Main Hand" },
    { "OffHand",   "Off Hand" },
    { "Other",     "Other" },
}
for _, def in ipairs(slotDefs) do
    local enumVal = Enum.ItemSlotFilterType and Enum.ItemSlotFilterType[def[1]]
    if enumVal then
        SLOT_BY_FILTER[enumVal] = def[2]
    end
end

local function FindJournalInstanceID(dungeonName)
    -- Iterate all EJ tiers to find a matching instance by name
    for tierIdx = 1, EJ_GetNumTiers() do
        EJ_SelectTier(tierIdx)
        local instanceIdx = 1
        while true do
            local id, name = EJ_GetInstanceByIndex(instanceIdx, false)  -- false = dungeon (true = raid)
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

                    for lootIdx = 0, numLoot - 1 do
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

-- Debug command: show M+ names vs EJ names for troubleshooting
local function DebugNames()
    print("|cff00ff00[LootExport DEBUG]|r M+ dungeon names from C_ChallengeMode:")
    local mapIDs = C_ChallengeMode.GetMapTable() or {}
    for _, mapID in ipairs(mapIDs) do
        local name = C_ChallengeMode.GetMapUIInfo(mapID)
        print("  M+ mapID=" .. mapID .. " name=" .. tostring(name))
    end

    print("|cff00ff00[LootExport DEBUG]|r EJ dungeon names (all tiers):")
    for tierIdx = 1, EJ_GetNumTiers() do
        EJ_SelectTier(tierIdx)
        local tierName = EJ_GetTierInfo(tierIdx)
        local instanceIdx = 1
        local found = false
        while true do
            local id, name = EJ_GetInstanceByIndex(instanceIdx, false)
            if not id then break end
            if not found then
                print("  -- Tier: " .. tostring(tierName) .. " (dungeons)")
                found = true
            end
            print("    EJ id=" .. id .. " name=" .. tostring(name))
            instanceIdx = instanceIdx + 1
        end
    end
end

-- Slash commands
SLASH_BISEXPORT1 = "/bisexport"
SlashCmdList["BISEXPORT"] = function()
    ExportLoot()
end

SLASH_BISEXPORTDEBUG1 = "/bisexportdebug"
SlashCmdList["BISEXPORTDEBUG"] = function()
    DebugNames()
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
