local ADDON_NAME = "BiS_Helper"

-- ============================================================
-- Slot definitions
-- ============================================================
local SLOTS = {
    { id = 1,  label = "Head"      },
    { id = 2,  label = "Neck"      },
    { id = 3,  label = "Shoulder"  },
    { id = 5,  label = "Chest"     },
    { id = 6,  label = "Waist"     },
    { id = 7,  label = "Legs"      },
    { id = 8,  label = "Feet"      },
    { id = 9,  label = "Wrist"     },
    { id = 10, label = "Hands"     },
    { id = 11, label = "Ring 1"    },
    { id = 12, label = "Ring 2"    },
    { id = 13, label = "Trinket 1" },
    { id = 14, label = "Trinket 2" },
    { id = 15, label = "Back"      },
    { id = 16, label = "Main Hand" },
    { id = 17, label = "Off Hand"  },
}

-- Lookup: lowercase label → slot entry
local slotByLabel = {}
for _, s in ipairs(SLOTS) do slotByLabel[s.label:lower()] = s end

local QUALITY_HEX = {
    [0] = "|cff9d9d9d", [1] = "|cffffffff", [2] = "|cff1eff00",
    [3] = "|cff0070dd", [4] = "|cffa335ee", [5] = "|cffff8000",
    [6] = "|cffe6cc80", [7] = "|cff0cf2d2",
}

-- ============================================================
-- Color palette — Silvermoon / Sin'dorei warm mahogany & gold
-- ============================================================
local P = {
    -- Backgrounds (dark mahogany — Silvermoon interior)
    bg          = { 0.08, 0.04, 0.03, 0.97 },
    bgCard      = { 0.13, 0.07, 0.06, 1.00 },
    bgCardAlt   = { 0.10, 0.05, 0.04, 1.00 },
    bgHeader    = { 0.15, 0.08, 0.07, 1.00 },
    -- Borders (ornamental gold — Silvermoon filigree)
    gold        = { 0.85, 0.68, 0.25, 0.90 },
    goldDim     = { 0.55, 0.40, 0.15, 0.45 },
    -- Status (warmed)
    neonGreen   = { 0.30, 0.88, 0.40, 1.00 },
    neonRed     = { 0.90, 0.22, 0.18, 1.00 },
    neonGrey    = { 0.30, 0.22, 0.20, 1.00 },
    glowGreen   = { 0.30, 0.88, 0.40, 0.14 },
    glowRed     = { 0.90, 0.22, 0.18, 0.10 },
    -- Text (parchment/cream)
    tGold       = "|cfff5c842",
    tCream      = "|cffeddcc8",
    tDim        = "|cff8a7262",
    tWhite      = "|cfff0e6d8",
    tBiS        = "|cff4ee050",
    tMissing    = "|cffe63830",
}

local WHITE_TEX = "Interface/Buttons/WHITE8X8"
local BORDER_TEX = "Interface/Tooltips/UI-Tooltip-Border"
local ROW_H     = 30
local HEADER_H  = 130

-- Gear track colours (highest → lowest)
local TRACK_COLOR = {
    ["Myth"]       = "|cffff8c00",
    ["Hero"]       = "|cffa335ee",
    ["Champion"]   = "|cff0070dd",
    ["Veteran"]    = "|cff1eff00",
    ["Adventurer"] = "|cffaaaaaa",
    ["Explorer"]   = "|cff888888",
}

-- Mapping: DR cap stat name keywords → WoW combat rating IDs
-- Used to read player's current rating via GetCombatRating()
local DR_STAT_CR = {
    ["haste"]            = 18,  -- CR_HASTE_MELEE
    ["crit"]             = 11,  -- CR_CRIT_SPELL
    ["critical strike"]  = 11,
    ["mastery"]          = 26,  -- CR_MASTERY
    ["versatility"]      = 29,  -- CR_VERSATILITY_DAMAGE_DONE
    ["vers"]             = 29,
}

local function Trim(s) return s:match("^%s*(.-)%s*$") end

-- ── Copy-to-clipboard popup ────────────────────────────────
local copyFrame

local function CreateCopyPopup()
    local f = CreateFrame("Frame", "BiSHelperCopyFrame", UIParent, "BackdropTemplate")
    f:SetSize(320, 50)
    f:SetFrameStrata("DIALOG")
    f:SetClampedToScreen(true)
    f:EnableKeyboard(true)
    f:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            self:SetPropagateKeyboardInput(false)
            self:Hide()
        else
            self:SetPropagateKeyboardInput(true)
        end
    end)
    f:Hide()

    f:SetBackdrop({
        bgFile   = WHITE_TEX,
        edgeFile = BORDER_TEX,
        edgeSize = 12,
        insets   = { left = 2, right = 2, top = 2, bottom = 2 },
    })
    f:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], 0.97)
    f:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])

    local label = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    label:SetPoint("TOPLEFT", f, "TOPLEFT", 10, -6)
    f.label = label

    local eb = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
    eb:SetSize(296, 20)
    eb:SetPoint("TOPLEFT", f, "TOPLEFT", 12, -22)
    eb:SetAutoFocus(false)
    eb:SetFontObject(GameFontHighlightSmall)

    eb:SetScript("OnEscapePressed", function() f:Hide() end)
    eb:SetScript("OnEditFocusLost", function() f:Hide() end)

    f.editBox = eb
    f.savedText = ""

    eb:SetScript("OnTextChanged", function(self)
        if self:GetText() ~= f.savedText then
            self:SetText(f.savedText)
            self:HighlightText()
        end
    end)

    return f
end

local function ShowCopyPopup(anchor, itemID, showRawID)
    GameTooltip:Hide()
    if not copyFrame then copyFrame = CreateCopyPopup() end

    local text
    if showRawID then
        text = tostring(itemID)
        copyFrame.label:SetText(P.tGold .. "Item ID|r")
    else
        text = "https://www.wowhead.com/item=" .. itemID
        copyFrame.label:SetText(P.tGold .. "Wowhead Link|r")
    end

    copyFrame.savedText = text
    copyFrame.editBox:SetText(text)
    copyFrame:ClearAllPoints()
    copyFrame:SetPoint("BOTTOM", anchor, "TOP", 0, 4)
    copyFrame:Show()
    copyFrame.editBox:SetFocus()
    copyFrame.editBox:HighlightText()
end

