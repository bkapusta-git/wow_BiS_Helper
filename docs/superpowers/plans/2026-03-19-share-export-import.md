# Share / Export / Import Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add export/import of BiS profiles (overrides + stat overrides + DR caps) as encoded strings via a new Share panel.

**Architecture:** All code goes into the single existing file `addon/BiS_Helper.lua`. New sections: serialization utilities (Serialize/Deserialize + Base64), `CreateShareFrame()` panel builder, `BiSHelper_OpenSharePanel()` global function, Share button in main frame header, two `StaticPopupDialogs` for import confirmations.

**Tech Stack:** WoW Lua API (11.1 / Interface 120001), no external dependencies.

**Spec:** `docs/superpowers/specs/2026-03-19-share-export-import-design.md`

**Testing:** No test framework — verify in-game via `/reload`. Each task includes manual verification steps.

---

## File Structure

Only one file is modified:

- **Modify:** `addon/BiS_Helper.lua`
  - New code sections inserted at specific locations (detailed per task)
  - No new files created

**Insertion points in `BiS_Helper.lua` (1991 lines currently):**

| What | Insert after | Approx. line |
|------|-------------|--------------|
| Serialize + Base64 utilities | `GoldLine()` helper (line 197), before `activeMode` declaration | ~197 |
| `CreateShareFrame()` + `BiSHelper_OpenSharePanel()` | `BiSHelper_OpenHelpPanel()` (line 985), before `ApplyRowFilter` section | ~985 |
| `StaticPopupDialogs` | Before `eventFrame` (line 1927) | ~1927 |
| Share button in `CreateMainFrame()` | After `editBtn` definition (line 1173), before `statsBtn` | ~1173 |

---

## Task 1: Base64 encode/decode utilities

**Files:**
- Modify: `addon/BiS_Helper.lua:197` — insert after `GoldLine()` function

**Why first:** Both serialize and share panel depend on base64. Pure utility, no dependencies.

- [ ] **Step 1: Add Base64 encode/decode functions**

Insert after line 197 (after `GoldLine` function, before `local activeMode`):

```lua
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
```

- [ ] **Step 2: Verify in-game**

After `/reload`, run in `/script`:
```
/script local e=Base64Encode("Hello BiS") print(e) print(Base64Decode(e))
```
Note: These are local functions, so for quick testing wrap in a temporary global or use `print(BiSHelper_TestB64())` with a temp test function. Remove test function before commit.

- [ ] **Step 3: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(share): add Base64 encode/decode utilities"
```

---

## Task 2: Lua table serializer / deserializer

**Files:**
- Modify: `addon/BiS_Helper.lua` — insert right after Base64 functions (from Task 1)

**Why second:** Share panel needs serialize/deserialize to encode profile data.

- [ ] **Step 1: Add Serialize function**

Insert after Base64Decode, before `local activeMode`:

```lua
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
```

- [ ] **Step 2: Add Deserialize function (custom parser)**

Insert right after Serialize:

```lua
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
                        -- val should be a string used as identifier — but in our format
                        -- string keys always use ["key"]= so this branch handles bare identifiers
                        -- which we don't emit, so treat as error and fall through
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
```

- [ ] **Step 3: Verify in-game**

Temporary test (remove before commit):
```lua
/script local t={version=1,key="TEST",items={[1]={name="Helm",id=123}}} local s=Serialize(t) print(s) local d=Deserialize(s) print(d.key, d.items[1].name)
```

- [ ] **Step 4: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(share): add Lua table serializer and deserializer"
```

---

## Task 3: Profile export/import encode/decode helpers

**Files:**
- Modify: `addon/BiS_Helper.lua` — insert after Deserialize (from Task 2), before `local activeMode`

**Why third:** These compose Base64 + Serialize into the `!BH1!` prefixed format used by the UI.

- [ ] **Step 1: Add EncodeProfile and DecodeProfile functions**

