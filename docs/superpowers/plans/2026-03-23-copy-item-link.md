# Copy Item Link / ID — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add shift+click copy functionality to BiS Helper rows — Wowhead links and Item IDs for both equipped and BiS items.

**Architecture:** Single shared popup EditBox frame created lazily on first use. Click handlers added to existing equipped-side and BiS-side interactive elements. `UpdateRow()` modified to always store BiS item ID on the row regardless of match status.

**Tech Stack:** Lua, WoW API (Frames, EditBox, GameTooltip)

**Spec:** `docs/superpowers/specs/2026-03-23-copy-item-link-design.md`

---

### Task 1: Create the shared copy popup frame

**Files:**
- Modify: `addon/BiS_Helper.lua` — insert new function after the palette block (~line 87, after utility helpers)

- [ ] **Step 1: Add `CreateCopyPopup()` and `ShowCopyPopup()` functions**

Insert after line 88 (`local function Trim(s) ...`), before `ExpandDREntry`. This creates a lazily-initialized shared popup frame:

```lua
-- ── Copy-to-clipboard popup ────────────────────────────────
local copyFrame

local function CreateCopyPopup()
    local f = CreateFrame("Frame", "BiSHelperCopyFrame", UIParent, "BackdropTemplate")
    f:SetSize(320, 50)
    f:SetFrameStrata("DIALOG")
    f:SetClampedToScreen(true)
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
```

- [ ] **Step 2: Verify no syntax errors**

Run a basic Lua syntax check (if luac available), otherwise visual review. Ensure `WHITE_TEX`, `BORDER_TEX`, `P.bgCard`, `P.gold`, `P.tGold` are all defined above this code (they are — lines 38-63).

- [ ] **Step 3: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(copy): add shared copy popup frame and ShowCopyPopup helper"
```

---

### Task 2: Always store BiS item ID on the row

**Files:**
- Modify: `addon/BiS_Helper.lua:2380-2388` — `UpdateRow()` function, BiS match branch

- [ ] **Step 1: Add `row.bisItemID` storage in all branches of UpdateRow()**

In `UpdateRow()` (line 2299), modify the BiS comparison section (lines 2366-2388):

**When no bisEntry (line 2366-2371):** Add `row.bisItemID = nil`
```lua
    if not bisEntry then
        SetRowVisualStatus(row, "none")
        row.bisName:SetText("")
        row.sourceText:SetText("")
        row.bisHover.bisItemID = nil
        row.bisItemID = nil
        return
    end
```

**When equipped == BiS (line 2380-2383):** Add `row.bisItemID = bisEntry.itemID`
```lua
    if equippedID == bisEntry.itemID then
        SetRowVisualStatus(row, "bis")
        row.bisName:SetText("")
        row.bisHover.bisItemID = nil
        row.bisItemID = bisEntry.itemID
    else
```

**When missing (line 2384-2388):** Add `row.bisItemID = bisEntry.itemID`
```lua
    else
        SetRowVisualStatus(row, "missing")
        row.bisName:SetText(P.tMissing .. bisEntry.name .. "|r")
        row.bisHover.bisItemID = bisEntry.itemID
        row.bisItemID = bisEntry.itemID
    end
```

- [ ] **Step 2: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(copy): always store bisItemID on row regardless of match status"
```

---

### Task 3: Add shift+click handlers to equipped-side elements

**Files:**
- Modify: `addon/BiS_Helper.lua:1954-1979` — `iconBorder` and `eqBtn` in the row creation loop

- [ ] **Step 1: Add OnMouseDown to iconBorder (line 1959)**

After the existing `OnLeave` script on `iconBorder` (line 1959), add:

```lua
        iconBorder:SetScript("OnMouseDown", function(self, button)
            if button == "LeftButton" and IsShiftKeyDown() then
                local link = GetInventoryItemLink("player", row.slotId)
                local itemID = link and GetItemIDFromLink(link)
                if itemID then
                    ShowCopyPopup(self, itemID, IsControlKeyDown())
                end
            end
        end)
```

- [ ] **Step 2: Add OnMouseDown to eqBtn (line 1979)**

After the existing `OnLeave` script on `eqBtn` (line 1979), add:

```lua
        eqBtn:SetScript("OnMouseDown", function(self, button)
            if button == "LeftButton" and IsShiftKeyDown() then
                local link = GetInventoryItemLink("player", row.slotId)
                local itemID = link and GetItemIDFromLink(link)
                if itemID then
                    ShowCopyPopup(self, itemID, IsControlKeyDown())
                end
            end
        end)
```

- [ ] **Step 3: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(copy): add shift+click handlers to equipped item elements"
```

---

### Task 4: Add shift+click handler to BiS-side element

**Files:**
- Modify: `addon/BiS_Helper.lua:2085` — `bisHover` in the row creation loop

- [ ] **Step 1: Add OnMouseDown to bisHover (after line 2085)**

After the existing `OnLeave` script on `bisHover` (line 2085), add:

```lua
        bisHover:SetScript("OnMouseDown", function(self, button)
            if button == "LeftButton" and IsShiftKeyDown() then
                local itemID = row.bisItemID
                if itemID then
                    ShowCopyPopup(self, itemID, IsControlKeyDown())
                end
            end
        end)
```

Note: Uses `row.bisItemID` (from Task 2), not `self.bisItemID`, so it works even on BiS-matched rows where `bisHover.bisItemID` is nil.

- [ ] **Step 2: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(copy): add shift+click handler to BiS item element"
```

---

### Task 5: Test in-game and copy addon files

- [ ] **Step 1: Copy addon to WoW directory**

```bash
cp -r "D:/Workspace/wow_addon/BiS_Helper/addon/." "/d/World of Warcraft/_retail_/Interface/AddOns/BiS_Helper/"
```

- [ ] **Step 2: Test in-game**

In WoW: `/reload`, then open BiS Helper with `/bis`. Test:

1. **Shift+click on equipped item icon** → popup appears with Wowhead link
2. **Shift+click on equipped item name** → popup appears with Wowhead link
3. **Shift+click on BiS item name (missing row)** → popup with BiS Wowhead link
4. **Shift+click on BiS area of a matched (green ✓) row** → popup with BiS Wowhead link
5. **Shift+Ctrl+click on any of the above** → popup shows raw Item ID instead
6. **Ctrl+C in popup** → copies text
7. **Escape or click away** → popup hides
8. **Shift+click on empty slot (off-hand with 2H)** → nothing happens (no error)
9. **Popup stays on screen** when main window is near screen edge

- [ ] **Step 3: Fix any issues found during testing**

- [ ] **Step 4: Final commit if any fixes were needed**

```bash
git add addon/BiS_Helper.lua
git commit -m "fix(copy): address issues found during in-game testing"
```