-- Splits compound DR names like "Crit / Mastery" into individual stat entries
local function ExpandDREntry(d)
    local parts = { strsplit("/", d.name) }
    if #parts == 1 then
        local key = Trim(d.name):lower()
        local crId = DR_STAT_CR[key]
        if crId then
            return {{ name = d.name, rating = d.rating, r = d.r, g = d.g, b = d.b, crId = crId }}
        end
        return {{ name = d.name, rating = d.rating, r = d.r, g = d.g, b = d.b }}
    end
    local out = {}
    for _, part in ipairs(parts) do
        local trimmed = Trim(part)
        local key = trimmed:lower()
        local crId = DR_STAT_CR[key]
        out[#out + 1] = { name = trimmed, rating = d.rating, r = d.r, g = d.g, b = d.b, crId = crId }
    end
    return out
end

-- Hidden tooltip used to scan item data (track, etc.)
local scanTooltip = CreateFrame("GameTooltip", "BiSHelperScanTooltip", nil, "GameTooltipTemplate")
scanTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

-- Scan tooltip lines for "Upgrade Level: TrackName X/Y" pattern
local function GetItemTrack(itemLink)
    if not itemLink then return nil end
    scanTooltip:ClearLines()
    local ok = pcall(function() scanTooltip:SetHyperlink(itemLink) end)
    if not ok then return nil end

    for i = 1, scanTooltip:NumLines() do
        local line = _G["BiSHelperScanTooltipTextLeft" .. i]
        if line then
            local text = line:GetText()
            if text then
                local trackName = text:match("Upgrade Level:%s*(%a+)")
                if trackName and TRACK_COLOR[trackName] then
                    return trackName
                end
            end
        end
    end
    return nil
end

-- C_TooltipInfo availability is constant at runtime — check once at load time.
local useC_TooltipInfo = C_TooltipInfo and C_TooltipInfo.GetInventoryItem and true or false

-- enchantPat is derived from a WoW locale global; build it lazily on first use
-- so it is guaranteed to be set, then cached for all subsequent calls.
-- Pattern: "Enchanted: %s"  →  escape Lua specials  →  replace %%s  →  "Enchanted: (.+)"
local enchantPat

-- Extracts enchant name and gem icons from item link/tooltip
local function GetItemEnchantAndGems(slotId)
    local link = GetInventoryItemLink("player", slotId)
    if not link then return nil, nil end

    local enchantID = tonumber(link:match("item:%d+:(%d+)"))
    local enchantName = nil
    local gems = {}

    if enchantID and enchantID > 0 then
        if not enchantPat then
            local fmt = _G.ITEM_ENCHANT_FORMAT or "Enchanted: %s"
            enchantPat = fmt:gsub("([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1"):gsub("%%%%s", "(.+)")
        end

        -- Primary: C_TooltipInfo (TWW+) — structured data, no colour dependency
        if useC_TooltipInfo then
            local data = C_TooltipInfo.GetInventoryItem("player", slotId)
            if data and data.lines then
                for _, line in ipairs(data.lines) do
                    local text = line.leftText
                    if text then
                        local name = text:match(enchantPat)
                        if name then
                            enchantName = Trim(name)
                            break
                        end
                    end
                end
            end
        end

        -- Fallback: scan the hidden GameTooltip (pre-TWW or C_TooltipInfo unavailable)
        if not enchantName then
            scanTooltip:ClearLines()
            pcall(function() scanTooltip:SetHyperlink(link) end)
            for i = 1, scanTooltip:NumLines() do
                local line = _G["BiSHelperScanTooltipTextLeft" .. i]
                if line then
                    local text = line:GetText()
                    if text then
                        -- Pattern match first — reliable when the prefix is present
                        local name = text:match(enchantPat)
                        if name then
                            enchantName = Trim(name)
                            break
                        end
                        -- Colour fallback: bright-green line with no stat indicators
                        local r, g, b = line:GetTextColor()
                        if r < 0.1 and g > 0.9 and b < 0.1
                            and not text:find("+") and #text < 45
                            and not text:find("Set:") and not text:find("%(") then
                            enchantName = Trim(text)
                            break
                        end
                    end
                end
            end
        end

        -- Strip legacy "Enchant Weapon - " or bare "Enchant " prefix if still present
        if enchantName then
            enchantName = enchantName:gsub("^Enchant%s+%S+%s*%-%s*", "")
            enchantName = enchantName:gsub("^Enchant%s+", "")
            if enchantName == "" then enchantName = nil end
        end
    end

    for i = 1, 3 do
        local _, gemLink = C_Item.GetItemGem(link, i)
        if gemLink then
            local _, _, _, _, icon = C_Item.GetItemInfoInstant(gemLink)
            if icon then table.insert(gems, { icon = icon, link = gemLink }) end
        end
    end

    return enchantName, gems
end

-- ============================================================
-- Helpers
-- ============================================================
local function Rect(parent, layer, sublayer, r, g, b, a)
    local t = parent:CreateTexture(nil, layer, nil, sublayer or 0)
    t:SetColorTexture(r, g, b, a)
    return t
end

local function GoldLine(parent, thickness)
    local t = Rect(parent, "ARTWORK", 1, P.gold[1], P.gold[2], P.gold[3], P.gold[4])
    t:SetHeight(thickness or 1)
    return t
end

-- ============================================================
-- Base64 encode / decode
-- ============================================================
local B64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local function Base64Encode(data)
    local out = {}
    local pad = #data % 3
    data = data .. string.rep("\0", (3 - pad) % 3)
    for i = 1, #data, 3 do
        local b1, b2, b3 = data:byte(i, i + 2)
        local n = b1 * 65536 + b2 * 256 + b3
        out[#out + 1] = B64:sub(math.floor(n / 262144) % 64 + 1, math.floor(n / 262144) % 64 + 1)
        out[#out + 1] = B64:sub(math.floor(n / 4096)   % 64 + 1, math.floor(n / 4096)   % 64 + 1)
        out[#out + 1] = B64:sub(math.floor(n / 64)     % 64 + 1, math.floor(n / 64)     % 64 + 1)
        out[#out + 1] = B64:sub(n                       % 64 + 1, n                       % 64 + 1)
    end
    if pad == 1 then out[#out] = "="; out[#out - 1] = "=" end
    if pad == 2 then out[#out] = "=" end
    return table.concat(out)
end

local B64_REV = {}
for i = 1, 64 do B64_REV[B64:byte(i)] = i - 1 end

local function Base64Decode(data)
    data = data:gsub("[^A-Za-z0-9+/=]", "")
    local out = {}
    for i = 1, #data, 4 do
        local c1, c2, c3, c4 = data:byte(i, i + 3)
        local n1 = B64_REV[c1] or 0
        local n2 = B64_REV[c2] or 0
        local n3 = B64_REV[c3] or 0
        local n4 = B64_REV[c4] or 0
        local n = n1 * 262144 + n2 * 4096 + n3 * 64 + n4
        out[#out + 1] = string.char(math.floor(n / 65536) % 256)
        if data:sub(i + 2, i + 2) ~= "=" then out[#out + 1] = string.char(math.floor(n / 256) % 256) end
        if data:sub(i + 3, i + 3) ~= "=" then out[#out + 1] = string.char(n % 256) end
    end
    return table.concat(out)
end

-- ============================================================
-- Lua table serializer / deserializer
-- ============================================================
local function Serialize(val)
    local t = type(val)
    if t == "number" then
        -- Use format to avoid scientific notation (e.g. 1e+20)
        if val == math.floor(val) and val >= -2^53 and val <= 2^53 then
            return string.format("%d", val)
        else
            return string.format("%.17g", val)
        end
    elseif t == "string" then
        return string.format("%q", val)
    elseif t == "boolean" then
        return val and "true" or "false"
    elseif t == "table" then
        local parts = {}
        -- Numeric keys first (array part)
        local maxn = 0
        for k in pairs(val) do
            if type(k) == "number" and k == math.floor(k) and k > 0 then
                if k > maxn then maxn = k end
            end
        end
        for i = 1, maxn do
            if val[i] ~= nil then
                parts[#parts + 1] = Serialize(val[i])
            else
                parts[#parts + 1] = "nil"
            end
        end
        -- String keys
        for k, v in pairs(val) do
            if type(k) == "string" then
                parts[#parts + 1] = "[" .. string.format("%q", k) .. "]=" .. Serialize(v)
            elseif type(k) == "number" and (k < 1 or k > maxn or k ~= math.floor(k)) then
                parts[#parts + 1] = "[" .. tostring(k) .. "]=" .. Serialize(v)
            end
        end
        return "{" .. table.concat(parts, ",") .. "}"
    end
    return "nil"
end

local function Deserialize(str)
    local pos = 1
    local len = #str

    local function skipWhitespace()
        while pos <= len and str:sub(pos, pos):match("%s") do pos = pos + 1 end
    end

    local function peek() return str:sub(pos, pos) end

    local function parseValue()
        skipWhitespace()
        local ch = peek()

        if ch == "{" then
            -- Table
            pos = pos + 1  -- skip '{'
            local tbl = {}
            local arrayIndex = 1
            skipWhitespace()
            while pos <= len and peek() ~= "}" do
                skipWhitespace()
                -- Check for [key]= syntax
                if peek() == "[" then
                    pos = pos + 1  -- skip '['
                    local key = parseValue()
                    skipWhitespace()
                    if peek() == "]" then pos = pos + 1 end -- skip ']'
                    skipWhitespace()
                    if peek() == "=" then pos = pos + 1 end -- skip '='
                    tbl[key] = parseValue()
                else
                    -- Could be key=value or just a positional value
                    local savedPos = pos
                    local val = parseValue()
                    skipWhitespace()
                    if peek() == "=" then
                        -- It was a key (must be a string identifier)
                        pos = pos + 1  -- skip '='
                        tbl[val] = parseValue()
                    else
                        tbl[arrayIndex] = val
                        arrayIndex = arrayIndex + 1
                    end
                end
                skipWhitespace()
                if peek() == "," then pos = pos + 1 end
            end
            if peek() == "}" then pos = pos + 1 end  -- skip '}'
            return tbl

        elseif ch == '"' then
            -- Quoted string (handle escape sequences from string.format %q)
            pos = pos + 1  -- skip opening "
            local parts = {}
            while pos <= len and peek() ~= '"' do
                if peek() == "\\" then
                    pos = pos + 1
                    local esc = peek()
                    if esc == "n" then parts[#parts + 1] = "\n"
                    elseif esc == "t" then parts[#parts + 1] = "\t"
                    elseif esc == "a" then parts[#parts + 1] = "\a"
                    elseif esc == "b" then parts[#parts + 1] = "\b"
                    elseif esc == "f" then parts[#parts + 1] = "\f"
                    elseif esc == "r" then parts[#parts + 1] = "\r"
                    elseif esc == "v" then parts[#parts + 1] = "\v"
                    elseif esc == "\\" then parts[#parts + 1] = "\\"
                    elseif esc == '"' then parts[#parts + 1] = '"'
                    elseif esc:match("%d") then
                        local numStr = esc
                        pos = pos + 1
                        if pos <= len and peek():match("%d") then numStr = numStr .. peek(); pos = pos + 1
                            if pos <= len and peek():match("%d") then numStr = numStr .. peek(); pos = pos + 1 end
                        end
                        parts[#parts + 1] = string.char(tonumber(numStr))
                        pos = pos - 1  -- will be incremented below
                    else parts[#parts + 1] = esc end
                    pos = pos + 1
                else
                    parts[#parts + 1] = peek()
                    pos = pos + 1
                end
            end
            if peek() == '"' then pos = pos + 1 end  -- skip closing "
            return table.concat(parts)

        elseif ch == "-" or ch:match("%d") then
            -- Number
            local numStr = str:match("^-?%d+%.?%d*", pos)
            pos = pos + #numStr
            return tonumber(numStr)

        elseif str:sub(pos, pos + 3) == "true" then
            pos = pos + 4
            return true

        elseif str:sub(pos, pos + 4) == "false" then
            pos = pos + 5
            return false

        elseif str:sub(pos, pos + 2) == "nil" then
            pos = pos + 3
            return nil
        end

        return nil
    end

    local ok, result = pcall(parseValue)
    if ok then return result end
    return nil
end

-- ============================================================
-- Profile share helpers
-- ============================================================
local SHARE_PREFIX = "!BH1!"

local function EncodeProfile(profileTable)
    local serialized = Serialize(profileTable)
    return SHARE_PREFIX .. Base64Encode(serialized)
end

local function DecodeProfile(encoded)
    if type(encoded) ~= "string" then return nil, "Invalid input" end
    encoded = Trim(encoded)
    if encoded:sub(1, #SHARE_PREFIX) ~= SHARE_PREFIX then
        return nil, "Invalid import string — not a BiS Helper profile"
    end
    local b64 = encoded:sub(#SHARE_PREFIX + 1)
    local ok, decoded = pcall(Base64Decode, b64)
    if not ok or not decoded or decoded == "" then
        return nil, "Invalid import string — corrupted data"
    end
    local tbl = Deserialize(decoded)
    if type(tbl) ~= "table" then
        return nil, "Invalid import string — corrupted data"
    end
    if not tbl.version then
        return nil, "Invalid import string — missing version"
    end
    if tbl.version > 1 then
        return nil, "This profile requires a newer version of BiS Helper"
    end
    if not tbl.key then
        return nil, "Invalid import string — missing spec key"
    end
    local hasItems = tbl.items and (next(tbl.items) ~= nil)
    local hasStats = tbl.stats and (next(tbl.stats) ~= nil)
    if not hasItems and not hasStats then
        return nil, "Nothing to import — profile is empty"
    end
    return tbl, nil
end

local activeMode = "mythicplus"
local pendingOverrideNames = {}  -- [itemID] = {specKey, mode, slotId}

-- ============================================================
-- Spec detection
-- ============================================================
local function GetCurrentDataKey()
    local specIndex = GetSpecialization()
    if not specIndex then return nil end
    local _, specName = GetSpecializationInfo(specIndex)
    local _, classFile = UnitClass("player")
    if not classFile or not specName then return nil end
    return classFile .. "_" .. specName:upper():gsub("%s+", "")
end

local function GetSpecData()
    if not BiSHelper_Data then return nil end
    local key = GetCurrentDataKey()
    if not key then return nil end
    return BiSHelper_Data[key]
end

local function GetActiveBiSList()
    local spec = GetSpecData()
    if not spec then return nil end
    local base = spec.content and spec.content[activeMode]
    local specKey = GetCurrentDataKey()
    local ov = specKey and BiSHelperDB and BiSHelperDB.overrides
               and BiSHelperDB.overrides[specKey]
               and BiSHelperDB.overrides[specKey][activeMode]
    if not ov then return base end
    -- Merge: override wins per slot, fallback to base
    local merged = {}
    if base then for k, v in pairs(base) do merged[k] = v end end
    for k, v in pairs(ov) do merged[k] = v end
    return merged
end

local function GetItemIDFromLink(link)
    if not link then return nil end
    return tonumber(link:match("|Hitem:(%d+):"))
end

local DEFAULT_STAT_COLORS = {
    ["intellect"]       = {0.94, 0.74, 0.90},
    ["strength"]        = {0.94, 0.45, 0.45},
    ["agility"]         = {0.45, 0.94, 0.45},
    ["haste"]           = {1.00, 0.82, 0.00},
    ["mastery"]         = {0.45, 0.94, 0.94},
    ["versatility"]     = {0.55, 0.90, 0.55},
    ["critical strike"] = {1.00, 0.50, 0.50},
    ["crit"]            = {1.00, 0.50, 0.50},
}

local function GetActiveStatData()
    local spec = GetSpecData()
    if not spec or not spec.statPriority then return nil end
    local base    = spec.statPriority
    local specKey = GetCurrentDataKey()
    local ov = specKey and BiSHelperDB and BiSHelperDB.statOverrides
               and BiSHelperDB.statOverrides[specKey]
    if not ov then return base end
    local merged = {}
    for k, v in pairs(base) do merged[k] = v end
    if ov[activeMode] then merged[activeMode] = ov[activeMode] end
    if ov["dr"]       then merged["dr"]       = ov["dr"]       end
    return merged
end

local function BuildExportProfile()
    local specKey = GetCurrentDataKey()
    if not specKey then return nil end
    local specData = GetSpecData()
    if not specData or not specData.content then return nil end

    local profile = {
        version = 1,
        key = specKey,
        items = {},
        stats = {},
    }

    -- Items: grab base content, paste overrides on top
    for _, mode in ipairs({"raid", "mythicplus"}) do
        profile.items[mode] = {}
        if specData.content[mode] then
            for slot, data in pairs(specData.content[mode]) do
                profile.items[mode][slot] = { itemID = data.itemID, name = data.name, source = data.source }
            end
        end
        local ov = BiSHelperDB.overrides and BiSHelperDB.overrides[specKey] and BiSHelperDB.overrides[specKey][mode]
        if ov then
            for slot, data in pairs(ov) do
                profile.items[mode][slot] = { itemID = data.itemID, name = data.name, source = data.source }
            end
        end
    end

    -- Stats: grab base, paste overrides on top
    for _, mode in ipairs({"raid", "mythicplus"}) do
        local base = specData.statPriority and specData.statPriority[mode]
        local ov = BiSHelperDB.statOverrides and BiSHelperDB.statOverrides[specKey] and BiSHelperDB.statOverrides[specKey][mode]
        profile.stats[mode] = ov or base
    end
    local baseDr = specData.statPriority and specData.statPriority.dr
    local ovDr = BiSHelperDB.statOverrides and BiSHelperDB.statOverrides[specKey] and BiSHelperDB.statOverrides[specKey].dr
    profile.stats.dr = ovDr or baseDr

    return profile
end

-- ============================================================
-- Edit panel helpers
-- ============================================================
local EQUIPTYPE_TO_SLOTS = {
    INVTYPE_HEAD           = {1},
    INVTYPE_NECK           = {2},
    INVTYPE_SHOULDER       = {3},
    INVTYPE_CHEST          = {5},
    INVTYPE_ROBE           = {5},
    INVTYPE_WAIST          = {6},
    INVTYPE_LEGS           = {7},
    INVTYPE_FEET           = {8},
    INVTYPE_WRIST          = {9},
    INVTYPE_HAND           = {10},
    INVTYPE_FINGER         = {11, 12},
    INVTYPE_TRINKET        = {13, 14},
    INVTYPE_CLOAK          = {15},
    INVTYPE_2HWEAPON       = {16},
    INVTYPE_WEAPON         = {16, 17},
    INVTYPE_WEAPONMAINHAND = {16},
    INVTYPE_WEAPONOFFHAND  = {17},
    INVTYPE_SHIELD         = {17},
    INVTYPE_RANGED         = {16},
    INVTYPE_RANGEDRIGHT    = {16},
    INVTYPE_HOLDABLE       = {17},
}

local slotIdToLabel = {}
for _, s in ipairs(SLOTS) do slotIdToLabel[s.id] = s.label end

local function RebuildOverrideRows()
    local ef = BiSHelperEditFrame
    if not ef or not ef.overrideContent then return end
    for _, row in ipairs(ef.overrideRowPool) do row:Hide() end
    local specKey = GetCurrentDataKey()
    local ov = specKey and BiSHelperDB and BiSHelperDB.overrides
               and BiSHelperDB.overrides[specKey]
               and BiSHelperDB.overrides[specKey][activeMode]
    local count, y = 0, 0
    if ov then
        for _, slot in ipairs(SLOTS) do
            local entry = ov[slot.id]
            if entry then
                count = count + 1
                if not ef.overrideRowPool[count] then
                    local row = CreateFrame("Frame", nil, ef.overrideContent)
                    row:SetHeight(24)
                    local rowBg = Rect(row, "BACKGROUND", 0, P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4])
                    rowBg:SetAllPoints()
                    local rowSep = Rect(row, "ARTWORK", 0, P.goldDim[1], P.goldDim[2], P.goldDim[3], P.goldDim[4])
                    rowSep:SetHeight(1)
                    rowSep:SetPoint("BOTTOMLEFT",  row, "BOTTOMLEFT",  0, 0)
                    rowSep:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)
                    local sLbl = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                    sLbl:SetPoint("LEFT", row, "LEFT", 6, 0)
                    sLbl:SetWidth(74)
                    sLbl:SetJustifyH("LEFT")
                    row.slotLbl = sLbl
                    local nLbl = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                    nLbl:SetPoint("LEFT",  row, "LEFT",  84, 0)
                    nLbl:SetPoint("RIGHT", row, "RIGHT", -26, 0)
                    nLbl:SetJustifyH("LEFT")
                    nLbl:SetWordWrap(false)
                    row.nameLbl = nLbl
                    local xBtn = CreateFrame("Button", nil, row)
                    xBtn:SetSize(20, 20)
                    xBtn:SetPoint("RIGHT", row, "RIGHT", -2, 0)
                    local xLbl = xBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                    xLbl:SetAllPoints()
                    xLbl:SetJustifyH("CENTER")
                    xLbl:SetText("|cffe63830×|r")
                    xBtn:SetScript("OnEnter", function() xLbl:SetText("|cffe86860×|r") end)
                    xBtn:SetScript("OnLeave", function() xLbl:SetText("|cffe63830×|r") end)
                    row.xBtn = xBtn
                    ef.overrideRowPool[count] = row
                end
                local row = ef.overrideRowPool[count]
                row:ClearAllPoints()
                row:SetPoint("TOPLEFT",  ef.overrideContent, "TOPLEFT",  0, -y)
                row:SetPoint("TOPRIGHT", ef.overrideContent, "TOPRIGHT", 0, -y)
                row.slotLbl:SetText(P.tDim .. slot.label .. ":|r")
                local dn = (entry.name and entry.name ~= "") and entry.name or "|cffaaaaaa(loading…)|r"
                row.nameLbl:SetText(P.tGold .. dn .. "|r")
                local slotId = slot.id
                row.xBtn:SetScript("OnClick", function()
                    local sk = GetCurrentDataKey()
                    if sk and BiSHelperDB.overrides
                       and BiSHelperDB.overrides[sk]
                       and BiSHelperDB.overrides[sk][activeMode] then
                        BiSHelperDB.overrides[sk][activeMode][slotId] = nil
                        local hasAny = false
                        for _ in pairs(BiSHelperDB.overrides[sk][activeMode]) do hasAny = true break end
                        if not hasAny then
                            BiSHelperDB.overrides[sk][activeMode] = nil
                            local hasMode = false
                            for _ in pairs(BiSHelperDB.overrides[sk]) do hasMode = true break end
                            if not hasMode then BiSHelperDB.overrides[sk] = nil end
                        end
                    end
                    BiSHelper_Refresh()
                    RebuildOverrideRows()
                end)
                row:Show()
                y = y + 24
            end
        end
    end
    ef.emptyMsg:SetShown(count == 0)
    ef.overrideContent:SetHeight(math.max(y, 1))
end

local function ProcessAddItem(itemID)
    local ef = BiSHelperEditFrame
    if not ef then return end
    local name, _, _, _, _, _, _, _, equipLoc = C_Item.GetItemInfo(itemID)
    if not name or not equipLoc or equipLoc == "" then return end
    local slots = EQUIPTYPE_TO_SLOTS[equipLoc]
    if not slots then return end
    if #slots == 1 then
        BiSHelper_AddOverride(itemID, slots[1])
    else
        ef.pickerItemID = itemID
        ef.pickerSlots  = slots
        for i, pb in ipairs(ef.pickerBtns) do
            if slots[i] then
                pb.lbl:SetText(P.tGold .. (slotIdToLabel[slots[i]] or ("Slot "..slots[i])) .. "|r")
                pb:Show()
            else
                pb:Hide()
            end
        end
        ef.slotPicker:Show()
    end
end

local function CreateEditFrame()
    local ef = CreateFrame("Frame", "BiSHelperEditFrame", UIParent, "BackdropTemplate")
    ef:SetSize(340, 476)
    ef:SetPoint("CENTER")
    ef:SetMovable(true)
    ef:SetClampedToScreen(true)
    ef:SetFrameStrata("DIALOG")
    ef:EnableMouse(true)
    ef:RegisterForDrag("LeftButton")
    ef:SetScript("OnDragStart", ef.StartMoving)
    ef:SetScript("OnDragStop",  ef.StopMovingOrSizing)
    ef:Hide()

    ef:SetBackdrop({
        bgFile = WHITE_TEX, edgeFile = BORDER_TEX, edgeSize = 16,
        insets = { left=4, right=4, top=4, bottom=4 },
    })
    ef:SetBackdropColor(P.bg[1], P.bg[2], P.bg[3], P.bg[4])
    ef:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])

    -- Header (36px)
    local hdrBg = Rect(ef, "BACKGROUND", 2, P.bgHeader[1], P.bgHeader[2], P.bgHeader[3], P.bgHeader[4])
    hdrBg:SetPoint("TOPLEFT",  ef, "TOPLEFT",  1, -1)
    hdrBg:SetPoint("TOPRIGHT", ef, "TOPRIGHT", -1, -1)
    hdrBg:SetHeight(36)
    local hdrSep = GoldLine(ef, 1)
    hdrSep:SetPoint("TOPLEFT",  ef, "TOPLEFT",  2, -36)
    hdrSep:SetPoint("TOPRIGHT", ef, "TOPRIGHT", -2, -36)

    ef.titleText = ef:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    ef.titleText:SetPoint("TOPLEFT", ef, "TOPLEFT", 10, -10)
    ef.titleText:SetText(P.tGold .. "Edit BiS|r")

    local closeBtn = CreateFrame("Button", nil, ef, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", ef, "TOPRIGHT", -2, -2)
    closeBtn:SetScript("OnClick", function() ef:Hide() end)

    ef:EnableKeyboard(true)
    ef:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            self:SetPropagateKeyboardInput(false)
            self:Hide()
        else
            self:SetPropagateKeyboardInput(true)
        end
    end)

    -- Input row (y: -40 to -62)
    local inputLabel = ef:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    inputLabel:SetPoint("TOPLEFT", ef, "TOPLEFT", 10, -50)
    inputLabel:SetText(P.tDim .. "Item ID:|r")

    local inputBox = CreateFrame("EditBox", nil, ef, "BackdropTemplate")
    inputBox:SetSize(140, 22)
    inputBox:SetPoint("TOPLEFT", ef, "TOPLEFT", 68, -41)
    inputBox:SetBackdrop({
        bgFile = WHITE_TEX, edgeFile = BORDER_TEX, edgeSize = 12,
        insets = { left=3, right=3, top=3, bottom=3 },
    })
    inputBox:SetBackdropColor(0.08, 0.04, 0.03, 1)
    inputBox:SetBackdropBorderColor(P.goldDim[1], P.goldDim[2], P.goldDim[3], 1)
    inputBox:SetFontObject("ChatFontNormal")
    inputBox:SetAutoFocus(false)
    inputBox:SetNumeric(true)
    inputBox:SetMaxLetters(10)
    inputBox:SetTextInsets(4, 4, 0, 0)
    ef.inputBox = inputBox

    local addBtn = CreateFrame("Button", nil, ef, "BackdropTemplate")
    addBtn:SetSize(50, 22)
    addBtn:SetPoint("LEFT", inputBox, "RIGHT", 4, 0)
    addBtn:SetBackdrop({
        bgFile = WHITE_TEX, edgeFile = BORDER_TEX, edgeSize = 12,
        insets = { left=3, right=3, top=3, bottom=3 },
    })
    addBtn:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4])
    addBtn:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])
    local addBtnLbl = addBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    addBtnLbl:SetAllPoints() addBtnLbl:SetJustifyH("CENTER")
    addBtnLbl:SetText(P.tGold .. "Add|r")
    addBtn:SetScript("OnEnter", function() addBtn:SetBackdropColor(0.25, 0.12, 0.08, 0.95) end)
    addBtn:SetScript("OnLeave", function() addBtn:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4]) end)

    local function TryAdd()
        local itemID = tonumber(inputBox:GetText())
        if not itemID then return end
        inputBox:SetText("")
        local name, _, _, _, _, _, _, _, equipLoc = C_Item.GetItemInfo(itemID)
        if name then
            ProcessAddItem(itemID)
        else
            C_Item.RequestLoadItemDataByID(itemID)
            ef.pendingAdd = itemID
        end
    end
    inputBox:SetScript("OnEnterPressed", TryAdd)
    addBtn:SetScript("OnClick", TryAdd)

    -- Help hint below input
    local hintText = ef:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hintText:SetPoint("TOPLEFT", ef, "TOPLEFT", 10, -68)
    hintText:SetPoint("RIGHT", ef, "RIGHT", -10, 0)
    hintText:SetJustifyH("LEFT")
    hintText:SetText(P.tDim .. "Find Item ID on Wowhead: wowhead.com/item/123456 — the number is the ID.|r")

    -- Slot picker (y: -82 to -108, hidden by default)
    local picker = CreateFrame("Frame", nil, ef)
    picker:SetPoint("TOPLEFT",  ef, "TOPLEFT",  8, -82)
    picker:SetPoint("TOPRIGHT", ef, "TOPRIGHT", -8, -82)
    picker:SetHeight(26)
    picker:Hide()
    ef.slotPicker = picker

    local pickerLbl = picker:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    pickerLbl:SetPoint("LEFT", picker, "LEFT", 0, 0)
    pickerLbl:SetText(P.tDim .. "Which slot?|r")

    ef.pickerBtns = {}
    for i = 1, 2 do
        local pb = CreateFrame("Button", nil, picker, "BackdropTemplate")
        pb:SetSize(84, 22)
        pb:SetPoint("LEFT", picker, "LEFT", 82 + (i-1)*90, -2)
        pb:SetBackdrop({
            bgFile = WHITE_TEX, edgeFile = BORDER_TEX, edgeSize = 12,
            insets = { left=3, right=3, top=3, bottom=3 },
        })
        pb:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4])
        pb:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])
        pb.lbl = pb:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        pb.lbl:SetAllPoints() pb.lbl:SetJustifyH("CENTER")
        pb:SetScript("OnEnter", function() pb:SetBackdropColor(0.25, 0.12, 0.08, 0.95) end)
        pb:SetScript("OnLeave", function() pb:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4]) end)
        local idx = i
        pb:SetScript("OnClick", function()
            picker:Hide()
            if ef.pickerItemID and ef.pickerSlots and ef.pickerSlots[idx] then
                BiSHelper_AddOverride(ef.pickerItemID, ef.pickerSlots[idx])
            end
        end)
        ef.pickerBtns[i] = pb
    end

    -- Separator before list (y: -112)
    local listSep = GoldLine(ef, 1)
    listSep:SetPoint("TOPLEFT",  ef, "TOPLEFT",  2, -112)
    listSep:SetPoint("TOPRIGHT", ef, "TOPRIGHT", -2, -112)

    -- Override list scroll
    local scrollFrame = CreateFrame("ScrollFrame", nil, ef, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT",     ef, "TOPLEFT",    4, -116)
    scrollFrame:SetPoint("BOTTOMRIGHT", ef, "BOTTOMRIGHT", -26, 32)

    local overrideContent = CreateFrame("Frame", nil, scrollFrame)
    overrideContent:SetHeight(1)
    scrollFrame:SetScrollChild(overrideContent)
    scrollFrame:SetScript("OnSizeChanged", function(self, w) overrideContent:SetWidth(w) end)
    ef.overrideContent = overrideContent
    ef.overrideRowPool = {}

    ef.emptyMsg = overrideContent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    ef.emptyMsg:SetPoint("TOP", overrideContent, "TOP", 0, -10)
    ef.emptyMsg:SetText(P.tDim .. "No overrides for this spec / mode.|r")
    ef.emptyMsg:Hide()

    -- Bottom separator + Reset All
    local botSep = GoldLine(ef, 1)
    botSep:SetPoint("BOTTOMLEFT",  ef, "BOTTOMLEFT",  2, 30)
    botSep:SetPoint("BOTTOMRIGHT", ef, "BOTTOMRIGHT", -2, 30)

    local resetBtn = CreateFrame("Button", nil, ef, "BackdropTemplate")
    resetBtn:SetSize(80, 22)
    resetBtn:SetPoint("BOTTOMRIGHT", ef, "BOTTOMRIGHT", -6, 5)
    resetBtn:SetBackdrop({
        bgFile = WHITE_TEX, edgeFile = BORDER_TEX, edgeSize = 12,
        insets = { left=3, right=3, top=3, bottom=3 },
    })
    resetBtn:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4])
    resetBtn:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])
    local resetLbl = resetBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    resetLbl:SetAllPoints() resetLbl:SetJustifyH("CENTER")
    resetLbl:SetText(P.tDim .. "Reset All|r")
    resetBtn:SetScript("OnEnter", function() resetBtn:SetBackdropColor(0.25, 0.12, 0.08, 0.95) end)
    resetBtn:SetScript("OnLeave", function() resetBtn:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4]) end)
    resetBtn:SetScript("OnClick", function() BiSHelper_ResetOverrides() end)

    return ef
end

function BiSHelper_OpenEditPanel()
    if not BiSHelperEditFrame then
        BiSHelperEditFrame = CreateEditFrame()
    end
    local specData = GetSpecData()
    local modeLabel = activeMode == "raid" and "Raid" or "Mythic+"
    local specLabel = specData and specData.label or "?"
    BiSHelperEditFrame.titleText:SetText(
        P.tGold .. "Edit BiS|r — " .. P.tCream .. specLabel .. "|r · " .. P.tDim .. modeLabel .. "|r")
    BiSHelperEditFrame.inputBox:SetText("")
    BiSHelperEditFrame.slotPicker:Hide()
    RebuildOverrideRows()
    BiSHelperEditFrame:Show()
end

function BiSHelper_AddOverride(itemID, slotId)
    local specKey = GetCurrentDataKey()
    if not specKey then return end
    local name = C_Item.GetItemInfo(itemID)
    BiSHelperDB.overrides = BiSHelperDB.overrides or {}
    BiSHelperDB.overrides[specKey] = BiSHelperDB.overrides[specKey] or {}
    BiSHelperDB.overrides[specKey][activeMode] = BiSHelperDB.overrides[specKey][activeMode] or {}
    if name then
        BiSHelperDB.overrides[specKey][activeMode][slotId] = { itemID = itemID, name = name, source = "Custom" }
    else
        BiSHelperDB.overrides[specKey][activeMode][slotId] = { itemID = itemID, name = "", source = "Custom" }
        pendingOverrideNames[itemID] = { specKey = specKey, mode = activeMode, slotId = slotId }
    end
    BiSHelper_Refresh()
    if BiSHelperEditFrame and BiSHelperEditFrame:IsShown() then RebuildOverrideRows() end
end

function BiSHelper_ResetOverrides()
    local specKey = GetCurrentDataKey()
    if not specKey then return end
    if BiSHelperDB.overrides and BiSHelperDB.overrides[specKey] then
        BiSHelperDB.overrides[specKey][activeMode] = nil
        local hasAny = false
        for _ in pairs(BiSHelperDB.overrides[specKey]) do hasAny = true break end
        if not hasAny then BiSHelperDB.overrides[specKey] = nil end
    end
    wipe(pendingOverrideNames)
    BiSHelper_Refresh()
    if BiSHelperEditFrame and BiSHelperEditFrame:IsShown() then RebuildOverrideRows() end
end

-- ============================================================
-- Stats panel helpers
-- ============================================================
local function GetStatColor(name, specData)
    -- 1. Look in spec data (all modes) for matching name
    if specData and specData.statPriority then
        for _, mode in ipairs({"mythicplus", "raid"}) do
            local sp = specData.statPriority[mode]
            if sp and sp.stats then
                for _, s in ipairs(sp.stats) do
                    if s.name:lower() == name:lower() then return s.r, s.g, s.b end
                end
            end
        end
        if specData.statPriority.dr then
            for _, d in ipairs(specData.statPriority.dr) do
                if d.name:lower() == name:lower() then return d.r, d.g, d.b end
            end
        end
    end
    -- 2. Default palette
    local c = DEFAULT_STAT_COLORS[name:lower()]
    if c then return c[1], c[2], c[3] end
    return 1, 1, 1
end

local function BuildStatText()
    local sp = GetActiveStatData()
    if not sp or not sp[activeMode] or not sp[activeMode].stats then return "" end
    local parts = {}
    for _, stat in ipairs(sp[activeMode].stats) do
        parts[#parts + 1] = stat.name
        if stat.op then parts[#parts + 1] = " " .. stat.op .. " " end
    end
    return table.concat(parts)
end

local function BuildDRText()
    local sp = GetActiveStatData()
    if not sp or not sp.dr then return "" end
    local lines = {}
    for _, d in ipairs(sp.dr) do
        lines[#lines + 1] = d.name .. ": " .. (d.rating or "")
    end
    return table.concat(lines, "\n")
end

local function ParseStatText(text)
    -- Parse "Haste > Critical Strike = Mastery" into stats array
    local specData = GetSpecData()
    local stats = {}
    local rem = text:match("^%s*(.-)%s*$")
    while #rem > 0 do
        local name, op, rest = rem:match("^(.-[^%s%>%=])%s*([>=])%s*(.*)")
        if name then
            local r, g, b = GetStatColor(name, specData)
            stats[#stats + 1] = { name = name, op = op, r = r, g = g, b = b }
            rem = rest
        else
            local last = rem:match("^%s*(.-)%s*$")
            if last ~= "" then
                local r, g, b = GetStatColor(last, specData)
                stats[#stats + 1] = { name = last, r = r, g = g, b = b }
            end
            break
        end
    end
    return stats
end

local function ParseDRText(text)
    local specData = GetSpecData()
    local dr = {}
    for line in (text .. "\n"):gmatch("([^\n]*)\n") do
        local name, rating = line:match("^%s*(.-)%s*:%s*(%d+)%s*$")
        if name and rating and name ~= "" then
            local r, g, b = GetStatColor(name, specData)
            dr[#dr + 1] = { name = name, rating = tonumber(rating), r = r, g = g, b = b }
        end
    end
    return dr
end

local function CreateStatsFrame()
    local sf = CreateFrame("Frame", "BiSHelperStatsFrame", UIParent, "BackdropTemplate")
    sf:SetSize(460, 300)
    sf:SetPoint("CENTER")
    sf:SetMovable(true)
    sf:SetClampedToScreen(true)
    sf:SetFrameStrata("DIALOG")
    sf:EnableMouse(true)
    sf:RegisterForDrag("LeftButton")
    sf:SetScript("OnDragStart", sf.StartMoving)
    sf:SetScript("OnDragStop",  sf.StopMovingOrSizing)
    sf:Hide()

    sf:SetBackdrop({
        bgFile = WHITE_TEX, edgeFile = BORDER_TEX, edgeSize = 16,
        insets = { left=4, right=4, top=4, bottom=4 },
    })
    sf:SetBackdropColor(P.bg[1], P.bg[2], P.bg[3], P.bg[4])
    sf:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])

    -- Header (36px)
    local hdrBg = Rect(sf, "BACKGROUND", 2, P.bgHeader[1], P.bgHeader[2], P.bgHeader[3], P.bgHeader[4])
    hdrBg:SetPoint("TOPLEFT",  sf, "TOPLEFT",  1, -1)
    hdrBg:SetPoint("TOPRIGHT", sf, "TOPRIGHT", -1, -1)
    hdrBg:SetHeight(36)
    local hdrSep = GoldLine(sf, 1)
    hdrSep:SetPoint("TOPLEFT",  sf, "TOPLEFT",  2, -36)
    hdrSep:SetPoint("TOPRIGHT", sf, "TOPRIGHT", -2, -36)

    sf.titleText = sf:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sf.titleText:SetPoint("TOPLEFT", sf, "TOPLEFT", 10, -10)
    sf.titleText:SetText(P.tGold .. "Edit Stats|r")

    local closeBtn = CreateFrame("Button", nil, sf, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", sf, "TOPRIGHT", -2, -2)
    closeBtn:SetScript("OnClick", function() sf:Hide() end)

    sf:EnableKeyboard(true)
    sf:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            self:SetPropagateKeyboardInput(false)
            self:Hide()
        else
            self:SetPropagateKeyboardInput(true)
        end
    end)

    -- Stat priority section (y: -44 to -104)
    local statLabel = sf:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    statLabel:SetPoint("TOPLEFT", sf, "TOPLEFT", 10, -46)
    statLabel:SetText(P.tGold .. "Stat Priority:|r")

    local statHint = sf:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    statHint:SetPoint("LEFT",  statLabel, "RIGHT", 8, 0)
    statHint:SetText(P.tDim .. "Use  >  or  =  as separators|r")

    local statBox = CreateFrame("EditBox", nil, sf, "BackdropTemplate")
    statBox:SetSize(438, 24)
    statBox:SetPoint("TOPLEFT", sf, "TOPLEFT", 10, -62)
    statBox:SetBackdrop({
        bgFile = WHITE_TEX, edgeFile = BORDER_TEX, edgeSize = 12,
        insets = { left=3, right=3, top=3, bottom=3 },
    })
    statBox:SetBackdropColor(0.08, 0.04, 0.03, 1)
    statBox:SetBackdropBorderColor(P.goldDim[1], P.goldDim[2], P.goldDim[3], 1)
    statBox:SetFontObject("ChatFontNormal")
    statBox:SetAutoFocus(false)
    statBox:SetMaxLetters(256)
    statBox:SetTextInsets(4, 4, 0, 0)
    statBox:SetScript("OnEscapePressed", function() sf:Hide() end)
    sf.statBox = statBox

    -- DR section (y: -98 to -260)
    local drSep = GoldLine(sf, 1)
    drSep:SetPoint("TOPLEFT",  sf, "TOPLEFT",  2, -98)
    drSep:SetPoint("TOPRIGHT", sf, "TOPRIGHT", -2, -98)

    local drLabel = sf:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    drLabel:SetPoint("TOPLEFT", sf, "TOPLEFT", 10, -108)
    drLabel:SetText(P.tGold .. "DR Caps:|r")

    local drHint = sf:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    drHint:SetPoint("LEFT", drLabel, "RIGHT", 8, 0)
    drHint:SetText(P.tDim .. "One per line:  Haste: 3456|r")

    local drScroll = CreateFrame("ScrollFrame", nil, sf, "UIPanelScrollFrameTemplate")
    drScroll:SetPoint("TOPLEFT",     sf, "TOPLEFT",    10, -126)
    drScroll:SetPoint("BOTTOMRIGHT", sf, "BOTTOMRIGHT", -26, 36)

    local drBox = CreateFrame("EditBox", nil, drScroll)
    drBox:SetMultiLine(true)
    drBox:SetAutoFocus(false)
    drBox:SetFontObject("ChatFontNormal")
    drBox:SetWidth(drScroll:GetWidth() or 410)
    drBox:SetScript("OnEscapePressed", function() sf:Hide() end)
    drScroll:SetScrollChild(drBox)
    drScroll:SetScript("OnSizeChanged", function(self, w) drBox:SetWidth(w - 4) end)
    sf.drBox = drBox

    -- Bottom separator + buttons
    local botSep = GoldLine(sf, 1)
    botSep:SetPoint("BOTTOMLEFT",  sf, "BOTTOMLEFT",  2, 30)
    botSep:SetPoint("BOTTOMRIGHT", sf, "BOTTOMRIGHT", -2, 30)

    local function MakeBtn(label, w, anchorRight, offsetX, clickFn)
        local btn = CreateFrame("Button", nil, sf, "BackdropTemplate")
        btn:SetSize(w, 22)
        btn:SetPoint("BOTTOMRIGHT", sf, "BOTTOMRIGHT", offsetX, 5)
        btn:SetBackdrop({
            bgFile = WHITE_TEX, edgeFile = BORDER_TEX, edgeSize = 12,
            insets = { left=3, right=3, top=3, bottom=3 },
        })
        btn:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4])
        btn:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])
        local lbl = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        lbl:SetAllPoints() lbl:SetJustifyH("CENTER")
        lbl:SetText(label)
        btn:SetScript("OnEnter", function() btn:SetBackdropColor(0.25, 0.12, 0.08, 0.95) end)
        btn:SetScript("OnLeave", function() btn:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4]) end)
        btn:SetScript("OnClick", clickFn)
        return btn
    end

    MakeBtn(P.tDim .. "Reset|r",   70, sf, -6,  function() BiSHelper_ResetStatOverrides() end)
    MakeBtn(P.tGold .. "Save|r",   70, sf, -82, function() BiSHelper_SaveStatEdits()      end)

    return sf
end

function BiSHelper_OpenStatsPanel()
    if not BiSHelperStatsFrame then
        BiSHelperStatsFrame = CreateStatsFrame()
    end
    local specData = GetSpecData()
    local modeLabel = activeMode == "raid" and "Raid" or "Mythic+"
    local specLabel = specData and specData.label or "?"
    BiSHelperStatsFrame.titleText:SetText(
        P.tGold .. "Edit Stats|r — " .. P.tCream .. specLabel .. "|r · " .. P.tDim .. modeLabel .. "|r")
    BiSHelperStatsFrame.statBox:SetText(BuildStatText())
    BiSHelperStatsFrame.drBox:SetText(BuildDRText())
    BiSHelperStatsFrame:Show()
end

function BiSHelper_SaveStatEdits()
    if not BiSHelperStatsFrame then return end
    local specKey = GetCurrentDataKey()
    if not specKey then return end
    local stats = ParseStatText(BiSHelperStatsFrame.statBox:GetText())
    local dr    = ParseDRText(BiSHelperStatsFrame.drBox:GetText())
    BiSHelperDB.statOverrides = BiSHelperDB.statOverrides or {}
    BiSHelperDB.statOverrides[specKey] = BiSHelperDB.statOverrides[specKey] or {}
    -- Preserve note from base data
    local specData = GetSpecData()
    local baseNote = specData and specData.statPriority
                     and specData.statPriority[activeMode]
                     and specData.statPriority[activeMode].note
    if #stats > 0 then
        BiSHelperDB.statOverrides[specKey][activeMode] = { stats = stats, note = baseNote }
    else
        BiSHelperDB.statOverrides[specKey][activeMode] = nil
    end
    if #dr > 0 then
        BiSHelperDB.statOverrides[specKey]["dr"] = dr
    else
        BiSHelperDB.statOverrides[specKey]["dr"] = nil
    end
    -- Clean up empty specKey
    local hasAny = false
    for _ in pairs(BiSHelperDB.statOverrides[specKey]) do hasAny = true break end
    if not hasAny then BiSHelperDB.statOverrides[specKey] = nil end
    BiSHelper_Refresh()
    BiSHelperStatsFrame:Hide()
end

function BiSHelper_ResetStatOverrides()
    local specKey = GetCurrentDataKey()
    if not specKey then return end
    if BiSHelperDB.statOverrides and BiSHelperDB.statOverrides[specKey] then
        BiSHelperDB.statOverrides[specKey][activeMode] = nil
        BiSHelperDB.statOverrides[specKey]["dr"]       = nil
        local hasAny = false
        for _ in pairs(BiSHelperDB.statOverrides[specKey]) do hasAny = true break end
        if not hasAny then BiSHelperDB.statOverrides[specKey] = nil end
    end
    BiSHelper_Refresh()
    if BiSHelperStatsFrame and BiSHelperStatsFrame:IsShown() then
        BiSHelperStatsFrame.statBox:SetText(BuildStatText())
        BiSHelperStatsFrame.drBox:SetText(BuildDRText())
    end
end

-- ============================================================
-- Help panel
-- ============================================================
local HELP_TEXT = [[|cff]] .. "f5c842" .. [[BiS Helper|r compares your equipped gear to Best in Slot lists for your spec and current content type.

|cff]] .. "f5c842" .. [[ROW COLORS|r
  |cff4ee050✓|r |cff4ee050green|r — equipped item matches the BiS list
  |cffe63830✗|r |cffe63830red|r   — slot has a different item equipped
  grey            — no BiS data available for this slot

|cff]] .. "f5c842" .. [[COLUMNS|r
  Slot        gear slot name
  Equipped    your current item (hover for tooltip)
  iLvl        item level
  Enchant     enchant applied (hover for tooltip)
  Gems        socketed gems (hover for tooltip)
  Track       upgrade track: Myth / Hero / Champion…
  BiS         match indicator (✓ / ✗)
  BiS Item    recommended item (hover for tooltip)
  Source      where to obtain it

|cff]] .. "f5c842" .. [[BUTTONS|r
  Refresh     re-read your gear from the server
  Share       export or import your BiS profile
  Edit        override the BiS item for any slot
  Stats       edit stat priority order and DR caps
  Filter      hide slots already matching BiS
  Raid / M+   switch between Raid and Mythic+ lists

|cff]] .. "f5c842" .. [[SHARE / EXPORT / IMPORT|r
  Click Share to export your BiS profile as an encoded string.
  Copy it and share via Discord, forums, or save as backup.
  To import: switch to the Import tab, paste the string,
  and click Import Profile.

|cff]] .. "f5c842" .. [[COPY ITEM LINK|r
  Shift+click on item name or icon to get a Wowhead link.
  Shift+Ctrl+click to get the raw Item ID instead.
  Works on both equipped items and BiS items.
  Press Ctrl+C to copy, Escape to close.

|cff]] .. "f5c842" .. [[SLASH COMMAND|r
  /bis        toggle this window]]

local function CreateHelpFrame()
    local hf = CreateFrame("Frame", "BiSHelperHelpFrame", UIParent, "BackdropTemplate")
    hf:SetSize(400, 420)
    hf:SetPoint("CENTER")
    hf:SetMovable(true)
    hf:SetClampedToScreen(true)
    hf:SetFrameStrata("DIALOG")
    hf:EnableMouse(true)
    hf:RegisterForDrag("LeftButton")
    hf:SetScript("OnDragStart", hf.StartMoving)
    hf:SetScript("OnDragStop",  hf.StopMovingOrSizing)
    hf:Hide()

    hf:SetBackdrop({
        bgFile = WHITE_TEX, edgeFile = BORDER_TEX, edgeSize = 16,
        insets = { left=4, right=4, top=4, bottom=4 },
    })
    hf:SetBackdropColor(P.bg[1], P.bg[2], P.bg[3], P.bg[4])
    hf:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])

    local hdrBg = Rect(hf, "BACKGROUND", 2, P.bgHeader[1], P.bgHeader[2], P.bgHeader[3], P.bgHeader[4])
    hdrBg:SetPoint("TOPLEFT",  hf, "TOPLEFT",  1, -1)
    hdrBg:SetPoint("TOPRIGHT", hf, "TOPRIGHT", -1, -1)
    hdrBg:SetHeight(36)
    local hdrSep = GoldLine(hf, 1)
    hdrSep:SetPoint("TOPLEFT",  hf, "TOPLEFT",  2, -36)
    hdrSep:SetPoint("TOPRIGHT", hf, "TOPRIGHT", -2, -36)

    local title = hf:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", hf, "TOPLEFT", 10, -10)
    title:SetText(P.tGold .. "BiS Helper|r — " .. P.tCream .. "How to use|r")

    local closeBtn = CreateFrame("Button", nil, hf, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", hf, "TOPRIGHT", -2, -2)
    closeBtn:SetScript("OnClick", function() hf:Hide() end)

    hf:EnableKeyboard(true)
    hf:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            self:SetPropagateKeyboardInput(false)
            self:Hide()
        else
            self:SetPropagateKeyboardInput(true)
        end
    end)

    local scroll = CreateFrame("ScrollFrame", nil, hf, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT",     hf, "TOPLEFT",    10, -44)
    scroll:SetPoint("BOTTOMRIGHT", hf, "BOTTOMRIGHT", -26, 10)

    local content = CreateFrame("Frame", nil, scroll)
    scroll:SetScrollChild(content)
    scroll:SetScript("OnSizeChanged", function(self, w) content:SetWidth(w) end)

    local bodyText = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    bodyText:SetPoint("TOPLEFT", content, "TOPLEFT", 0, 0)
    bodyText:SetPoint("RIGHT",   content, "RIGHT",   0, 0)
    bodyText:SetJustifyH("LEFT")
    bodyText:SetSpacing(3)
    bodyText:SetText(HELP_TEXT)
    content:SetHeight(bodyText:GetStringHeight() + 20)

    return hf
end

function BiSHelper_OpenHelpPanel()
    if not BiSHelperHelpFrame then
        BiSHelperHelpFrame = CreateHelpFrame()
    end
    if BiSHelperHelpFrame:IsShown() then
        BiSHelperHelpFrame:Hide()
    else
        BiSHelperHelpFrame:Show()
    end
end

-- ============================================================
-- Share panel (export / import)
-- ============================================================
local function CreateShareFrame()
    local sf = CreateFrame("Frame", "BiSHelperShareFrame", UIParent, "BackdropTemplate")
    sf:SetSize(400, 340)
    sf:SetPoint("CENTER")
    sf:SetMovable(true)
    sf:SetClampedToScreen(true)
    sf:SetFrameStrata("DIALOG")
    sf:EnableMouse(true)
    sf:RegisterForDrag("LeftButton")
    sf:SetScript("OnDragStart", sf.StartMoving)
    sf:SetScript("OnDragStop",  sf.StopMovingOrSizing)
    sf:Hide()

    sf:SetBackdrop({
        bgFile = WHITE_TEX, edgeFile = BORDER_TEX, edgeSize = 16,
        insets = { left=4, right=4, top=4, bottom=4 },
    })
    sf:SetBackdropColor(P.bg[1], P.bg[2], P.bg[3], P.bg[4])
    sf:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])

    -- Header (36px)
    local hdrBg = Rect(sf, "BACKGROUND", 2, P.bgHeader[1], P.bgHeader[2], P.bgHeader[3], P.bgHeader[4])
    hdrBg:SetPoint("TOPLEFT",  sf, "TOPLEFT",  1, -1)
    hdrBg:SetPoint("TOPRIGHT", sf, "TOPRIGHT", -1, -1)
    hdrBg:SetHeight(36)
    local hdrSep = GoldLine(sf, 1)
    hdrSep:SetPoint("TOPLEFT",  sf, "TOPLEFT",  2, -36)
    hdrSep:SetPoint("TOPRIGHT", sf, "TOPRIGHT", -2, -36)

    sf.titleText = sf:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sf.titleText:SetPoint("TOPLEFT", sf, "TOPLEFT", 10, -10)
    sf.titleText:SetText(P.tGold .. "Share BiS Profile|r")

    local closeBtn = CreateFrame("Button", nil, sf, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", sf, "TOPRIGHT", -2, -2)
    closeBtn:SetScript("OnClick", function() sf:Hide() end)

    -- Tab state
    local activeTab = "export"

    -- Tab buttons (y: -44)
    local function TabButton(label, tabKey, anchor, anchorPoint, offsetX)
        local btn = CreateFrame("Button", nil, sf, "BackdropTemplate")
        btn:SetSize(80, 22)
        if anchor then
            btn:SetPoint("LEFT", anchor, anchorPoint or "RIGHT", offsetX or 6, 0)
        else
            btn:SetPoint("TOPLEFT", sf, "TOPLEFT", 10, -44)
        end
        btn:SetBackdrop({
            bgFile = WHITE_TEX, edgeFile = BORDER_TEX, edgeSize = 12,
            insets = { left=3, right=3, top=3, bottom=3 },
        })
        local lbl = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        lbl:SetAllPoints()
        lbl:SetJustifyH("CENTER")
        btn.label = label
        btn.tabKey = tabKey
        function btn:UpdateLook()
            if activeTab == tabKey then
                self:SetBackdropColor(0.25, 0.12, 0.08, 0.95)
                self:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], 1.0)
                lbl:SetText(P.tGold .. label .. "|r")
            else
                self:SetBackdropColor(0.08, 0.04, 0.03, 0.90)
                self:SetBackdropBorderColor(P.goldDim[1], P.goldDim[2], P.goldDim[3], 0.6)
                lbl:SetText(P.tDim .. label .. "|r")
            end
        end
        return btn
    end

    local exportTab = TabButton("Export", "export")
    local importTab = TabButton("Import", "import", exportTab, "RIGHT", 4)
    sf.tabs = { exportTab, importTab }

    -- EditBox (multiline, scrollable) — y: -74 to bottom-70
    local editScroll = CreateFrame("ScrollFrame", "BiSHelperShareScroll", sf, "UIPanelScrollFrameTemplate")
    editScroll:SetPoint("TOPLEFT",  sf, "TOPLEFT",  12, -74)
    editScroll:SetPoint("BOTTOMRIGHT", sf, "BOTTOMRIGHT", -30, 70)

    local editBox = CreateFrame("EditBox", "BiSHelperShareEditBox", editScroll)
    editBox:SetMultiLine(true)
    editBox:SetFontObject("ChatFontNormal")
    editBox:SetWidth(354)  -- explicit width; OnSizeChanged will correct after layout
    editBox:SetAutoFocus(false)
    editBox:SetMaxLetters(0)
    editBox:SetTextInsets(4, 4, 4, 4)
    editBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    editScroll:SetScrollChild(editBox)
    editScroll:SetScript("OnSizeChanged", function(self, w) editBox:SetWidth(w - 4) end)
    editScroll:SetScript("OnMouseDown", function()
        if activeTab == "import" then editBox:SetFocus() end
    end)
    sf.editBox = editBox

    -- EditBox background
    local editBg = Rect(sf, "BACKGROUND", 1, 0.08, 0.04, 0.03, 1.00)
    editBg:SetPoint("TOPLEFT",  editScroll, "TOPLEFT",  -4, 4)
    editBg:SetPoint("BOTTOMRIGHT", editScroll, "BOTTOMRIGHT", 20, -4)
    local editBorder = CreateFrame("Frame", nil, sf, "BackdropTemplate")
    editBorder:SetPoint("TOPLEFT",  editBg, "TOPLEFT",  -1, 1)
    editBorder:SetPoint("BOTTOMRIGHT", editBg, "BOTTOMRIGHT", 1, -1)
    editBorder:SetBackdrop({
        edgeFile = BORDER_TEX, edgeSize = 12,
        insets = { left=3, right=3, top=3, bottom=3 },
    })
    editBorder:SetBackdropBorderColor(P.goldDim[1], P.goldDim[2], P.goldDim[3], 1)

    -- Action button (bottom area)
    local actionBtn = CreateFrame("Button", nil, sf, "BackdropTemplate")
    actionBtn:SetSize(120, 24)
    actionBtn:SetPoint("BOTTOMLEFT", sf, "BOTTOMLEFT", 12, 36)
    actionBtn:SetBackdrop({
        bgFile = WHITE_TEX, edgeFile = BORDER_TEX, edgeSize = 12,
        insets = { left=3, right=3, top=3, bottom=3 },
    })
    actionBtn:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4])
    actionBtn:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])
    local actionBtnLbl = actionBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    actionBtnLbl:SetAllPoints()
    actionBtnLbl:SetJustifyH("CENTER")
    actionBtn:SetScript("OnEnter", function() actionBtn:SetBackdropColor(0.25, 0.12, 0.08, 0.95) end)
    actionBtn:SetScript("OnLeave", function() actionBtn:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4]) end)
    sf.actionBtn = actionBtn
    sf.actionBtnLbl = actionBtnLbl

    -- Status line
    local statusText = sf:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    statusText:SetPoint("BOTTOMLEFT", sf, "BOTTOMLEFT", 12, 14)
    statusText:SetPoint("RIGHT", sf, "RIGHT", -12, 0)
    statusText:SetJustifyH("LEFT")
    statusText:SetText("")
    sf.statusText = statusText

    -- === Tab switching logic ===

    local exportString = nil  -- stored export text for read-only protection

    -- Prevent editing in export mode while allowing Ctrl+C / Ctrl+A
    editBox:SetScript("OnTextChanged", function(self, isUserInput)
        if activeTab == "export" and isUserInput and exportString then
            self:SetText(exportString)
            self:HighlightText()
        end
    end)

    local function ShowExportTab()
        activeTab = "export"
        for _, tab in ipairs(sf.tabs) do tab:UpdateLook() end

        exportString = nil
        editBox:SetText("")
        editBox:EnableKeyboard(true)
        actionBtnLbl:SetText(P.tGold .. "Select All|r")
        statusText:SetText("")

        -- Generate export string
        local profile = BuildExportProfile()
        if profile then
            local encoded = EncodeProfile(profile)
            exportString = encoded
            editBox:SetText(encoded)
            editBox:SetFocus()
            editBox:HighlightText()
            local specData = GetSpecData()
            local specLabel = specData and specData.label or profile.key
            statusText:SetText(P.tDim .. "Profile exported for " .. specLabel .. " (both modes)|r")
        else
            editBox:SetText("")
            statusText:SetText(P.tMissing .. "No data to export for current spec|r")
        end
    end
    sf.ShowExportTab = ShowExportTab

    local function ShowImportTab()
        activeTab = "import"
        exportString = nil
        for _, tab in ipairs(sf.tabs) do tab:UpdateLook() end

        editBox:SetText("")
        editBox:EnableKeyboard(true)
        editBox:EnableMouse(true)
        editBox:SetFocus()
        actionBtnLbl:SetText(P.tGold .. "Import Profile|r")
        statusText:SetText(P.tDim .. "Paste an encoded profile string above|r")
    end

    local function DoImport(profileData)
        local specKey = profileData.key

        -- Apply items → stored as overrides so they take priority over base data
        if profileData.items then
            BiSHelperDB.overrides = BiSHelperDB.overrides or {}
            BiSHelperDB.overrides[specKey] = profileData.items
        end

        -- Apply stats → stored as stat overrides
        if profileData.stats then
            BiSHelperDB.statOverrides = BiSHelperDB.statOverrides or {}
            BiSHelperDB.statOverrides[specKey] = profileData.stats
        end

        -- Count what was imported
        local counts = {}
        if profileData.items then
            local n = 0
            for _, slots in pairs(profileData.items) do
                for _ in pairs(slots) do n = n + 1 end
            end
            if n > 0 then counts[#counts + 1] = n .. " items" end
        end
        if profileData.stats then
            if profileData.stats.raid or profileData.stats.mythicplus then
                counts[#counts + 1] = "stat priority"
            end
            if profileData.stats.dr then
                counts[#counts + 1] = "DR caps"
            end
        end

        BiSHelper_Refresh()
        statusText:SetText(P.tBiS .. "Imported: " .. table.concat(counts, " + ") .. "|r")
    end

    local function TryImport()
        local raw = Trim(editBox:GetText())
        if raw == "" then
            statusText:SetText(P.tMissing .. "Paste a profile string first|r")
            return
        end
        local profileData, err = DecodeProfile(raw)
        if not profileData then
            statusText:SetText(P.tMissing .. err .. "|r")
            return
        end
        local currentKey = GetCurrentDataKey()
        local specKey = profileData.key

        local function ConfirmAndImport()
            StaticPopupDialogs["BISHELPER_IMPORT_CONFIRM"].OnAccept = function()
                DoImport(profileData)
            end
            StaticPopup_Show("BISHELPER_IMPORT_CONFIRM", specKey)
        end

        if currentKey and specKey ~= currentKey then
            StaticPopupDialogs["BISHELPER_IMPORT_SPECWARN"].OnAccept = function()
                ConfirmAndImport()
            end
            StaticPopup_Show("BISHELPER_IMPORT_SPECWARN", specKey, currentKey)
        else
            ConfirmAndImport()
        end
    end

    -- Tab click handlers
    exportTab:SetScript("OnClick", ShowExportTab)
    importTab:SetScript("OnClick", ShowImportTab)

    -- Action button click
    actionBtn:SetScript("OnClick", function()
        if activeTab == "export" then
            editBox:HighlightText()
            editBox:SetFocus()
        else
            TryImport()
        end
    end)

    -- ESC to close
    sf:EnableKeyboard(true)
    sf:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            self:SetPropagateKeyboardInput(false)
            self:Hide()
        else
            self:SetPropagateKeyboardInput(true)
        end
    end)

    -- Initialize to export tab
    ShowExportTab()

    return sf
end

function BiSHelper_OpenSharePanel()
    if not BiSHelperShareFrame then
        BiSHelperShareFrame = CreateShareFrame()
    end
    if BiSHelperShareFrame:IsShown() then
        BiSHelperShareFrame:Hide()
    else
        BiSHelperShareFrame:Show()
        -- Re-trigger export tab to refresh data
        BiSHelperShareFrame.ShowExportTab()
    end
end

-- ============================================================
-- Row filter (hide BiS-complete rows)
-- ============================================================
local function ApplyRowFilter()
    if not BiSHelperFrame or not BiSHelperFrame.rows then return end
    local filterActive = BiSHelperDB and BiSHelperDB.filterMissing
    local visiblePos = 0
    for _, row in ipairs(BiSHelperFrame.rows) do
        if filterActive and row.lastStatus == "bis" then
            row:Hide()
        else
            row:Show()
            row:ClearAllPoints()
            row:SetPoint("TOPLEFT",  BiSHelperFrame.scrollContent, "TOPLEFT",  0, -visiblePos * ROW_H)
            row:SetPoint("TOPRIGHT", BiSHelperFrame.scrollContent, "TOPRIGHT", 0, -visiblePos * ROW_H)
            visiblePos = visiblePos + 1
        end
    end
    BiSHelperFrame.scrollContent:SetHeight(math.max(visiblePos, 1) * ROW_H)
    if BiSHelperFrame.filterBtn then
        BiSHelperFrame.filterBtn.updateLook()
    end
end

-- ============================================================
-- Main window — builder helpers
-- ============================================================
local function ToolbarBtn(frame, label, width, tooltip)
    local btn = CreateFrame("Button", nil, frame, "BackdropTemplate")
    btn:SetSize(width, 22)
    btn:SetBackdrop({
        bgFile = WHITE_TEX, edgeFile = BORDER_TEX, edgeSize = 12,
        insets = { left=3, right=3, top=3, bottom=3 },
    })
    btn:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4])
    btn:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])
    local lbl = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    lbl:SetAllPoints()
    lbl:SetJustifyH("CENTER")
    lbl:SetText(P.tGold .. label .. "|r")
    btn.label = lbl
    btn:SetScript("OnEnter", function(self)
        btn:SetBackdropColor(0.25, 0.12, 0.08, 0.95)
        if tooltip then
            GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
            GameTooltip:SetText(tooltip)
            GameTooltip:Show()
        end
    end)
    btn:SetScript("OnLeave", function()
        btn:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4])
        if tooltip then GameTooltip:Hide() end
    end)
    return btn