```lua
local SHARE_PREFIX = "!BH1!"

local function EncodeProfile(profileTable)
    local serialized = Serialize(profileTable)
    return SHARE_PREFIX .. Base64Encode(serialized)
end

local function DecodeProfile(encoded)
    if type(encoded) ~= "string" then return nil, "Invalid input" end
    encoded = strtrim(encoded)
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
    local hasOverrides = tbl.overrides and (next(tbl.overrides) ~= nil)
    local hasStats = tbl.statOverrides and (next(tbl.statOverrides) ~= nil)
    if not hasOverrides and not hasStats then
        return nil, "Nothing to import — profile is empty"
    end
    return tbl, nil
end
```

- [ ] **Step 2: Add BuildExportProfile helper**

This gathers current spec's overrides + statOverrides into the export table:

```lua
local function BuildExportProfile()
    local specKey = GetCurrentDataKey()
    if not specKey then return nil end
    local specData = GetSpecData()
    local profile = {
        version = 1,
        key = specKey,
    }
    -- Gather item overrides (both modes)
    local ov = BiSHelperDB.overrides and BiSHelperDB.overrides[specKey]
    if ov then
        profile.overrides = {}
        if ov.raid and next(ov.raid) then profile.overrides.raid = ov.raid end
        if ov.mythicplus and next(ov.mythicplus) then profile.overrides.mythicplus = ov.mythicplus end
        if not next(profile.overrides) then profile.overrides = nil end
    end
    -- Gather stat overrides (both modes + dr)
    local so = BiSHelperDB.statOverrides and BiSHelperDB.statOverrides[specKey]
    if so then
        profile.statOverrides = {}
        if so.raid then profile.statOverrides.raid = so.raid end
        if so.mythicplus then profile.statOverrides.mythicplus = so.mythicplus end
        if so.dr then profile.statOverrides.dr = so.dr end
        if not next(profile.statOverrides) then profile.statOverrides = nil end
    end
    -- Return nil if nothing to export
    if not profile.overrides and not profile.statOverrides then return nil end
    return profile
end
```

- [ ] **Step 3: Verify in-game**

```
/script local p=BuildExportProfile() if p then print(EncodeProfile(p):sub(1,80).."...") else print("no overrides") end
```

- [ ] **Step 4: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(share): add profile encode/decode with !BH1! prefix"
```

---

## Task 4: StaticPopupDialogs for import confirmations

**Files:**
- Modify: `addon/BiS_Helper.lua` — insert before `local eventFrame` line (~1927)

- [ ] **Step 1: Add two StaticPopupDialogs**

Insert before `local eventFrame = CreateFrame("Frame")`:

```lua
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
```

- [ ] **Step 2: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(share): add StaticPopupDialogs for import confirmations"
```

---

## Task 5: CreateShareFrame and BiSHelper_OpenSharePanel

**Files:**
- Modify: `addon/BiS_Helper.lua` — insert after `BiSHelper_OpenHelpPanel()` (~line 985), before `ApplyRowFilter` section

This is the largest task. The panel follows the same patterns as `CreateEditFrame()` and `CreateHelpFrame()`.

- [ ] **Step 1: Add CreateShareFrame function**

Insert after `BiSHelper_OpenHelpPanel()` closing `end`, before the `-- Row filter` comment block:

