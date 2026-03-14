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

-- Scan tooltip lines for "X Track" pattern
local function GetItemTrack(itemLink)
    if not itemLink then return nil end
    if not C_TooltipInfo or not C_TooltipInfo.GetHyperlink then return nil end
    local ok, data = pcall(C_TooltipInfo.GetHyperlink, itemLink)
    if not ok or not data or not data.lines then return nil end
    for _, line in ipairs(data.lines) do
        local text = line.leftText
        if text then
            local track = text:match("^(%a+) Track$")
            if track then return track end
        end
    end
    return nil
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

-- Creates a StatusBar-based neon indicator (bar + glow layer behind it)
local function NeonBar(parent)
    local container = CreateFrame("Frame", nil, parent)
    container:SetSize(52, 8)

    -- Glow (rendered below bar)
    local glow = Rect(container, "BACKGROUND", -1, 0, 0, 0, 0)
    glow:SetPoint("TOPLEFT",     container, "TOPLEFT",     -3,  3)
    glow:SetPoint("BOTTOMRIGHT", container, "BOTTOMRIGHT",  3, -3)

    -- Track (background of the bar)
    local track = Rect(container, "BACKGROUND", 0,
        P.neonGrey[1], P.neonGrey[2], P.neonGrey[3], 0.55)
    track:SetAllPoints()

    -- Filled bar
    local bar = CreateFrame("StatusBar", nil, container)
    bar:SetAllPoints()
    bar:SetMinMaxValues(0, 1)
    bar:SetValue(0)
    bar:SetStatusBarTexture(WHITE_TEX)
    bar:SetStatusBarColor(P.neonGrey[1], P.neonGrey[2], P.neonGrey[3], 0.8)

    -- Thin top-edge highlight for depth
    local shine = Rect(bar, "OVERLAY", 1, 1, 1, 1, 0.10)
    shine:SetHeight(2)
    shine:SetPoint("TOPLEFT")
    shine:SetPoint("TOPRIGHT")

    container.bar  = bar
    container.glow = glow
    return container
end

local function SetNeonStatus(container, status)
    local bar  = container.bar
    local glow = container.glow
    if status == "bis" then
        bar:SetValue(1)
        bar:SetStatusBarColor(P.neonGreen[1], P.neonGreen[2], P.neonGreen[3], 1)
        glow:SetColorTexture(P.glowGreen[1], P.glowGreen[2], P.glowGreen[3], P.glowGreen[4])
    elseif status == "missing" then
        bar:SetValue(1)
        bar:SetStatusBarColor(P.neonRed[1], P.neonRed[2], P.neonRed[3], 0.75)
        glow:SetColorTexture(P.glowRed[1], P.glowRed[2], P.glowRed[3], P.glowRed[4])
    else -- "none"
        bar:SetValue(0)
        glow:SetColorTexture(0, 0, 0, 0)
    end
end