end

local function ToolbarSep(frame, anchorBtn)
    local sep = Rect(frame, "ARTWORK", 3, P.gold[1], P.gold[2], P.gold[3], 0.45)
    sep:SetSize(1, 16)
    sep:SetPoint("LEFT", anchorBtn, "RIGHT", 8, 0)
    return sep
end

local function ModeButton(frame, label, mode, anchor, anchorPoint, offsetX)
    local btn = CreateFrame("Button", nil, frame, "BackdropTemplate")
    btn:SetSize(64, 22)
    btn:SetPoint("LEFT", anchor, anchorPoint or "RIGHT", offsetX or 4, 0)
    btn:SetBackdrop({
        bgFile   = WHITE_TEX, edgeFile = BORDER_TEX, edgeSize = 12,
        insets   = { left=3, right=3, top=3, bottom=3 },
    })
    local lbl = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    lbl:SetAllPoints()
    lbl:SetJustifyH("CENTER")
    local function UpdateLook()
        if activeMode == mode then
            btn:SetBackdropColor(0.25, 0.12, 0.08, 0.95)
            btn:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], 1.0)
            lbl:SetText(P.tGold .. label .. "|r")
        else
            btn:SetBackdropColor(0.08, 0.04, 0.03, 0.90)
            btn:SetBackdropBorderColor(P.goldDim[1], P.goldDim[2], P.goldDim[3], 0.6)
            lbl:SetText(P.tDim .. label .. "|r")
        end
    end
    btn:SetScript("OnClick", function()
        activeMode = mode
        BiSHelperDB.mode = mode
        for _, b in ipairs(frame.modeButtons) do b.updateLook() end
        BiSHelper_Refresh()
    end)
    btn.updateLook = UpdateLook
    UpdateLook()
    return btn