```lua
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
        bgFile = WHITE_TEX, edgeFile = WHITE_TEX, edgeSize = 1,
        insets = { left=1, right=1, top=1, bottom=1 },
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
            bgFile = WHITE_TEX, edgeFile = WHITE_TEX, edgeSize = 1,
            insets = { left=1, right=1, top=1, bottom=1 },
        })
        local lbl = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        lbl:SetAllPoints()
        lbl:SetJustifyH("CENTER")
        btn.label = label
        btn.tabKey = tabKey
        function btn:UpdateLook()
            if activeTab == tabKey then
                self:SetBackdropColor(0.20, 0.10, 0.38, 0.95)
                self:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], 1.0)
                lbl:SetText(P.tGold .. label .. "|r")
            else
                self:SetBackdropColor(0.06, 0.02, 0.14, 0.90)
                self:SetBackdropBorderColor(P.goldDim[1], P.goldDim[2], P.goldDim[3], 0.6)
                lbl:SetText(P.tDim .. label .. "|r")
            end
        end
        return btn
    end

    local exportTab = TabButton("Export", "export")
    local importTab = TabButton("Import", "import", exportTab, "RIGHT", 4)
    sf.tabs = { exportTab, importTab }

    -- EditBox (multiline, scrollable) — y: -74 to -260
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
    sf.editBox = editBox

    -- EditBox background
    local editBg = Rect(sf, "BACKGROUND", 1, 0.06, 0.02, 0.14, 1.00)
    editBg:SetPoint("TOPLEFT",  editScroll, "TOPLEFT",  -4, 4)
    editBg:SetPoint("BOTTOMRIGHT", editScroll, "BOTTOMRIGHT", 20, -4)
    local editBorder = CreateFrame("Frame", nil, sf, "BackdropTemplate")
    editBorder:SetPoint("TOPLEFT",  editBg, "TOPLEFT",  -1, 1)
    editBorder:SetPoint("BOTTOMRIGHT", editBg, "BOTTOMRIGHT", 1, -1)
    editBorder:SetBackdrop({
        edgeFile = WHITE_TEX, edgeSize = 1,
        insets = { left=1, right=1, top=1, bottom=1 },
    })
    editBorder:SetBackdropBorderColor(P.goldDim[1], P.goldDim[2], P.goldDim[3], 1)

    -- Action button (bottom area)
    local actionBtn = CreateFrame("Button", nil, sf, "BackdropTemplate")
    actionBtn:SetSize(120, 24)
    actionBtn:SetPoint("BOTTOMLEFT", sf, "BOTTOMLEFT", 12, 36)
    actionBtn:SetBackdrop({
        bgFile = WHITE_TEX, edgeFile = WHITE_TEX, edgeSize = 1,
        insets = { left=1, right=1, top=1, bottom=1 },
    })
    actionBtn:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4])
    actionBtn:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])
    local actionBtnLbl = actionBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    actionBtnLbl:SetAllPoints()
    actionBtnLbl:SetJustifyH("CENTER")
    actionBtn:SetScript("OnEnter", function() actionBtn:SetBackdropColor(0.20, 0.10, 0.38, 0.95) end)
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

    local function ShowExportTab()
        activeTab = "export"
        for _, tab in ipairs(sf.tabs) do tab:UpdateLook() end

        editBox:SetText("")
        editBox:EnableKeyboard(false)
        actionBtnLbl:SetText(P.tGold .. "Select All|r")
        statusText:SetText("")

        -- Generate export string
        local profile = BuildExportProfile()
        if profile then
            local encoded = EncodeProfile(profile)
            editBox:SetText(encoded)
            editBox:SetFocus()
            editBox:HighlightText()
            local specData = GetSpecData()
            local specLabel = specData and specData.label or profile.key
            statusText:SetText(P.tDim .. "Profile exported for " .. specLabel .. " (both modes)|r")
        else
            editBox:SetText("")
            statusText:SetText(P.tMissing .. "No overrides to export for current spec|r")
        end
    end
    sf.ShowExportTab = ShowExportTab

    local function ShowImportTab()
        activeTab = "import"
        for _, tab in ipairs(sf.tabs) do tab:UpdateLook() end

        editBox:SetText("")
        editBox:EnableKeyboard(true)
        editBox:EnableMouse(true)
        actionBtnLbl:SetText(P.tGold .. "Import Profile|r")
        statusText:SetText(P.tDim .. "Paste an encoded profile string above|r")
    end

    local function DoImport(profileData)
        local specKey = profileData.key
        -- Apply item overrides
        if profileData.overrides then
            BiSHelperDB.overrides[specKey] = BiSHelperDB.overrides[specKey] or {}
            if profileData.overrides.raid then
                BiSHelperDB.overrides[specKey].raid = profileData.overrides.raid
            end
            if profileData.overrides.mythicplus then
                BiSHelperDB.overrides[specKey].mythicplus = profileData.overrides.mythicplus
            end
        end
        -- Apply stat overrides
        if profileData.statOverrides then
            BiSHelperDB.statOverrides[specKey] = BiSHelperDB.statOverrides[specKey] or {}
            if profileData.statOverrides.raid then
                BiSHelperDB.statOverrides[specKey].raid = profileData.statOverrides.raid
            end
            if profileData.statOverrides.mythicplus then
                BiSHelperDB.statOverrides[specKey].mythicplus = profileData.statOverrides.mythicplus
            end
            if profileData.statOverrides.dr then
                BiSHelperDB.statOverrides[specKey].dr = profileData.statOverrides.dr
            end
        end
        -- Count what was imported
        local counts = {}
        if profileData.overrides then
            local n = 0
            for mode, slots in pairs(profileData.overrides) do
                for _ in pairs(slots) do n = n + 1 end
            end
            if n > 0 then counts[#counts + 1] = n .. " item override" .. (n > 1 and "s" or "") end
        end
        if profileData.statOverrides then
            if profileData.statOverrides.raid or profileData.statOverrides.mythicplus then
                counts[#counts + 1] = "stat priority"
            end
            if profileData.statOverrides.dr then
                counts[#counts + 1] = "DR caps"
            end
        end
        BiSHelper_Refresh()
        statusText:SetText(P.tBiS .. "Imported: " .. table.concat(counts, " + ") .. "|r")
    end

    local function TryImport()
        local raw = strtrim(editBox:GetText())
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
    tinsert(UISpecialFrames, "BiSHelperShareFrame")

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
```