-- ============================================================
-- Content mode: "raid" | "mythicplus"
-- ============================================================
local activeMode = "raid"

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
    frame:SetSize(700, 590)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:SetClampedToScreen(true)
    frame:SetFrameStrata("MEDIUM")
    frame:Hide()

    -- ── Base background (void purple) ────────────────────────
    frame:SetBackdrop({
        bgFile   = WHITE_TEX,
        edgeFile = WHITE_TEX,
        edgeSize = 1,
        insets   = { left = 1, right = 1, top = 1, bottom = 1 },
    })
    frame:SetBackdropColor(P.bg[1], P.bg[2], P.bg[3], P.bg[4])
    frame:SetBackdropBorderColor(P.gold[1], P.gold[2], P.gold[3], P.gold[4])

    -- ── Top gradient (purple glow fading down) ───────────────
    local topGlow = frame:CreateTexture(nil, "BACKGROUND", nil, 1)
    topGlow:SetPoint("TOPLEFT",  frame, "TOPLEFT",  1, -1)
    topGlow:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -1)
    topGlow:SetHeight(HEADER_H + 20)
    topGlow:SetGradient("VERTICAL",
        CreateColor(0.20, 0.06, 0.40, 0.50),
        CreateColor(0.04, 0.01, 0.10, 0.00))

    -- ── Header background ────────────────────────────────────
    local hdrBg = Rect(frame, "BACKGROUND", 2,
        P.bgHeader[1], P.bgHeader[2], P.bgHeader[3], P.bgHeader[4])
    hdrBg:SetPoint("TOPLEFT",  frame, "TOPLEFT",  1, -1)
    hdrBg:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -1)
    hdrBg:SetHeight(HEADER_H)

    -- Header bottom separator (gold line)
    local hdrSep = GoldLine(frame, 1)
    hdrSep:SetPoint("TOPLEFT",  frame, "TOPLEFT",  2, -HEADER_H)
    hdrSep:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -HEADER_H)

    -- Thin gold accent at very top
    local topAccent = GoldLine(frame, 2)
    topAccent:SetPoint("TOPLEFT",  frame, "TOPLEFT",  1,  -1)
    topAccent:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -1)

    -- ── Title ────────────────────────────────────────────────
    frame.titleText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.titleText:SetPoint("TOP", frame, "TOP", 0, -10)
    frame.titleText:SetText(P.tGold .. "BiS Helper|r")

    -- Diamond decorations flanking the title
    for _, side in ipairs({"LEFT", "RIGHT"}) do
        local gem = frame:CreateTexture(nil, "OVERLAY")
        gem:SetTexture("Interface/Garrison/GarrisonMissionUI-Rewards")
        gem:SetTexCoord(0.60, 0.70, 0.00, 0.15)
        gem:SetSize(16, 16)
        gem:SetAlpha(0.7)
        if side == "LEFT" then
            gem:SetPoint("RIGHT", frame.titleText, "LEFT", -6, 0)
        else
            gem:SetPoint("LEFT", frame.titleText, "RIGHT", 6, 0)
        end
    end

    -- ── Spec label ───────────────────────────────────────────
    frame.specLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.specLabel:SetPoint("TOP", frame.titleText, "BOTTOM", 0, -2)
    frame.specLabel:SetText("")

    -- ── Stat priority bars ───────────────────────────────────
    -- Created/updated in BiSHelper_Refresh; placeholder container frame
    frame.statBarContainer = CreateFrame("Frame", nil, frame)
    frame.statBarContainer:SetPoint("TOPLEFT",  frame, "TOPLEFT",  14, -60)
    frame.statBarContainer:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -14, -60)
    frame.statBarContainer:SetHeight(48)
    frame.statBars = {}  -- filled in BiSHelper_Refresh

    -- ── Close button ─────────────────────────────────────────
    local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -2)
    closeBtn:SetScript("OnClick", function() frame:Hide() end)

    -- ── Refresh button ───────────────────────────────────────
    local refreshBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    refreshBtn:SetSize(72, 20)
    refreshBtn:SetPoint("TOPRIGHT", closeBtn, "TOPLEFT", -2, 0)
    refreshBtn:SetText("Refresh")
    refreshBtn:SetScript("OnClick", function() BiSHelper_Refresh() end)

    -- ── Mode toggle (Raid / Mythic+) ─────────────────────────
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
            -- refresh look of all mode buttons
            for _, b in ipairs(frame.modeButtons) do b.updateLook() end
            BiSHelper_Refresh()
        end)
        btn:SetScript("OnEnter", function()
            btn:SetBackdropColor(0.14, 0.06, 0.28, 0.95)
        end)
        btn:SetScript("OnLeave", function() UpdateLook() end)

        btn.updateLook = UpdateLook
        UpdateLook()
        return btn
    end

    local btnRaid = ModeButton("Raid",     "raid",       refreshBtn, "LEFT")
    local btnMplus = ModeButton("Mythic+", "mythicplus",  btnRaid,   "LEFT")
    frame.modeButtons = { btnRaid, btnMplus }

    -- ── Column headers ───────────────────────────────────────
    local COL_Y = -(HEADER_H + 6)
    local function ColHeader(text, x, w, align)
        local fs = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        fs:SetPoint("TOPLEFT", frame, "TOPLEFT", x, COL_Y)
        fs:SetWidth(w)
        fs:SetJustifyH(align or "LEFT")
        fs:SetText(P.tGold .. text .. "|r")
    end
    ColHeader("Slot",      14,  86, "LEFT")
    ColHeader("Equipped",  118, 148, "LEFT")
    ColHeader("iLvl",      270,  36, "RIGHT")
    ColHeader("Track",     312,  70, "LEFT")
    ColHeader("BiS",       388,  22, "CENTER")
    ColHeader("BiS Item",  416, 130, "LEFT")
    ColHeader("Source",    552, 130, "LEFT")

    -- Thin dim separator below column headers
    local colSep = Rect(frame, "ARTWORK", 1,
        P.goldDim[1], P.goldDim[2], P.goldDim[3], P.goldDim[4])
    colSep:SetHeight(1)
    colSep:SetPoint("TOPLEFT",  frame, "TOPLEFT",  2, -(HEADER_H + 20))
    colSep:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -(HEADER_H + 20))

    -- ── Scroll frame ─────────────────────────────────────────
    local SCROLL_TOP = HEADER_H + 24
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT",     frame, "TOPLEFT",    2, -SCROLL_TOP)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -20, 2)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetHeight(#SLOTS * ROW_H)
    scrollFrame:SetScrollChild(content)
    scrollFrame:SetScript("OnSizeChanged", function(self, w) content:SetWidth(w) end)

    -- ── Gear slot rows ───────────────────────────────────────
    frame.rows = {}
    for i, slot in ipairs(SLOTS) do
        local row = CreateFrame("Frame", nil, content)
        row:SetHeight(ROW_H)
        row:SetPoint("TOPLEFT",  content, "TOPLEFT",  0, -(i - 1) * ROW_H)
        row:SetPoint("TOPRIGHT", content, "TOPRIGHT", 0, -(i - 1) * ROW_H)

        -- Card background (alternating)
        local cardBg = Rect(row, "BACKGROUND", 0,
            i % 2 == 0 and P.bgCard[1]    or P.bgCardAlt[1],
            i % 2 == 0 and P.bgCard[2]    or P.bgCardAlt[2],
            i % 2 == 0 and P.bgCard[3]    or P.bgCardAlt[3],
            i % 2 == 0 and P.bgCard[4]    or P.bgCardAlt[4])
        cardBg:SetAllPoints()

        -- Left accent strip (3 px, coloured by status later)
        local accent = Rect(row, "ARTWORK", 1,
            P.neonGrey[1], P.neonGrey[2], P.neonGrey[3], 0.6)
        accent:SetWidth(3)
        accent:SetPoint("TOPLEFT",    row, "TOPLEFT",    0,  0)
        accent:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0,  0)
        row.accent = accent

        -- Thin bottom separator
        local sep = Rect(row, "ARTWORK", 0,
            P.goldDim[1], P.goldDim[2], P.goldDim[3], P.goldDim[4])
        sep:SetHeight(1)
        sep:SetPoint("BOTTOMLEFT",  row, "BOTTOMLEFT",  3, 0)
        sep:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", 0, 0)

        -- Icon border (24×24 gold frame, icon inside)
        local iconBorder = Rect(row, "ARTWORK", 0,
            P.goldDim[1], P.goldDim[2], P.goldDim[3], 0.70)
        iconBorder:SetSize(24, 24)
        iconBorder:SetPoint("LEFT", row, "LEFT", 6, 0)

        local icon = row:CreateTexture(nil, "ARTWORK", nil, 1)
        icon:SetSize(22, 22)
        icon:SetPoint("CENTER", iconBorder, "CENTER")
        icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        row.icon        = icon
        row.iconBorder  = iconBorder

        -- Slot label
        local slotLabel = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        slotLabel:SetPoint("LEFT", row, "LEFT", 36, 0)
        slotLabel:SetWidth(82)
        slotLabel:SetJustifyH("LEFT")
        slotLabel:SetText(P.tDim .. slot.label .. "|r")

        -- Equipped item name
        local equippedName = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        equippedName:SetPoint("LEFT", row, "LEFT", 122, 0)
        equippedName:SetWidth(142)
        equippedName:SetJustifyH("LEFT")
        equippedName:SetText(P.tDim .. "— empty —|r")
        row.equippedName = equippedName

        -- iLvl pill
        local ilvlBg = Rect(row, "ARTWORK", 0, 0.12, 0.06, 0.22, 0.85)
        ilvlBg:SetSize(36, 16)
        ilvlBg:SetPoint("LEFT", row, "LEFT", 268, 0)
        local ilvlText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        ilvlText:SetPoint("CENTER", ilvlBg, "CENTER")
        ilvlText:SetWidth(34)
        ilvlText:SetJustifyH("CENTER")
        row.ilvlText = ilvlText
        row.ilvlBg   = ilvlBg

        -- Gear track badge
        local trackText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        trackText:SetPoint("LEFT", row, "LEFT", 310, 0)
        trackText:SetWidth(70)
        trackText:SetJustifyH("LEFT")
        trackText:SetText(P.tDim .. "—|r")
        row.trackText = trackText

        -- BiS status indicator (✓ / ✗ / —)
        local bisStatus = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        bisStatus:SetPoint("LEFT", row, "LEFT", 386, 0)
        bisStatus:SetWidth(24)
        bisStatus:SetJustifyH("CENTER")
        row.bisStatus = bisStatus

        -- BiS item name (shown when not BiS)
        local bisName = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        bisName:SetPoint("LEFT", row, "LEFT", 414, 0)
        bisName:SetWidth(130)
        bisName:SetJustifyH("LEFT")
        row.bisName = bisName

        -- Source label
        local sourceText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        sourceText:SetPoint("LEFT", row, "LEFT", 550, 0)
        sourceText:SetWidth(132)
        sourceText:SetJustifyH("LEFT")
        row.sourceText = sourceText

        -- Invisible hover zone over bisName + source for tooltip
        local bisHover = CreateFrame("Frame", nil, row)
        bisHover:SetPoint("TOPLEFT",     row, "TOPLEFT",     414,  0)
        bisHover:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT",   0,  0)
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

        -- Tooltip
        row:EnableMouse(true)
        row.slotId = slot.id
        row:SetScript("OnEnter", function(self)
            local link = GetInventoryItemLink("player", self.slotId)
            if link then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink(link)
                GameTooltip:Show()
            end
        end)
        row:SetScript("OnLeave", function() GameTooltip:Hide() end)

        frame.rows[i] = row
    end

    return frame