end

local COL_Y_OFFSET = -(HEADER_H + 6)

local function ColHeader(frame, text, x, w, align, rightAnchor)
    local fs = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    if rightAnchor then
        fs:SetPoint("TOPRIGHT", frame, "TOPRIGHT", rightAnchor, COL_Y_OFFSET)
    else
        fs:SetPoint("TOPLEFT", frame, "TOPLEFT", x, COL_Y_OFFSET)
    end
    fs:SetWidth(w)
    fs:SetJustifyH(align or "LEFT")
    fs:SetText(P.tGold .. text .. "|r")
    return fs
end

-- ── Creates the base frame: size, drag, resize, backdrop ────
local function CreateFrameBase()
    local frame = CreateFrame("Frame", "BiSHelperFrame", UIParent, "BackdropTemplate")
    tinsert(UISpecialFrames, "BiSHelperFrame")
    local db = BiSHelperDB or {}
    frame:SetSize(db.width or 700, db.height or 590)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:SetResizable(true)
    if frame.SetResizeBounds then
        frame:SetResizeBounds(600, 400, 2000, 2000)
    else
        pcall(function() frame:SetMinResize(600, 400) end)
    end
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        BiSHelperDB.point, _, BiSHelperDB.relPoint, BiSHelperDB.x, BiSHelperDB.y = self:GetPoint()
    end)
    frame:SetClampedToScreen(true)
    frame:SetFrameStrata("HIGH")
    frame:Hide()

    local resizer = CreateFrame("Button", nil, frame)
    resizer:SetSize(20, 20)
    resizer:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
    resizer:SetFrameLevel(frame:GetFrameLevel() + 10)
    resizer:SetNormalTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Up")
    resizer:SetHighlightTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Highlight")
    resizer:SetPushedTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Down")
    resizer:SetScript("OnMouseDown", function() frame:StartSizing("BOTTOMRIGHT") end)
    resizer:SetScript("OnMouseUp", function()
        frame:StopMovingOrSizing()
        BiSHelperDB.width, BiSHelperDB.height = frame:GetSize()
    end)

    frame:SetBackdrop({
        bgFile   = WHITE_TEX,
        edgeFile = BORDER_TEX,
        edgeSize = 16,
        insets   = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    frame:SetBackdropColor(P.bg[1], P.bg[2], P.bg[3], P.bg[4])
    frame:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])

    return frame