- [ ] **Step 2: Verify in-game**

```
/script BiSHelper_OpenSharePanel()
```

Check:
- Panel opens centered, Midnight theme, gold border
- Export tab is active, EditBox shows encoded string (or "No overrides" if none)
- Switching to Import tab clears EditBox, makes it editable
- Switching back to Export regenerates the string
- ESC closes panel
- Draggable
- Select All button works on Export tab

- [ ] **Step 3: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(share): add Share panel with export/import tabs"
```

---

## Task 6: Add Share button to main frame header

**Files:**
- Modify: `addon/BiS_Helper.lua` — inside `CreateMainFrame()`, between `btnGroupSep` and `editBtn` (~lines 1144-1150)

**Current anchor chain (right to left, visually):**
```
[X close] [Refresh] | [Raid] [Mythic+] |sep| [Edit] [Stats] [?]     [Filter]
                                              ^editBtn anchored RIGHT=btnMplus LEFT -4
                                         ^sep CENTER=btnMplus LEFT -6
```

**Target anchor chain:**
```
[X close] [Refresh] | [Raid] [Mythic+] |sep| [Share] [Edit] [Stats] [?]     [Filter]
                                               ^shareBtn RIGHT=btnMplus LEFT -14
                                          ^sep stays CENTER=btnMplus LEFT -6
                                                       ^editBtn RIGHT=shareBtn LEFT -4
```

- [ ] **Step 1: Add shareBtn and update editBtn anchor**

Three precise edits inside `CreateMainFrame()`:

**Edit A:** Insert the shareBtn block AFTER the `btnGroupSep` definition (after line ~1146, after `btnGroupSep:SetSize(1, 16)` + `SetPoint`) and BEFORE the `editBtn` block:

```lua
    local shareBtn = CreateFrame("Button", nil, frame, "BackdropTemplate")
    shareBtn:SetSize(50, 22)
    shareBtn:SetPoint("RIGHT", btnMplus, "LEFT", -14, 0)
    shareBtn:SetBackdrop({
        bgFile   = WHITE_TEX, edgeFile = WHITE_TEX, edgeSize = 1,
        insets   = { left=1, right=1, top=1, bottom=1 },
    })
    shareBtn:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4])
    shareBtn:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])
    local shareBtnLbl = shareBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    shareBtnLbl:SetAllPoints()
    shareBtnLbl:SetJustifyH("CENTER")
    shareBtnLbl:SetText(P.tGold .. "Share|r")
    shareBtn:SetScript("OnEnter", function(self)
        shareBtn:SetBackdropColor(0.20, 0.10, 0.38, 0.95)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText("Export or import BiS profile")
        GameTooltip:Show()
    end)
    shareBtn:SetScript("OnLeave", function()
        shareBtn:SetBackdropColor(P.bgCard[1], P.bgCard[2], P.bgCard[3], P.bgCard[4])
        GameTooltip:Hide()
    end)
    shareBtn:SetScript("OnClick", function() BiSHelper_OpenSharePanel() end)
