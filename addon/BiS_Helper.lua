print("|cff00ccff[BiS Helper]|r Loading file...")
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

local QUALITY_HEX = {
    [0] = "|cff9d9d9d", [1] = "|cffffffff", [2] = "|cff1eff00",
    [3] = "|cff0070dd", [4] = "|cffa335ee", [5] = "|cffff8000",
    [6] = "|cffe6cc80", [7] = "|cff0cf2d2",
}

-- ============================================================
-- Color palette — Midnight / void-purple & ethereal gold
-- ============================================================
local P = {
    -- Backgrounds
    bg          = { 0.04, 0.01, 0.10, 0.97 },
    bgCard      = { 0.08, 0.03, 0.17, 1.00 },
    bgCardAlt   = { 0.05, 0.01, 0.12, 1.00 },
    bgHeader    = { 0.10, 0.03, 0.22, 1.00 },
    -- Borders
    gold        = { 0.78, 0.66, 0.29, 0.90 },
    goldDim     = { 0.45, 0.36, 0.14, 0.45 },
    -- Status neon bars
    neonGreen   = { 0.00, 0.95, 0.50, 1.00 },
    neonRed     = { 0.95, 0.25, 0.25, 1.00 },
    neonGrey    = { 0.22, 0.16, 0.32, 1.00 },
    glowGreen   = { 0.00, 0.95, 0.50, 0.18 },
    glowRed     = { 0.95, 0.25, 0.25, 0.14 },
    -- Text (as hex strings)
    tGold       = "|cfff5d258",
    tLavender   = "|cffcdb8ff",
    tDim        = "|cff8877aa",
    tWhite      = "|cffece5ff",
    tBiS        = "|cff00f280",
    tMissing    = "|cffff4040",
}

local WHITE_TEX = "Interface/Buttons/WHITE8X8"
local ROW_H     = 30
local HEADER_H  = 112

-- Gear track colours (highest → lowest)
local TRACK_COLOR = {
    ["Myth"]       = "|cffff8c00",
    ["Hero"]       = "|cffa335ee",
    ["Champion"]   = "|cff0070dd",
    ["Veteran"]    = "|cff1eff00",
    ["Adventurer"] = "|cffaaaaaa",
    ["Explorer"]   = "|cff888888",
}

-- Hidden tooltip used to scan item data (track, etc.)
local scanTooltip = CreateFrame("GameTooltip", "BiSHelperScanTooltip", nil, "GameTooltipTemplate")
scanTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

-- Scan tooltip lines for "X Track" pattern
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
                for trackName, _ in pairs(TRACK_COLOR) do
                    if text:find(trackName) then return trackName end
                end
            end
        end
    end
    return nil
end