end

-- ── Creates the header: glow, bg, title, spec label, stat bars ──
local function CreateFrameHeader(frame)
    local topGlow = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
    topGlow:SetPoint("TOPLEFT",  frame, "TOPLEFT",  1, -1)
    topGlow:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -1)
    topGlow:SetHeight(HEADER_H + 20)
    if topGlow.SetGradient then
        topGlow:SetGradient("VERTICAL", CreateColor(0.70, 0.14, 0.14, 0.15), CreateColor(0.70, 0.14, 0.14, 0.0))
    end

    local hdrBg = Rect(frame, "BACKGROUND", 2, P.bgHeader[1], P.bgHeader[2], P.bgHeader[3], P.bgHeader[4])
    hdrBg:SetPoint("TOPLEFT",  frame, "TOPLEFT",  1, -1)
    hdrBg:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -1)
    hdrBg:SetHeight(HEADER_H)

    local hdrSep = GoldLine(frame, 1)
    hdrSep:SetPoint("TOPLEFT",  frame, "TOPLEFT",  2, -HEADER_H)
    hdrSep:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -HEADER_H)

    frame.titleText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.titleText:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -10)
    frame.titleText:SetText(P.tGold .. "BiS Helper|r")

    frame.specLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.specLabel:SetPoint("LEFT", frame.titleText, "RIGHT", 8, -1)
    frame.specLabel:SetText("")

    local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -2)
    closeBtn:SetScript("OnClick", function() frame:Hide() end)

    frame.statBarContainer = CreateFrame("Frame", nil, frame)
    frame.statBarContainer:SetPoint("TOPLEFT",  frame, "TOPLEFT",  14, -60)
    frame.statBarContainer:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -14, -60)
    frame.statBarContainer:SetHeight(66)