```

**Edit B:** Change editBtn anchor. Find this line:
```lua
    editBtn:SetPoint("RIGHT", btnMplus, "LEFT", -4, 0)
```
Replace with:
```lua
    editBtn:SetPoint("RIGHT", shareBtn, "LEFT", -4, 0)
```

The `btnGroupSep` stays unchanged — it's already at `CENTER, btnMplus, "LEFT", -6, 0` which visually sits between shareBtn (right edge at -14) and btnMplus (left edge at 0).

- [ ] **Step 2: Verify in-game**

```
/reload
```

Check:
- Share button visible between separator and Edit
- All buttons still fit at default 700px width
- Hover shows tooltip "Export or import BiS profile"
- Click opens Share panel

- [ ] **Step 3: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(share): add Share button to main frame header"
```

---

## Task 7: Update Help panel text

**Files:**
- Modify: `addon/BiS_Helper.lua` — find `HELP_TEXT` constant and add Share feature description

- [ ] **Step 1: Update HELP_TEXT and BUTTONS section**

In the BUTTONS section of `HELP_TEXT` (line ~912-916), add "Share" and "Filter" entries. Find:

```lua
  Refresh     re-read your gear from the server
  Edit        override the BiS item for any slot
  Stats       edit stat priority order and DR caps
  Raid / M+   switch between Raid and Mythic+ lists
```

Replace with:

```lua
  Refresh     re-read your gear from the server
  Share       export or import your BiS profile
  Edit        override the BiS item for any slot
  Stats       edit stat priority order and DR caps
  Filter      hide slots already matching BiS
  Raid / M+   switch between Raid and Mythic+ lists
```

Then add a new section BEFORE `SLASH COMMAND` (after line ~917):

```lua
|cff]] .. "f5d258" .. [[SHARE / EXPORT / IMPORT|r
  Click Share to export your BiS profile as an encoded string.
  Copy it and share via Discord, forums, or save as backup.
  To import: switch to the Import tab, paste the string,
  and click Import Profile.
```

- [ ] **Step 2: Verify in-game**

Open Help panel (`?` button) and verify the Share section appears.

- [ ] **Step 3: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(share): add Share section to Help panel"
```

---

## Task 8: Copy addon to WoW directory and final verification

**Files:** None modified — deployment and testing only.

- [ ] **Step 1: Copy addon files**

```bash
cp -r "D:/Workspace/wow_addon/BiS_Helper/addon/." "/d/World of Warcraft/_retail_/Interface/AddOns/BiS_Helper/"
```

- [ ] **Step 2: Full verification in-game**

After `/reload`, verify:

1. **Share button** visible in header bar, correct position
2. **Export tab**:
   - Opens with encoded string (if overrides exist) or "No overrides" message
   - Select All button highlights text
   - Ctrl+C copies text
3. **Import tab**:
   - EditBox editable, can paste
   - Invalid string → error message in status line
   - Valid string from different spec → spec mismatch warning popup
   - Valid string → overwrite confirmation popup → data applied
   - Status line shows import summary
4. **Round-trip**: Export → copy string → switch to Import → paste → import → verify overrides intact
5. **ESC closes** Share panel
6. **No Lua errors** in BugSack/BugGrabber
7. **Other panels** (Edit, Stats, Help, Filter) still work correctly

- [ ] **Step 3: Commit any final fixes if needed**

```bash
git add addon/BiS_Helper.lua
git commit -m "fix(share): address issues found during testing"
```