-- Extracts enchant name and gem icons from item link/tooltip
local function GetItemEnchantAndGems(slotId)
    local link = GetInventoryItemLink("player", slotId)
    if not link then return nil, nil end

    local enchantID = link:match("item:%d+:(%d+)")
    enchantID = tonumber(enchantID)

    local enchantName = nil
    local gems = {}

    if enchantID and enchantID > 0 then
        scanTooltip:ClearLines()
        pcall(function() scanTooltip:SetHyperlink(link) end)
        
        local fmt = _G.ITEM_ENCHANT_FORMAT or "Enchanted: %s"
        local enchantPrefix = fmt:gsub("%%s", ""):lower()

        for i = 1, scanTooltip:NumLines() do
            local line = _G["BiSHelperScanTooltipTextLeft" .. i]
            if line then
                local r, g, b = line:GetTextColor()
                local text = line:GetText()
                if text and r < 0.1 and g > 0.9 and b < 0.1 then
                    local textLower = text:lower()
                    if textLower:find(enchantPrefix) or (not text:find("+") and #text < 45 and not text:find("Set:") and not text:find("%(")) then
                        -- Remove prefix case-insensitively and clean punctuation
                        local startPos, endPos = textLower:find(enchantPrefix)
                        if endPos then enchantName = text:sub(endPos + 1) else enchantName = text end
                        enchantName = enchantName:match("^%s*[:%-]?%s*(.-)%s*$") or enchantName
                        enchantName = enchantName:gsub("Enchant [^%-]+ %- ", "")
                        enchantName = enchantName:gsub("Enchant ", "")
                        break
                    end
                end
            end
        end
    end

    for i = 1, 3 do
        local _, gemLink = _G.GetItemGem(link, i)
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

local activeMode = "mythicplus"

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
    return spec.content and spec.content[activeMode]
end

local function GetItemIDFromLink(link)
    if not link then return nil end
    return tonumber(link:match("|Hitem:(%d+):"))
end

-- ============================================================
-- Main window
-- ============================================================
local function CreateMainFrame()
    local frame = CreateFrame("Frame", "BiSHelperFrame", UIParent, "BackdropTemplate")
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
    frame:SetFrameStrata("MEDIUM")
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
        edgeFile = WHITE_TEX,
        edgeSize = 1,
        insets   = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    frame:SetBackdropColor(P.bg[1], P.bg[2], P.bg[3], P.bg[4])
    frame:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])

    local topGlow = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
    topGlow:SetPoint("TOPLEFT",  frame, "TOPLEFT",  1, -1)
    topGlow:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -1)
    topGlow:SetHeight(HEADER_H + 20)
    if topGlow.SetGradient then
        topGlow:SetGradient("VERTICAL", CreateColor(0.20, 0.06, 0.40, 0.50), CreateColor(0.04, 0.01, 0.10, 0.00))
    end

    local hdrBg = Rect(frame, "BACKGROUND", 2, P.bgHeader[1], P.bgHeader[2], P.bgHeader[3], P.bgHeader[4])
    hdrBg:SetPoint("TOPLEFT",  frame, "TOPLEFT",  1, -1)
    hdrBg:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -1)
    hdrBg:SetHeight(HEADER_H)

    local hdrSep = GoldLine(frame, 1)
    hdrSep:SetPoint("TOPLEFT",  frame, "TOPLEFT",  2, -HEADER_H)
    hdrSep:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -HEADER_H)

    frame.titleText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.titleText:SetPoint("TOP", frame, "TOP", 0, -10)
    frame.titleText:SetText(P.tGold .. "BiS Helper|r")

    frame.specLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.specLabel:SetPoint("TOP", frame.titleText, "BOTTOM", 0, -2)
    frame.specLabel:SetText("")

    frame.statBarContainer = CreateFrame("Frame", nil, frame)
    frame.statBarContainer:SetPoint("TOPLEFT",  frame, "TOPLEFT",  14, -60)
    frame.statBarContainer:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -14, -60)
    frame.statBarContainer:SetHeight(48)

    local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -2)
    closeBtn:SetScript("OnClick", function() frame:Hide() end)

    local refreshBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    refreshBtn:SetSize(72, 20)
    refreshBtn:SetPoint("TOPRIGHT", closeBtn, "TOPLEFT", -2, 0)
    refreshBtn:SetText("Refresh")
    refreshBtn:SetScript("OnClick", function() BiSHelper_Refresh() end)

    local function ModeButton(label, mode, anchorFrame, anchorSide)
        local btn = CreateFrame("Button", nil, frame, "BackdropTemplate")
        btn:SetSize(72, 22)
        btn:SetPoint("RIGHT", anchorFrame, anchorSide, -4, 0)
        btn:SetBackdrop({
            bgFile   = WHITE_TEX,
            edgeFile = WHITE_TEX,
            edgeSize = 1,
            insets   = { left=1, right=1, top=1, bottom=1 },
        })
        local lbl = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        lbl:SetAllPoints()
        lbl:SetJustifyH("CENTER")
        local function UpdateLook()
            if activeMode == mode then
                btn:SetBackdropColor(0.20, 0.10, 0.38, 0.95)
                btn:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], 1.0)
                lbl:SetText(P.tGold .. label .. "|r")
            else
                btn:SetBackdropColor(0.06, 0.02, 0.14, 0.90)
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

    local btnRaid = ModeButton("Raid", "raid", refreshBtn, "LEFT")
    local btnMplus = ModeButton("Mythic+", "mythicplus", btnRaid, "LEFT")
    frame.modeButtons = { btnRaid, btnMplus }

    local COL_Y = -(HEADER_H + 6)
    local function ColHeader(text, x, w, align, rightAnchor)
        local fs = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        if rightAnchor then
            fs:SetPoint("TOPRIGHT", frame, "TOPRIGHT", rightAnchor, COL_Y)
        else
            fs:SetPoint("TOPLEFT", frame, "TOPLEFT", x, COL_Y)
        end
        fs:SetWidth(w)
        fs:SetJustifyH(align or "LEFT")
        fs:SetText(P.tGold .. text .. "|r")
        return fs
    end
    
    ColHeader("Slot",      38,  60, "LEFT")
    ColHeader("Equipped",  80,  120, "LEFT")
    ColHeader("iLvl",      206,  34, "RIGHT")
    ColHeader("Enchant",   248,  130, "LEFT")
    ColHeader("Gems",      382,  44, "LEFT")
    ColHeader("Track",     432,  72, "LEFT")
    ColHeader("BiS",       510,  24, "CENTER")
    ColHeader("BiS Item",  538,  130, "LEFT")
    ColHeader("Source",    nil,  132, "LEFT", -50)

    local colSep = Rect(frame, "ARTWORK", 1, P.goldDim[1], P.goldDim[2], P.goldDim[3], P.goldDim[4])
    colSep:SetHeight(1)
    colSep:SetPoint("TOPLEFT",  frame, "TOPLEFT",  2, -(HEADER_H + 20))
    colSep:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -(HEADER_H + 20))

    local SCROLL_TOP = HEADER_H + 24
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT",     frame, "TOPLEFT",    2, -SCROLL_TOP)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -26, 16)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetHeight(#SLOTS * ROW_H)
    scrollFrame:SetScrollChild(content)
    scrollFrame:SetScript("OnSizeChanged", function(self, w) content:SetWidth(w) end)

    frame.rows = {}
    for i, slot in ipairs(SLOTS) do
        local row = CreateFrame("Frame", nil, content)
        row:SetHeight(ROW_H)
        row:SetPoint("TOPLEFT",  content, "TOPLEFT",  0, -(i - 1) * ROW_H)
        row:SetPoint("TOPRIGHT", content, "TOPRIGHT", 0, -(i - 1) * ROW_H)
        row.slotId = slot.id

        local cardBg = Rect(row, "BACKGROUND", 0, i % 2 == 0 and P.bgCard[1] or P.bgCardAlt[1], i % 2 == 0 and P.bgCard[2] or P.bgCardAlt[2], i % 2 == 0 and P.bgCard[3] or P.bgCardAlt[3], i % 2 == 0 and P.bgCard[4] or P.bgCardAlt[4])
        cardBg:SetAllPoints()

        local accent = Rect(row, "ARTWORK", 1, P.neonGrey[1], P.neonGrey[2], P.neonGrey[3], 0.6)
        accent:SetWidth(3)
        accent:SetPoint("TOPLEFT", row, "TOPLEFT", 0, 0)
        accent:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 0)
        row.accent = accent

        local sep = Rect(row, "ARTWORK", 0, P.goldDim[1], P.goldDim[2], P.goldDim[3], P.goldDim[4])
        sep:SetHeight(1)
        sep:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 3, 0)
        sep:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)

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
        slotLabel:SetWidth(40)
        slotLabel:SetJustifyH("LEFT")
        slotLabel:SetText(P.tDim .. slot.label .. "|r")

        local eqBtn = CreateFrame("Button", nil, row)
        eqBtn:SetSize(122, 20)
        eqBtn:SetPoint("LEFT", row, "LEFT", 78, 0)
        eqBtn:SetScript("OnEnter", ShowItemTooltip)
        eqBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
        local eqText = eqBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        eqText:SetAllPoints()
        eqText:SetJustifyH("LEFT")
        eqText:SetWordWrap(false)
        row.equippedName = eqText

        local ilvlBg = Rect(row, "ARTWORK", 0, 0.12, 0.06, 0.22, 0.85)
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

        local bisStatus = row:CreateTexture(nil, "OVERLAY")
        bisStatus:SetSize(16, 16)
        bisStatus:SetPoint("CENTER", row, "LEFT", 520, 0)
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
        row.bisHover = bisHover

        frame.rows[i] = row
    end

    return frame