end

-- ── Creates the toolbar: Filter, Refresh, mode buttons, panel buttons ──
local function CreateToolbar(frame)
    local TOOLBAR_Y = -34

    local filterBtn = ToolbarBtn(frame, "Filter", 50, "Show only slots missing BiS item")
    filterBtn:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, TOOLBAR_Y)
    local filterBtnLbl = filterBtn.label
    local function UpdateFilterLook()
        if BiSHelperDB and BiSHelperDB.filterMissing then
            filterBtn:SetBackdropColor(0.25, 0.12, 0.08, 0.95)
            filterBtn:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], 1.0)
            filterBtnLbl:SetText(P.tGold .. "Filter|r")
        else
            filterBtn:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4])
            filterBtn:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])
            filterBtnLbl:SetText(P.tDim .. "Filter|r")
        end
    end
    filterBtn.updateLook = UpdateFilterLook
    UpdateFilterLook()
    filterBtn:SetScript("OnEnter", function(self)
        filterBtn:SetBackdropColor(0.25, 0.12, 0.08, 0.95)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Show only slots missing BiS item")
        GameTooltip:Show()
    end)
    filterBtn:SetScript("OnLeave", function()
        UpdateFilterLook()
        GameTooltip:Hide()
    end)
    filterBtn:SetScript("OnClick", function()
        BiSHelperDB.filterMissing = not BiSHelperDB.filterMissing
        UpdateFilterLook()
        ApplyRowFilter()
    end)
    frame.filterBtn = filterBtn

    local refreshBtn = ToolbarBtn(frame, "Refresh", 60, "Reload gear data from player")
    refreshBtn:SetPoint("LEFT", filterBtn, "RIGHT", 4, 0)
    refreshBtn:SetScript("OnClick", function() BiSHelper_Refresh() end)

    local sep1 = ToolbarSep(frame, refreshBtn)

    local btnRaid  = ModeButton(frame, "Raid",    "raid",       sep1,    "RIGHT", 8)
    local btnMplus = ModeButton(frame, "Mythic+", "mythicplus", btnRaid, "RIGHT", 4)
    frame.modeButtons = { btnRaid, btnMplus }

    ToolbarSep(frame, btnMplus)

    local helpBtn = ToolbarBtn(frame, "?", 22, "Show help & feature overview")
    helpBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -10, TOOLBAR_Y)
    helpBtn:SetScript("OnClick", function() BiSHelper_OpenHelpPanel() end)

    local shareBtn = ToolbarBtn(frame, "Share", 50, "Export or import BiS profile")
    shareBtn:SetPoint("RIGHT", helpBtn, "LEFT", -4, 0)
    shareBtn:SetScript("OnClick", function() BiSHelper_OpenSharePanel() end)

    local editBtn = ToolbarBtn(frame, "Edit", 42, "Customize BiS items per slot")
    editBtn:SetPoint("RIGHT", shareBtn, "LEFT", -4, 0)
    editBtn:SetScript("OnClick", function() BiSHelper_OpenEditPanel() end)

    local statsBtn = ToolbarBtn(frame, "Stats", 50, "Edit stat priority & DR caps")
    statsBtn:SetPoint("RIGHT", editBtn, "LEFT", -4, 0)
    statsBtn:SetScript("OnClick", function() BiSHelper_OpenStatsPanel() end)
end

-- ── Creates column headers and their separators ──────────────
local function CreateColumnHeaders(frame)
    ColHeader(frame, "Slot",      38,  64,  "LEFT")
    ColHeader(frame, "Equipped",  80,  120, "LEFT")
    ColHeader(frame, "iLvl",      206,  34, "RIGHT")
    ColHeader(frame, "Enchant",   248,  130, "LEFT")
    ColHeader(frame, "Gems",      382,  44, "LEFT")
    ColHeader(frame, "Track",     432,  72, "LEFT")
    ColHeader(frame, "BiS",       510,  24, "CENTER")
    ColHeader(frame, "BiS Item",  538,  130, "LEFT")
    ColHeader(frame, "Source",    nil,  132, "LEFT", -50)

    local colSep = Rect(frame, "ARTWORK", 1, P.goldDim[1], P.goldDim[2], P.goldDim[3], P.goldDim[4])
    colSep:SetHeight(1)
    colSep:SetPoint("TOPLEFT",  frame, "TOPLEFT",  2, -(HEADER_H + 20))
    colSep:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -(HEADER_H + 20))

    -- Vertical separator between equipped columns and BiS columns (x=506)
    local vColSep = Rect(frame, "ARTWORK", 2, P.gold[1], P.gold[2], P.gold[3], 0.45)
    vColSep:SetWidth(2)
    vColSep:SetPoint("TOP",    frame, "TOPLEFT", 506, -(HEADER_H + 2))
    vColSep:SetPoint("BOTTOM", frame, "TOPLEFT", 506, -(HEADER_H + 22))
end

