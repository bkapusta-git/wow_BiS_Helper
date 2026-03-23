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
- **Size:** ~300px wide, anchored near the clicked element (ANCHOR_RIGHT or ANCHOR_LEFT)
- **Visual style:** Consistent with Silvermoon theme (mahogany bg `P.bgCard`, gold border `P.gold`)
- **Label:** Small FontString above EditBox — "Wowhead Link" or "Item ID"
- **Behavior:**
  - Text auto-selected on show (`HighlightText()` + `SetFocus()`)
  - Closes on: Escape, focus lost, or next shift+click
  - EditBox is read-only (user cannot edit, only copy)

## Formats

- **Wowhead link:** `https://www.wowhead.com/item=ITEMID`
- **Item ID:** `ITEMID` (plain number)

## Data Sources

- **Equipped item ID:** `GetInventoryItemID("player", row.slotId)` — called at click time (always current)
- **BiS item ID:** `row.bisHover.bisItemID` — already stored on each row during refresh

## Implementation: Modified Elements

### Equipped side (iconBorder + eqBtn)

Currently: OnEnter/OnLeave tooltip only, no OnClick.

Change: Add OnMouseDown (or convert to Button) with shift/ctrl detection:

```lua
-- Pseudocode
element:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" and IsShiftKeyDown() then
        local itemID = GetInventoryItemID("player", row.slotId)
        if itemID then
            local isCtrl = IsControlKeyDown()
            ShowCopyPopup(self, itemID, isCtrl)
        end
    end
end)
```

### BiS side (bisHover)

Currently: OnEnter/OnLeave tooltip only, no OnClick.

Change: Add OnMouseDown with shift/ctrl detection:

```lua
bisHover:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" and IsShiftKeyDown() then
        if self.bisItemID then
            local isCtrl = IsControlKeyDown()
            ShowCopyPopup(self, self.bisItemID, isCtrl)
        end
    end
end)
```

## ShowCopyPopup Function

```
function ShowCopyPopup(anchor, itemID, showRawID)
    - Format text: raw ID or Wowhead URL
    - Set label text ("Item ID" or "Wowhead Link")
    - Position popup near anchor element
    - Set EditBox text, highlight all, set focus
    - Show frame
end
```

## Popup Dismiss

- `OnEscapePressed` → hide
- `OnEditFocusLost` → hide
- Next `ShowCopyPopup` call hides previous automatically (single shared frame)

## Scope

- No new files — all changes in `BiS_Helper.lua`
- No external dependencies
- No SavedVariables changes
- Estimated: ~60-80 lines of new code