end

-- ============================================================
-- Rebuild stat priority display in header
-- ============================================================
local function RebuildStatBars(specData)
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
            local spec = GetSpecData()
            if spec and spec.statPriority then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:AddLine(P.tGold .. "Stat Priority Details|r")
                GameTooltip:AddLine(" ")
                local current = spec.statPriority[activeMode]
                if current.note then GameTooltip:AddLine(current.note, 1, 1, 1, true) end
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
    if not BiSHelperFrame.statDRText then
        local fd = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        fd:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, 0)
        fd:SetWidth(200)
        fd:SetJustifyH("RIGHT")
        BiSHelperFrame.statDRText = fd
    end
    if not BiSHelperFrame.statSourceLabel then
        local src = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        src:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT", 0, 0)
        src:SetText(P.tDim .. "Source: Wowhead|r")
        BiSHelperFrame.statSourceLabel = src
    end

    if not specData or not specData.statPriority then
        BiSHelperFrame.statPriorityText:SetText("")
        BiSHelperFrame.statNoteText:SetText("")
        BiSHelperFrame.statDRText:SetText("")
        return
    end

    local sp      = specData.statPriority
    local current = sp[activeMode]
    local parts = {}
    for _, stat in ipairs(current.stats) do
        local hex = string.format("|cff%02x%02x%02x", math.floor(stat.r * 255), math.floor(stat.g * 255), math.floor(stat.b * 255))
        parts[#parts + 1] = hex .. stat.name .. "|r"
        if stat.op then parts[#parts + 1] = P.tDim .. " " .. stat.op .. " |r" end
    end
    BiSHelperFrame.statPriorityText:SetText(table.concat(parts))
    BiSHelperFrame.statNoteText:SetText(P.tDim .. (current.note or "") .. "|r")

    if sp.dr then
        local drParts = { P.tDim .. "DR: |r" }
        for i, d in ipairs(sp.dr) do
            local hex = string.format("|cff%02x%02x%02x", math.floor(d.r * 255), math.floor(d.g * 255), math.floor(d.b * 255))
            drParts[#drParts + 1] = hex .. d.name .. " " .. d.rating .. "|r"
            if i < #sp.dr then drParts[#drParts + 1] = P.tDim .. "  |r" end
        end
        BiSHelperFrame.statDRText:SetText(table.concat(drParts))
    else
        BiSHelperFrame.statDRText:SetText("")
    end
end

local pendingItems = {}

local function SetRowVisualStatus(row, status)
    local c
    if     status == "bis"     then c = P.neonGreen
    elseif status == "missing" then c = P.neonRed
    else                            c = P.neonGrey end
    row.accent:SetColorTexture(c[1], c[2], c[3], 0.85)
    if status == "bis" then
        row.bisStatus:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
        row.bisStatus:SetVertexColor(0, 1, 0.5, 1)
        row.bisStatus:Show()
    elseif status == "missing" then
        row.bisStatus:SetTexture("Interface\\RaidFrame\\ReadyCheck-NotReady")
        row.bisStatus:SetVertexColor(1, 0.2, 0.2, 1)
        row.bisStatus:Show()
    else
        row.bisStatus:Hide()
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
                row.ilvlBg:SetColorTexture(0.12, 0.06, 0.22, 0.85)
            else
                row.ilvlText:SetText("")
                row.ilvlBg:SetColorTexture(0, 0, 0, 0)
            end
        else
            row.equippedName:SetText(P.tDim .. "loading…|r")
            row.ilvlText:SetText("")
            row.ilvlBg:SetColorTexture(0, 0, 0, 0)
            pendingItems[link] = { rowIndex = rowIndex, slotId = slotId, retries = 0 }
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
    row.enchantText:SetText(enchant and ("|cff1eff00" .. enchant .. "|r") or (link and P.tDim .. "—|r" or ""))
    
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
    else
        SetRowVisualStatus(row, "missing")
        row.bisName:SetText(P.tMissing .. bisEntry.name .. "|r")
        row.bisHover.bisItemID = bisEntry.itemID
    end
end

function BiSHelper_Refresh()
    if not BiSHelperFrame then return end
    wipe(pendingItems)
    local specData = GetSpecData()
    if specData then
        BiSHelperFrame.specLabel:SetText(P.tLavender .. specData.label .. "|r")
        RebuildStatBars(specData)
    else
        BiSHelperFrame.specLabel:SetText("|cffff4444No BiS data for: " .. (GetCurrentDataKey() or "unknown") .. "|r")
        RebuildStatBars(nil)
    end
    if BiSHelperFrame.modeButtons then for _, b in ipairs(BiSHelperFrame.modeButtons) do b.updateLook() end end
    for i, slot in ipairs(SLOTS) do UpdateRow(i, slot.id) end
end

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
            activeMode  = BiSHelperDB.mode or "mythicplus"
            BiSHelperFrame = CreateMainFrame()
            if BiSHelperDB.point and BiSHelperDB.x and BiSHelperDB.y then
                BiSHelperFrame:ClearAllPoints()
                pcall(function() BiSHelperFrame:SetPoint(BiSHelperDB.point, UIParent, BiSHelperDB.relPoint or BiSHelperDB.point, BiSHelperDB.x, BiSHelperDB.y) end)
            end
            print("|cff00ccff[BiS Helper]|r Loaded. Type |cffffcc00/bis|r to open.")
        end
    elseif event == "PLAYER_LOGIN" or event == "PLAYER_SPECIALIZATION_CHANGED" then
        C_Timer.After(0.5, function() if BiSHelperFrame then BiSHelper_Refresh() end end)
    elseif event == "PLAYER_EQUIPMENT_CHANGED" then
        local slotId = ...
        if BiSHelperFrame and BiSHelperFrame:IsShown() then
            for i, slot in ipairs(SLOTS) do if slot.id == slotId then UpdateRow(i, slotId) break end end
        end
    elseif event == "GET_ITEM_INFO_RECEIVED" then
        local _, success = ...
        if not success then return end
        for link, data in pairs(pendingItems) do
            if C_Item.GetItemInfo(link) then pendingItems[link] = nil UpdateRow(data.rowIndex, data.slotId) end
        end
    end
end)

SLASH_BISHELPER1 = "/bis"
SlashCmdList["BISHELPER"] = function()
    if not BiSHelperFrame then return end
    if BiSHelperFrame:IsShown() then BiSHelperFrame:Hide() else BiSHelper_Refresh() BiSHelperFrame:Show() end
end