-- ── Creates the scroll frame and all gear rows ───────────────
local function CreateRowPool(frame)
    local SCROLL_TOP = HEADER_H + 24
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT",     frame, "TOPLEFT",    2, -SCROLL_TOP)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -26, 28)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetHeight(#SLOTS * ROW_H)
    scrollFrame:SetScrollChild(content)
    scrollFrame:SetScript("OnSizeChanged", function(self, w) content:SetWidth(w) end)
    frame.scrollContent = content

    frame.rows = {}
    for i, slot in ipairs(SLOTS) do
        local row = CreateFrame("Frame", nil, content)
        row:SetHeight(ROW_H)
        row:SetPoint("TOPLEFT",  content, "TOPLEFT",  0, -(i - 1) * ROW_H)
        row:SetPoint("TOPRIGHT", content, "TOPRIGHT", 0, -(i - 1) * ROW_H)
        row.slotId = slot.id

        local cardBg = Rect(row, "BACKGROUND", 0, i % 2 == 0 and P.bgCard[1] or P.bgCardAlt[1], i % 2 == 0 and P.bgCard[2] or P.bgCardAlt[2], i % 2 == 0 and P.bgCard[3] or P.bgCardAlt[3], i % 2 == 0 and P.bgCard[4] or P.bgCardAlt[4])
        cardBg:SetAllPoints()

        local glowBg = Rect(row, "BACKGROUND", 1, 0, 0, 0, 0)
        glowBg:SetAllPoints()
        row.glowBg = glowBg

        local accent = Rect(row, "ARTWORK", 1, P.neonGrey[1], P.neonGrey[2], P.neonGrey[3], 0.6)
        accent:SetWidth(4)
        accent:SetPoint("TOPLEFT", row, "TOPLEFT", 0, 0)
        accent:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 0)
        row.accent = accent

        local sep = Rect(row, "ARTWORK", 0, P.goldDim[1], P.goldDim[2], P.goldDim[3], P.goldDim[4])
        sep:SetHeight(1)
        sep:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 3, 0)
        sep:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)

        local vSep = Rect(row, "ARTWORK", 1, P.gold[1], P.gold[2], P.gold[3], 0.25)
        vSep:SetWidth(2)
        vSep:SetPoint("TOP",    row, "TOPLEFT",    506, -2)
        vSep:SetPoint("BOTTOM", row, "BOTTOMLEFT", 506,  2)

        local function ShowItemTooltip(self)
            local link = GetInventoryItemLink("player", row.slotId)
            if link then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink(link)
                GameTooltip:Show()
            end
        end

        local iconBorder = CreateFrame("Frame", nil, row)
        iconBorder:SetSize(24, 24)
        iconBorder:SetPoint("LEFT", row, "LEFT", 6, 0)
        iconBorder:EnableMouse(true)
        iconBorder:SetScript("OnEnter", ShowItemTooltip)
        iconBorder:SetScript("OnLeave", function() GameTooltip:Hide() end)
        iconBorder:SetScript("OnMouseDown", function(self, button)
            if button == "LeftButton" and IsShiftKeyDown() then
                local link = GetInventoryItemLink("player", row.slotId)
                local itemID = link and GetItemIDFromLink(link)
                if itemID then
                    ShowCopyPopup(self, itemID, IsControlKeyDown())
                end
            end
        end)
        local iconBgTex = Rect(iconBorder, "ARTWORK", 0, P.goldDim[1], P.goldDim[2], P.goldDim[3], 0.70)
        iconBgTex:SetAllPoints()
        local icon = iconBorder:CreateTexture(nil, "ARTWORK", nil, 1)
        icon:SetSize(22, 22)
        icon:SetPoint("CENTER", iconBorder, "CENTER")
        icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        row.icon = icon
        row.iconBorder = iconBgTex

        local slotLabel = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        slotLabel:SetPoint("LEFT", row, "LEFT", 36, 0)
        slotLabel:SetWidth(44)
        slotLabel:SetJustifyH("LEFT")
        slotLabel:SetText(P.tDim .. slot.label .. "|r")

        local eqBtn = CreateFrame("Button", nil, row)
        eqBtn:SetSize(122, 20)
        eqBtn:SetPoint("LEFT", row, "LEFT", 78, 0)
        eqBtn:SetScript("OnEnter", ShowItemTooltip)
        eqBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
        eqBtn:SetScript("OnMouseDown", function(self, button)
            if button == "LeftButton" and IsShiftKeyDown() then
                local link = GetInventoryItemLink("player", row.slotId)
                local itemID = link and GetItemIDFromLink(link)
                if itemID then
                    ShowCopyPopup(self, itemID, IsControlKeyDown())
                end
            end
        end)
        local eqText = eqBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        eqText:SetAllPoints()
        eqText:SetJustifyH("LEFT")
        eqText:SetWordWrap(false)
        row.equippedName = eqText

        local ilvlBg = Rect(row, "ARTWORK", 0, 0.15, 0.08, 0.06, 0.85)
        ilvlBg:SetSize(34, 16)
        ilvlBg:SetPoint("LEFT", row, "LEFT", 204, 0)
        local ilvlText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        ilvlText:SetPoint("CENTER", ilvlBg, "CENTER")
        ilvlText:SetWidth(32)
        ilvlText:SetJustifyH("CENTER")
        row.ilvlText = ilvlText
        row.ilvlBg   = ilvlBg

        local enchantText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        enchantText:SetPoint("LEFT", row, "LEFT", 246, 0)
        enchantText:SetWidth(130)
        enchantText:SetJustifyH("LEFT")
        enchantText:SetWordWrap(false)
        row.enchantText = enchantText

        local function ShowEnchantTooltip(self)
            if row.enchantID and tonumber(row.enchantID) > 0 then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                -- Try to show the specific enchant tooltip
                GameTooltip:SetHyperlink("enchant:" .. row.enchantID)
                -- If the tooltip is empty (some enchants don't have standalone data), fallback to item
                if GameTooltip:NumLines() <= 1 then
                    local link = GetInventoryItemLink("player", row.slotId)
                    if link then GameTooltip:SetHyperlink(link) end
                end
                GameTooltip:Show()
            else
                ShowItemTooltip(self)
            end
        end

        local enchantHover = CreateFrame("Frame", nil, row)
        enchantHover:SetPoint("TOPLEFT", enchantText, "TOPLEFT")
        enchantHover:SetPoint("BOTTOMRIGHT", enchantText, "BOTTOMRIGHT")
        enchantHover:EnableMouse(true)
        enchantHover:SetScript("OnEnter", ShowEnchantTooltip)
        enchantHover:SetScript("OnLeave", function() GameTooltip:Hide() end)

        local gemContainer = CreateFrame("Frame", nil, row)
        gemContainer:SetSize(44, 18)
        gemContainer:SetPoint("LEFT", row, "LEFT", 380, 0)
        row.gemIcons = {}
        for j = 1, 3 do
            local f = CreateFrame("Frame", nil, gemContainer)
            f:SetSize(16, 16)
            f:SetPoint("LEFT", (j-1)*14, 0)
            f:EnableMouse(true)
            local g = f:CreateTexture(nil, "OVERLAY")
            g:SetAllPoints()
            g:SetTexCoord(0.08, 0.92, 0.08, 0.92)
            f:SetScript("OnEnter", function(self)
                if self.gemLink then
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetHyperlink(self.gemLink)
                    GameTooltip:Show()
                end
            end)
            f:SetScript("OnLeave", function() GameTooltip:Hide() end)
            f.tex = g
            row.gemIcons[j] = f
        end

        local trackText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        trackText:SetPoint("LEFT", row, "LEFT", 430, 0)
        trackText:SetWidth(72)
        trackText:SetJustifyH("LEFT")
        row.trackText = trackText

        local bisStatus = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        bisStatus:SetPoint("CENTER", row, "LEFT", 520, 0)
        bisStatus:SetWidth(24)
        bisStatus:SetJustifyH("CENTER")
        row.bisStatus = bisStatus

        local sourceText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        sourceText:SetPoint("RIGHT", row, "RIGHT", -24, 0)
        sourceText:SetWidth(132)
        sourceText:SetJustifyH("LEFT")
        row.sourceText = sourceText

        local bisName = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        bisName:SetPoint("LEFT", row, "LEFT", 536, 0)
        bisName:SetPoint("RIGHT", sourceText, "LEFT", -10, 0)
        bisName:SetJustifyH("LEFT")
        row.bisName = bisName

        local bisHover = CreateFrame("Frame", nil, row)
        bisHover:SetPoint("TOPLEFT", bisName, "TOPLEFT")
        bisHover:SetPoint("BOTTOMRIGHT", bisName, "BOTTOMRIGHT")
        bisHover:EnableMouse(true)
        bisHover:SetScript("OnEnter", function(self)
            if self.bisItemID then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink("item:" .. self.bisItemID)
                GameTooltip:Show()
            end
        end)
        bisHover:SetScript("OnLeave", function() GameTooltip:Hide() end)
        bisHover:SetScript("OnMouseDown", function(self, button)
            if button == "LeftButton" and IsShiftKeyDown() then
                local itemID = row.bisItemID
                if itemID then
                    ShowCopyPopup(self, itemID, IsControlKeyDown())
                end
            end
        end)
        row.bisHover = bisHover

        frame.rows[i] = row
    end
end

-- ── Creates the footer progress bar ──────────────────────────
local function CreateFooter(frame)
    local footer = CreateFrame("Frame", nil, frame)
    footer:SetPoint("BOTTOMLEFT",  frame, "BOTTOMLEFT",  6, 4)
    footer:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -6, 4)
    footer:SetHeight(18)

    local footerTrack = footer:CreateTexture(nil, "BACKGROUND")
    footerTrack:SetAllPoints()
    footerTrack:SetColorTexture(0.08, 0.04, 0.03, 0.90)

    local footerFill = footer:CreateTexture(nil, "ARTWORK")
    footerFill:SetPoint("TOPLEFT")
    footerFill:SetPoint("BOTTOMLEFT")
    footerFill:SetWidth(1)
    footerFill:SetColorTexture(P.neonGreen[1], P.neonGreen[2], P.neonGreen[3], 0.45)

    local footerLabel = footer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    footerLabel:SetAllPoints()
    footerLabel:SetJustifyH("CENTER")
    footerLabel:SetJustifyV("MIDDLE")

    frame.footerBar   = footer
    frame.footerFill  = footerFill
    frame.footerLabel = footerLabel
end

-- ============================================================
-- Main window assembly
-- ============================================================
local function CreateMainFrame()
    local frame = CreateFrameBase()
    CreateFrameHeader(frame)
    CreateToolbar(frame)
    CreateColumnHeaders(frame)
    CreateRowPool(frame)
    CreateFooter(frame)
    return frame
end