end

-- ============================================================
-- Rebuild stat priority display in header
-- ============================================================
local function RebuildStatBars(specData)
    local container = BiSHelperFrame.statBarContainer

    -- Lazy-create persistent FontStrings
    if not BiSHelperFrame.statPriorityText then
        local fs = container:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        fs:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
        fs:SetPoint("RIGHT",   container, "RIGHT",   0, 0)
        fs:SetJustifyH("LEFT")
        BiSHelperFrame.statPriorityText = fs
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

    -- ── Priority chain ────────────────────────────────────────
    local parts = {}
    for _, stat in ipairs(current.stats) do
        local hex = string.format("|cff%02x%02x%02x",
            math.floor(stat.r * 255),
            math.floor(stat.g * 255),
            math.floor(stat.b * 255))
        parts[#parts + 1] = hex .. stat.name .. "|r"
        if stat.op then
            parts[#parts + 1] = P.tDim .. " " .. stat.op .. " |r"
        end
    end
    BiSHelperFrame.statPriorityText:SetText(table.concat(parts))

    -- ── Build note ────────────────────────────────────────────
    BiSHelperFrame.statNoteText:SetText(P.tDim .. (current.note or "") .. "|r")

    -- ── Diminishing returns ───────────────────────────────────
    if sp.dr then
        local drParts = { P.tDim .. "DR: |r" }
        for i, d in ipairs(sp.dr) do
            local hex = string.format("|cff%02x%02x%02x",
                math.floor(d.r * 255),
                math.floor(d.g * 255),
                math.floor(d.b * 255))
            drParts[#drParts + 1] = hex .. d.name .. " " .. d.rating .. "|r"
            if i < #sp.dr then
                drParts[#drParts + 1] = P.tDim .. "  |r"
            end
        end
        BiSHelperFrame.statDRText:SetText(table.concat(drParts))
    else
        BiSHelperFrame.statDRText:SetText("")
    end

    BiSHelperFrame.statBars = {}
end

-- ============================================================
-- Data refresh
-- ============================================================
local pendingItems = {}

local function SetRowVisualStatus(row, status)
    local c
    if     status == "bis"     then c = P.neonGreen
    elseif status == "missing" then c = P.neonRed
    else                            c = P.neonGrey end
    row.accent:SetColorTexture(c[1], c[2], c[3], 0.85)

    if status == "bis" then
        row.bisStatus:SetText("|cff00f280✓|r")
    elseif status == "missing" then
        row.bisStatus:SetText("|cffff4040✗|r")
    else
        row.bisStatus:SetText(P.tDim .. "—|r")
    end
end

local function UpdateRow(rowIndex, slotId)
    local row      = BiSHelperFrame.rows[rowIndex]
    local bisList  = GetActiveBiSList()
    local bisEntry = bisList and bisList[slotId]
    local link     = GetInventoryItemLink("player", slotId)

    -- Icon
    if link then
        local _, _, _, _, iconTex = C_Item.GetItemInfoInstant(link)
        if iconTex then
            row.icon:SetTexture(iconTex)
            row.iconBorder:SetColorTexture(P.gold[1], P.gold[2], P.gold[3], 0.70)
        end
    else
        row.icon:SetTexture("Interface/ICONS/INV_Misc_QuestionMark")
        row.iconBorder:SetColorTexture(P.goldDim[1], P.goldDim[2], P.goldDim[3], 0.35)
    end

    -- Equipped name + iLvl
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

    -- Gear track
    local track = GetItemTrack(link)
    if track then
        local tc = TRACK_COLOR[track] or P.tDim
        row.trackText:SetText(tc .. track .. " Track|r")
    else
        row.trackText:SetText(link and P.tDim .. "—|r" or "")
    end

    -- BiS comparison
    if not bisEntry then
        SetRowVisualStatus(row, "none")
        row.bisName:SetText("")
        row.sourceText:SetText("")
        row.bisHover.bisItemID = nil
        return
    end

    -- Source (always shown regardless of BiS status)
    local src = bisEntry.source or ""
    if src == "Crafted" then
        row.sourceText:SetText("|cff1eff00" .. src .. "|r")
    elseif src == "Tier Set" or src == "Catalyst" then
        row.sourceText:SetText("|cffffcc00" .. src .. "|r")
    else
        row.sourceText:SetText(P.tDim .. src .. "|r")
    end

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
    local bisList  = GetActiveBiSList()

    if specData then
        BiSHelperFrame.specLabel:SetText(P.tLavender .. specData.label .. "|r")
        RebuildStatBars(specData)   -- stat bars come from specData, not mode-specific list
    else
        local key = GetCurrentDataKey() or "unknown"
        BiSHelperFrame.specLabel:SetText("|cffff4444No BiS data for: " .. key .. "|r")
        RebuildStatBars(nil)
    end

    -- Refresh mode button appearance
    if BiSHelperFrame.modeButtons then
        for _, b in ipairs(BiSHelperFrame.modeButtons) do b.updateLook() end
    end

    for i, slot in ipairs(SLOTS) do
        UpdateRow(i, slot.id)
    end
end

-- ============================================================
-- Events
-- ============================================================
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
eventFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED")

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = ...
        if name == ADDON_NAME then
            BiSHelperFrame = CreateMainFrame()
            print("|cff00ccff[BiS Helper]|r Loaded. Type |cffffcc00/bis|r to open.")
        end

    elseif event == "PLAYER_LOGIN" then
        C_Timer.After(0.5, function()
            if BiSHelperFrame then BiSHelper_Refresh() end
        end)

    elseif event == "PLAYER_EQUIPMENT_CHANGED" then
        local slotId = ...
        if BiSHelperFrame and BiSHelperFrame:IsShown() then
            for i, slot in ipairs(SLOTS) do
                if slot.id == slotId then
                    UpdateRow(i, slotId)
                    break
                end
            end
        end

    elseif event == "GET_ITEM_INFO_RECEIVED" then
        local _, success = ...
        if not success then return end
        for link, data in pairs(pendingItems) do
            local name, _, quality, ilvl = C_Item.GetItemInfo(link)
            if name then
                local row = BiSHelperFrame.rows[data.rowIndex]
                row.equippedName:SetText((QUALITY_HEX[quality] or QUALITY_HEX[1]) .. name .. "|r")
                if ilvl and ilvl > 0 then
                    row.ilvlText:SetText(P.tGold .. ilvl .. "|r")
                    row.ilvlBg:SetColorTexture(0.12, 0.06, 0.22, 0.85)
                end
                pendingItems[link] = nil
                UpdateRow(data.rowIndex, data.slotId)
            else
                data.retries = data.retries + 1
                if data.retries > 5 then pendingItems[link] = nil end
            end
        end
    end
end)

-- ============================================================
-- Slash command
-- ============================================================
SLASH_BISHELPER1 = "/bis"
SlashCmdList["BISHELPER"] = function()
    if not BiSHelperFrame then return end
    if BiSHelperFrame:IsShown() then
        BiSHelperFrame:Hide()
    else
        BiSHelper_Refresh()
        BiSHelperFrame:Show()
    end
end
