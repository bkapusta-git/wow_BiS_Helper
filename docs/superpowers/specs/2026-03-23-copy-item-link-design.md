# Copy Item Link / ID — Design Spec

**Date:** 2026-03-23
**Feature:** Shift+click to copy Wowhead link or Item ID for equipped/BiS items

## Overview

Add shift+click interaction to main frame rows that opens a popup EditBox with a copyable Wowhead link or Item ID. Applies to both equipped items and BiS items.

## Interaction

| Action | Target | Result |
|--------|--------|--------|
| Shift+click | Equipped item (icon / name) | Popup with Wowhead link for equipped item |
| Shift+click | BiS item (BiS name) | Popup with Wowhead link for BiS item |
| Shift+Ctrl+click | Equipped item (icon / name) | Popup with Item ID for equipped item |
| Shift+Ctrl+click | BiS item (BiS name) | Popup with Item ID for BiS item |

## Popup EditBox

- **Single shared frame** (`BiSHelperCopyFrame`) — created once, reused for every click
- **Size:** ~300px wide, anchored near the clicked element
- **Frame strata:** `DIALOG` — ensures popup renders above main window and tooltips
- **Clamped to screen:** `SetClampedToScreen(true)` — prevents off-screen rendering
- **Visual style:** Consistent with Silvermoon theme (mahogany bg `P.bgCard`, gold border `P.gold`)
- **Label:** Small FontString above EditBox — "Wowhead Link" or "Item ID"
- **Behavior:**
  - Text auto-selected on show (`HighlightText()` + `SetFocus()`)
  - Closes on: Escape, focus lost, or next shift+click
  - EditBox is read-only — enforced via `OnTextChanged` handler that resets text and re-highlights:
    ```lua
    editBox:SetScript("OnTextChanged", function(self)
        self:SetText(savedText)
        self:HighlightText()
    end)
    ```
  - `GameTooltip:Hide()` called when popup opens to avoid visual clutter

## Formats

- **Wowhead link:** `https://www.wowhead.com/item=ITEMID`
- **Item ID:** `ITEMID` (plain number)

## Data Sources

- **Equipped item ID:** Derived from `GetInventoryItemLink("player", row.slotId)` parsed via existing `GetItemIDFromLink()` helper — called at click time (always current). Returns nil for empty slots (no-op).
- **BiS item ID:** `row.bisItemID` — stored on every row during refresh, **including BiS-matched rows**. Currently `bisHover.bisItemID` is set to nil when item matches BiS; this must be changed so that BiS item ID is always available for copying regardless of match status. Store it directly on `row.bisItemID` during refresh.

## Implementation: Modified Elements

### Equipped side (iconBorder + eqBtn)

Currently: OnEnter/OnLeave tooltip only, no OnClick.

Change: Add `OnMouseDown` with shift/ctrl detection. Must use `OnMouseDown` (not `OnClick`) because `iconBorder` is a plain Frame, not a Button.

```lua
-- Pseudocode (applied to both iconBorder and eqBtn)
element:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" and IsShiftKeyDown() then
        local link = GetInventoryItemLink("player", row.slotId)
        local itemID = link and GetItemIDFromLink(link)
        if itemID then
            ShowCopyPopup(self, itemID, IsControlKeyDown())
        end
    end
end)
```

### BiS side (bisHover)

Currently: OnEnter/OnLeave tooltip only, no OnClick.

Change: Add `OnMouseDown` with shift/ctrl detection:

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

## ShowCopyPopup Function

```
function ShowCopyPopup(anchor, itemID, showRawID)
    - Hide GameTooltip
    - Format text: raw ID (tostring) or Wowhead URL
    - Set label text ("Item ID" or "Wowhead Link")
    - Clear all anchor points, re-anchor near clicked element
    - Set EditBox text, highlight all, set focus
    - Show frame
end
```

## Popup Dismiss

- `OnEscapePressed` → hide
- `OnEditFocusLost` → hide
- Next `ShowCopyPopup` call hides previous automatically (single shared frame)

## Edge Cases

- **Empty slot** (e.g., off-hand with 2H weapon): `GetInventoryItemLink` returns nil → no-op, no popup
- **BiS-matched row** (green ✓): `row.bisItemID` still populated → copy works normally
- **No BiS data for slot**: `row.bisItemID` is nil → no-op on BiS side
- **Window near screen edge**: `SetClampedToScreen(true)` prevents popup from going off-screen

## Scope

- No new files — all changes in `BiS_Helper.lua`
- No external dependencies
- No SavedVariables changes
- Estimated: ~70-90 lines of new code