-- ============================================================
-- Rebuild stat priority display in header
-- ============================================================
local function RebuildStatBars()
    local container = BiSHelperFrame.statBarContainer
    if not BiSHelperFrame.statPriorityText then
        local fs = CreateFrame("Frame", nil, container)
        fs:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
        fs:SetPoint("RIGHT",   container, "RIGHT",   0, 0)
        fs:SetHeight(18)
        fs:EnableMouse(true)
        local text = fs:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetAllPoints()
        text:SetJustifyH("LEFT")
        BiSHelperFrame.statPriorityText = text
        fs:SetScript("OnEnter", function(self)
            local sp = GetActiveStatData()
            if sp then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:AddLine(P.tGold .. "Stat Priority Details|r")
                GameTooltip:AddLine(" ")
                local current = sp[activeMode]
                if current and current.note then GameTooltip:AddLine(current.note, 1, 1, 1, true) end
                GameTooltip:Show()
            end
        end)
        fs:SetScript("OnLeave", function() GameTooltip:Hide() end)
    end
    if not BiSHelperFrame.statNoteText then
        local fn = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        fn:SetPoint("TOPLEFT", BiSHelperFrame.statPriorityText, "BOTTOMLEFT", 0, -2)
        fn:SetPoint("RIGHT",   container, "RIGHT", -80, 0)
        fn:SetJustifyH("LEFT")
        BiSHelperFrame.statNoteText = fn
    end
    if not BiSHelperFrame.drBarPool then
        BiSHelperFrame.drBarPool = {}
    end
    if not BiSHelperFrame.statSourceLabel then
        local src = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        src:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", 0, 0)
        src:SetText(P.tDim .. "Source: Wowhead|r")
        BiSHelperFrame.statSourceLabel = src
    end

    local sp = GetActiveStatData()
    if not sp then
        BiSHelperFrame.statPriorityText:SetText("")
        BiSHelperFrame.statNoteText:SetText("")
        for _, bar in ipairs(BiSHelperFrame.drBarPool) do bar:Hide() end
        return
    end

    local current = sp[activeMode]
    if not current or not current.stats then
        BiSHelperFrame.statPriorityText:SetText("")
        BiSHelperFrame.statNoteText:SetText("")
        for _, bar in ipairs(BiSHelperFrame.drBarPool) do bar:Hide() end
        return
    end
    local parts = {}
    for _, stat in ipairs(current.stats) do
        local hex = string.format("|cff%02x%02x%02x", math.floor(stat.r * 255), math.floor(stat.g * 255), math.floor(stat.b * 255))
        parts[#parts + 1] = hex .. stat.name .. "|r"
        if stat.op then parts[#parts + 1] = P.tDim .. " " .. stat.op .. " |r" end
    end
    BiSHelperFrame.statPriorityText:SetText(table.concat(parts))
    BiSHelperFrame.statNoteText:SetText(P.tDim .. (current.note or "") .. "|r")

    -- Hide all existing DR bars first
    for _, bar in ipairs(BiSHelperFrame.drBarPool) do bar:Hide() end

    if sp.dr then
        -- Expand compound entries (e.g. "Crit / Mastery") into individual bars
        local expanded = {}
        for _, d in ipairs(sp.dr) do
            local entries = ExpandDREntry(d)
            for _, e in ipairs(entries) do expanded[#expanded + 1] = e end
        end

        local BAR_H    = 12
        local barCount = #expanded
        if barCount == 0 then return end
        -- Calculate total width and per-bar width (horizontal layout)
        local totalW   = container:GetWidth()
        if not totalW or totalW < 100 then totalW = 500 end
        local barGapH  = 6
        local barW     = math.max((totalW - (barCount - 1) * barGapH) / barCount, 40)

        for i, d in ipairs(expanded) do
            local bar = BiSHelperFrame.drBarPool[i]
            if not bar then
                bar = CreateFrame("Frame", nil, container, "BackdropTemplate")
                bar.track = bar:CreateTexture(nil, "BACKGROUND")
                bar.track:SetAllPoints()
                bar.track:SetColorTexture(0.10, 0.05, 0.04, 0.90)
                bar.fill = bar:CreateTexture(nil, "ARTWORK")
                bar.fill:SetPoint("TOPLEFT")
                bar.fill:SetPoint("BOTTOMLEFT")
                bar.label = bar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                bar.label:SetAllPoints()
                bar.label:SetJustifyH("CENTER")
                bar.label:SetJustifyV("MIDDLE")
                bar:EnableMouse(true)
                bar:SetScript("OnEnter", function(self)
                    if self.tooltipText then
                        GameTooltip:SetOwner(self, "ANCHOR_TOP")
                        GameTooltip:AddLine(self.tooltipText)
                        GameTooltip:Show()
                    end
                end)
                bar:SetScript("OnLeave", function() GameTooltip:Hide() end)
                BiSHelperFrame.drBarPool[i] = bar
            end

            -- Position: horizontal row below stat note
            bar:ClearAllPoints()
            bar:SetSize(barW, BAR_H)
            local xOff = (i - 1) * (barW + barGapH)
            bar:SetPoint("BOTTOMLEFT", container, "BOTTOMLEFT", xOff, 14)

            -- Get current player rating
            local playerRating = 0
            if d.crId then
                playerRating = math.floor((GetCombatRating(d.crId) or 0) + 0.5)
            end
            local ratio = (d.rating and d.rating > 0) and math.min(playerRating / d.rating, 1.0) or 0

            -- Fill bar
            bar.fill:SetWidth(math.max(barW * ratio, 1))
            local alpha = 0.70
            if ratio >= 1.0 then alpha = 0.95 end
            bar.fill:SetColorTexture(d.r, d.g, d.b, alpha)

            -- Label: "Haste: 1180/1320"
            local hex = string.format("|cff%02x%02x%02x", math.floor(d.r * 255), math.floor(d.g * 255), math.floor(d.b * 255))
            local pct = math.floor(ratio * 100)
            bar.label:SetText(hex .. d.name .. ": " .. playerRating .. "/" .. d.rating .. "|r")
            bar.tooltipText = hex .. d.name .. "|r — " .. playerRating .. " / " .. d.rating .. " (" .. pct .. "%)"
                .. (ratio >= 1.0 and "  |cff4ee050CAPPED|r" or "")

            bar:Show()
        end
    end
end

local pendingItems = {}

local function SetRowVisualStatus(row, status)
    row.lastStatus = status
    local c
    if     status == "bis"     then c = P.neonGreen
    elseif status == "missing" then c = P.neonRed
    else                            c = P.neonGrey end
    row.accent:SetColorTexture(c[1], c[2], c[3], 0.85)
    if status == "bis" then
        row.glowBg:SetColorTexture(P.glowGreen[1], P.glowGreen[2], P.glowGreen[3], P.glowGreen[4])
        row.bisStatus:SetText("|cff4ee050✓|r")
    elseif status == "missing" then
        row.glowBg:SetColorTexture(P.glowRed[1], P.glowRed[2], P.glowRed[3], P.glowRed[4])
        row.bisStatus:SetText("|cffe63830✗|r")
    else
        row.glowBg:SetColorTexture(0, 0, 0, 0)
        row.bisStatus:SetText("")
    end
end

local function UpdateRow(rowIndex, slotId)
    local row      = BiSHelperFrame.rows[rowIndex]
    local bisList  = GetActiveBiSList()
    local bisEntry = bisList and bisList[slotId]
    local link     = GetInventoryItemLink("player", slotId)

    if link then
        local _, _, _, _, iconTex = C_Item.GetItemInfoInstant(link)
        if iconTex then row.icon:SetTexture(iconTex) row.iconBorder:SetColorTexture(P.gold[1], P.gold[2], P.gold[3], 0.70) end
    else
        row.icon:SetTexture("Interface/ICONS/INV_Misc_QuestionMark")
        row.iconBorder:SetColorTexture(P.goldDim[1], P.goldDim[2], P.goldDim[3], 0.35)
    end

    if link then
        local name, _, quality, ilvl = C_Item.GetItemInfo(link)
        if name then
            local col = QUALITY_HEX[quality] or QUALITY_HEX[1]
            row.equippedName:SetText(col .. name .. "|r")
            if ilvl and ilvl > 0 then
                row.ilvlText:SetText(P.tGold .. ilvl .. "|r")
                row.ilvlBg:SetColorTexture(0.15, 0.08, 0.06, 0.85)
            else
                row.ilvlText:SetText("")
                row.ilvlBg:SetColorTexture(0, 0, 0, 0)
            end
        else
            row.equippedName:SetText(P.tDim .. "loading…|r")
            row.ilvlText:SetText("")
            row.ilvlBg:SetColorTexture(0, 0, 0, 0)
            pendingItems[link] = { rowIndex = rowIndex, slotId = slotId }
        end
    else
        row.equippedName:SetText(P.tDim .. "— empty —|r")
        row.ilvlText:SetText("")
        row.ilvlBg:SetColorTexture(0, 0, 0, 0)
    end

    local track = GetItemTrack(link)
    if track then
        local tc = TRACK_COLOR[track] or P.tDim
        row.trackText:SetText(tc .. track .. " Track|r")
    else
        row.trackText:SetText(link and P.tDim .. "—|r" or "")
    end

    local enchant, gems = GetItemEnchantAndGems(slotId)
    row.enchantText:SetText(link and (enchant and "|cff1eff00" .. enchant .. "|r" or P.tDim .. "—|r") or "")
    
    -- Store enchantID for the tooltip
    if link then
        row.enchantID = link:match("item:%d+:(%d+)")
    else
        row.enchantID = nil
    end

    for j = 1, 3 do
        if gems and gems[j] then
            row.gemIcons[j].tex:SetTexture(gems[j].icon)
            row.gemIcons[j].gemLink = gems[j].link
            row.gemIcons[j]:Show()
        else
            row.gemIcons[j].gemLink = nil
            row.gemIcons[j]:Hide()
        end
    end

    if not bisEntry then
        SetRowVisualStatus(row, "none")
        row.bisName:SetText("")
        row.sourceText:SetText("")
        row.bisHover.bisItemID = nil
        row.bisItemID = nil
        return
    end

    local src = bisEntry.source or ""
    if src == "Crafted" then row.sourceText:SetText("|cff1eff00" .. src .. "|r")
    elseif src == "Tier Set" or src == "Catalyst" then row.sourceText:SetText("|cffffcc00" .. src .. "|r")
    else row.sourceText:SetText(P.tDim .. src .. "|r") end

    local equippedID = GetItemIDFromLink(link)
    if equippedID == bisEntry.itemID then
        SetRowVisualStatus(row, "bis")
        row.bisName:SetText("")
        row.bisHover.bisItemID = nil
        row.bisItemID = bisEntry.itemID
    else
        SetRowVisualStatus(row, "missing")
        row.bisName:SetText(P.tMissing .. bisEntry.name .. "|r")
        row.bisHover.bisItemID = bisEntry.itemID
        row.bisItemID = bisEntry.itemID
    end
end

function BiSHelper_Refresh()
    if not BiSHelperFrame then return end
    wipe(pendingItems)
    local specData = GetSpecData()
    if specData then
        BiSHelperFrame.specLabel:SetText(P.tCream .. specData.label .. "|r")
        RebuildStatBars()
    else
        BiSHelperFrame.specLabel:SetText("|cffff4444No BiS data for: " .. (GetCurrentDataKey() or "unknown") .. "|r")
        RebuildStatBars()
    end
    if BiSHelperFrame.modeButtons then for _, b in ipairs(BiSHelperFrame.modeButtons) do b.updateLook() end end
    for i, slot in ipairs(SLOTS) do UpdateRow(i, slot.id) end

    -- Update footer BiS progress bar
    local bisList = GetActiveBiSList()
    local bisCount, totalCount = 0, 0
    if bisList then
        for _, slot in ipairs(SLOTS) do
            if bisList[slot.id] then
                totalCount = totalCount + 1
                local link = GetInventoryItemLink("player", slot.id)
                local equippedID = link and GetItemIDFromLink(link)
                if equippedID == bisList[slot.id].itemID then
                    bisCount = bisCount + 1
                end
            end
        end
    end
    if BiSHelperFrame.footerBar then
        if totalCount > 0 then
            local ratio = bisCount / totalCount
            local fw = BiSHelperFrame.footerBar:GetWidth()
            if not fw or fw < 10 then fw = 400 end
            BiSHelperFrame.footerFill:SetWidth(math.max(fw * ratio, 1))
            local pct = math.floor(ratio * 100)
            if ratio >= 1.0 then
                BiSHelperFrame.footerLabel:SetText(P.tBiS .. "Full BiS! " .. bisCount .. "/" .. totalCount .. " ✓|r")
                BiSHelperFrame.footerFill:SetColorTexture(P.neonGreen[1], P.neonGreen[2], P.neonGreen[3], 0.50)
            else
                BiSHelperFrame.footerLabel:SetText(P.tGold .. bisCount .. "/" .. totalCount .. " BiS|r  " .. P.tDim .. "(" .. pct .. "%)|r")
                -- Blend color: low = red-ish, high = green-ish
                local r = 1.0 - ratio * 0.8
                local g = 0.25 + ratio * 0.70
                BiSHelperFrame.footerFill:SetColorTexture(r, g, 0.30, 0.45)
            end
            BiSHelperFrame.footerBar:Show()
        else
            BiSHelperFrame.footerLabel:SetText(P.tDim .. "No BiS data|r")
            BiSHelperFrame.footerFill:SetWidth(1)
            BiSHelperFrame.footerBar:Show()
        end
    end
    ApplyRowFilter()
end

-- ============================================================
-- Minimap button
-- ============================================================
local minimapButton

local function UpdateMinimapButtonPosition()
    local angle = math.rad(BiSHelperDB.minimapPos or 225)
    minimapButton:ClearAllPoints()
    minimapButton:SetPoint("CENTER", Minimap, "CENTER", math.cos(angle) * 80, math.sin(angle) * 80)
end

local function CreateMinimapButton()
    minimapButton = CreateFrame("Button", "BiSHelperMinimapButton", Minimap)
    minimapButton:SetFrameStrata("MEDIUM")
    minimapButton:SetSize(31, 31)
    minimapButton:SetFrameLevel(8)
    minimapButton:RegisterForClicks("AnyUp")
    minimapButton:RegisterForDrag("LeftButton")
    minimapButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    local overlay = minimapButton:CreateTexture(nil, "OVERLAY")
    overlay:SetSize(53, 53)
    overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    overlay:SetPoint("TOPLEFT")

    local background = minimapButton:CreateTexture(nil, "BACKGROUND")
    background:SetSize(24, 24)
    background:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
    background:SetPoint("CENTER", minimapButton, "CENTER", 0, 1)

    local icon = minimapButton:CreateTexture(nil, "ARTWORK")
    icon:SetSize(20, 20)
    icon:SetPoint("CENTER", minimapButton, "CENTER", 0, 1)
    icon:SetTexture("Interface\\AddOns\\BiS_Helper\\icon")
    icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)

    minimapButton:SetScript("OnClick", function(_, button)
        if button == "LeftButton" then
            if not BiSHelperFrame then return end
            if BiSHelperFrame:IsShown() then
                BiSHelperFrame:Hide()
            else
                BiSHelper_Refresh()
                BiSHelperFrame:Show()
            end
        end
    end)

    minimapButton:SetScript("OnDragStart", function(self)
        self:SetScript("OnUpdate", function()
            local mx, my = Minimap:GetCenter()
            local cx, cy = GetCursorPosition()
            local scale  = Minimap:GetEffectiveScale()
            local angle  = math.atan2(cy / scale - my, cx / scale - mx)
            BiSHelperDB.minimapPos = math.deg(angle) % 360
            self:ClearAllPoints()
            self:SetPoint("CENTER", Minimap, "CENTER", math.cos(angle) * 80, math.sin(angle) * 80)
        end)
    end)

    minimapButton:SetScript("OnDragStop", function(self)
        self:SetScript("OnUpdate", nil)
    end)

    minimapButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_NONE")
        GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
        GameTooltip:AddLine("BiS Helper", P.gold[1], P.gold[2], P.gold[3])
        GameTooltip:AddLine("Click to open/close", 0.8, 0.8, 0.8)
        GameTooltip:Show()
    end)

    minimapButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    UpdateMinimapButtonPosition()
end

-- ============================================================
-- Addon Compartment callbacks
-- ============================================================
function BiSHelper_OnAddonCompartmentClick(_, button)
    if not BiSHelperFrame then return end
    if BiSHelperFrame:IsShown() then
        BiSHelperFrame:Hide()
    else
        BiSHelper_Refresh()
        BiSHelperFrame:Show()
    end
end

function BiSHelper_OnAddonCompartmentEnter(_, f)
    GameTooltip:SetOwner(f, "ANCHOR_LEFT")
    GameTooltip:AddLine("BiS Helper", P.gold[1], P.gold[2], P.gold[3])
    GameTooltip:AddLine("Click to open/close", 0.8, 0.8, 0.8)
    GameTooltip:Show()
end

function BiSHelper_OnAddonCompartmentLeave()
    GameTooltip:Hide()
end

-- ============================================================
-- Import confirmation dialogs
-- ============================================================
StaticPopupDialogs["BISHELPER_IMPORT_SPECWARN"] = {
    text = "This profile is for %s but you are %s.\n\nImport anyway?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function() end,  -- replaced at runtime
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

StaticPopupDialogs["BISHELPER_IMPORT_CONFIRM"] = {
    text = "This will overwrite your current overrides for %s.\n\nContinue?",
    button1 = "Import",
    button2 = "Cancel",
    OnAccept = function() end,  -- replaced at runtime
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
eventFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
eventFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED")

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...
        if name == ADDON_NAME then
            BiSHelperDB = BiSHelperDB or {}
            BiSHelperDB.overrides      = BiSHelperDB.overrides     or {}
            BiSHelperDB.statOverrides  = BiSHelperDB.statOverrides or {}
            if BiSHelperDB.filterMissing == nil then BiSHelperDB.filterMissing = false end
            activeMode  = BiSHelperDB.mode or "mythicplus"
            BiSHelperFrame = CreateMainFrame()
            CreateMinimapButton()
            if BiSHelperDB.point and BiSHelperDB.x and BiSHelperDB.y then
                BiSHelperFrame:ClearAllPoints()
                pcall(function() BiSHelperFrame:SetPoint(BiSHelperDB.point, UIParent, BiSHelperDB.relPoint or BiSHelperDB.point, BiSHelperDB.x, BiSHelperDB.y) end)
            end
        end
    elseif event == "PLAYER_LOGIN" or event == "PLAYER_SPECIALIZATION_CHANGED" then
        C_Timer.After(0.5, function() if BiSHelperFrame then BiSHelper_Refresh() end end)
    elseif event == "PLAYER_EQUIPMENT_CHANGED" then
        local slotId = ...
        if BiSHelperFrame and BiSHelperFrame:IsShown() then
            for i, slot in ipairs(SLOTS) do if slot.id == slotId then UpdateRow(i, slotId) break end end
        end
    elseif event == "GET_ITEM_INFO_RECEIVED" then
        local itemID, success = ...
        if not success then
            -- Item failed to load; drop any deferred work waiting on it to prevent leaks.
            pendingOverrideNames[itemID] = nil
            if BiSHelperEditFrame and BiSHelperEditFrame.pendingAdd == itemID then
                BiSHelperEditFrame.pendingAdd = nil
            end
            return
        end
        local resolved = {}
        for link, data in pairs(pendingItems) do
            if C_Item.GetItemInfo(link) then resolved[link] = data end
        end
        for link, data in pairs(resolved) do
            pendingItems[link] = nil
            UpdateRow(data.rowIndex, data.slotId)
        end
        -- Resolve deferred override names
        if pendingOverrideNames[itemID] then
            local d    = pendingOverrideNames[itemID]
            local name = C_Item.GetItemInfo(itemID)
            if name then
                pendingOverrideNames[itemID] = nil
                if BiSHelperDB.overrides
                   and BiSHelperDB.overrides[d.specKey]
                   and BiSHelperDB.overrides[d.specKey][d.mode]
                   and BiSHelperDB.overrides[d.specKey][d.mode][d.slotId] then
                    BiSHelperDB.overrides[d.specKey][d.mode][d.slotId].name = name
                    BiSHelper_Refresh()
                    if BiSHelperEditFrame and BiSHelperEditFrame:IsShown() then RebuildOverrideRows() end
                end
            end
        end
        -- Process deferred item add (item wasn't cached when user typed ID)
        if BiSHelperEditFrame and BiSHelperEditFrame.pendingAdd == itemID then
            BiSHelperEditFrame.pendingAdd = nil
            ProcessAddItem(itemID)
        end
    end
end)

SLASH_BISHELPER1 = "/bis"
SlashCmdList["BISHELPER"] = function()
    if not BiSHelperFrame then return end
    if BiSHelperFrame:IsShown() then BiSHelperFrame:Hide() else BiSHelper_Refresh() BiSHelperFrame:Show() end
end
