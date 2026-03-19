# Share / Export / Import BiS Profile — Design Spec

**Date:** 2026-03-19
**Status:** Approved
**Scope:** BiS Helper addon (WoW, Midnight S1)

---

## Goal

Allow players to export their full BiS profile (item overrides + stat priority overrides + DR caps) as an encoded string, and import profiles from other players or their own alts/backups. No new list-building UI — leverages existing Edit and Stats panels.

---

## 1. Share Button in Main Frame Header

- New **"Share"** button added to the top button bar
- Position: to the left of "Edit", after the `|` separator from mode buttons
- Layout (right to left): `[X] [Refresh] | [Raid] [Mythic+] | [Share] [Edit] [Stats] [?]`
- Size: **50×22** (same as Edit/Stats)
- Style: identical to Edit/Stats — Midnight theme, gold border, hover highlight
- Tooltip: *"Export or import BiS profile"*
- OnClick: opens Share panel (`BiSHelper_OpenSharePanel()`)

## 2. Share Panel (Modal)

- Frame: `BiSHelperShareFrame`, parent `UIParent`, `BackdropTemplate`
- Size: **400×340**
- Strata: `DIALOG` (same as Edit/Stats panels)
- Movable, clamped to screen
- Style: identical to existing panels (Midnight bg, gold border, header bar 36px)
- ESC-to-close: register frame name in `UISpecialFrames`
- Opening Share panel does NOT close Edit/Stats panels (they are independent). After import, `BiSHelper_Refresh()` updates the main frame; if Edit/Stats panels are open, they reflect stale data until re-opened (acceptable — same as current behavior when overrides change via Edit panel).

### Layout

```
┌─────────────────────────────────────────┐
│  Share BiS Profile                  [X] │
├─────────────────────────────────────────┤
│                                         │
│  [▼ Export]  [  Import  ]    ← tabs     │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │                                   │  │
│  │   ScrollingMessageFrame /         │  │
│  │   MultiLine EditBox               │  │
│  │   (encoded string content)        │  │
│  │                                   │  │
│  └───────────────────────────────────┘  │
│                                         │
│  [Action Button]                        │
│                                         │
│  Status: "Profile exported for ..."     │
│                                         │
└─────────────────────────────────────────┘
```

### Tabs: Export / Import

- Two toggle buttons styled like Raid/Mythic+ mode buttons
- Active tab: gold text + highlighted bg; inactive: dim text
- Default: Export tab active on open

### Export Tab Behavior

1. On panel open (or tab switch to Export): auto-generate encoded string from current spec's profile
2. EditBox is **read-only** (not editable by user)
3. Text is auto-selected (highlighted) for easy Ctrl+C
4. Action button: **"Select All"** — re-selects entire text in EditBox
5. Status line shows: *"Profile exported for Shadow Priest (both modes)"*

### Import Tab Behavior

1. EditBox is **editable** — user pastes encoded string
2. Action button: **"Import Profile"**
3. On click:
   a. Validate string (check prefix, decode, verify structure)
   b. If spec key differs from current spec → warning via `StaticPopupDialogs["BISHELPER_IMPORT_SPECWARN"]`: *"This profile is for [X] but you are [Y]. Import anyway?"*. If user declines, abort.
   c. Confirmation via `StaticPopupDialogs["BISHELPER_IMPORT_CONFIRM"]`: *"This will overwrite your current overrides for [SPEC]. Continue?"*
   d. On confirm: apply overrides + statOverrides to `BiSHelperDB`, refresh UI
4. Status line shows result: *"Imported 12 item overrides + stat priority"* or error: *"Invalid import string"*

### Import Merge Semantics

Import stores data under the **profile's embedded key** (not the current player's spec key). This allows importing profiles for other specs (e.g., import Holy Priest profile while playing Shadow — data appears when switching to Holy).

Import performs **full replacement per section**: for each section present in the import (`overrides.raid`, `overrides.mythicplus`, `statOverrides.raid`, `statOverrides.mythicplus`, `statOverrides.dr`), the corresponding section in `BiSHelperDB` is fully replaced. Sections **absent** from the import are left unchanged.

## 3. Data Format

### Exported Data Structure

For the current spec, **both modes** are included:

```lua
{
    version = 1,
    key     = "PRIEST_SHADOW",
    overrides = {
        raid       = { [slotId] = { itemID=number, name=string, source=string }, ... },
        mythicplus = { [slotId] = { itemID=number, name=string, source=string }, ... },
    },
    statOverrides = {
        raid       = { stats = { {name, op, r, g, b}, ... }, note = string },
        mythicplus = { stats = { {name, op, r, g, b}, ... }, note = string },
        dr         = { {name, rating, r, g, b}, ... },
    },
}
```

- Empty tables (no overrides for a mode) are omitted to keep string shorter
- `version` field allows future format changes without breaking old strings

### Encoding Pipeline

```
Lua table → Serialize (custom recursive) → Base64 encode → Prepend "!BH1!" prefix
```

### Decoding Pipeline

```
Check "!BH1!" prefix → Strip prefix → Base64 decode → Deserialize → Validate structure
```

### Implementation Details

- **Serialization format**: Lua-literal style `{key=value,...}`. Strings escaped via `string.format("%q", s)` which handles quotes, backslashes, newlines, and all special characters. `nil` values are omitted (not serialized). Tables with mixed numeric and string keys are supported. `loadstring()` is NOT available in WoW's sandboxed Lua — a custom recursive parser is required for deserialization.
- **Base64**: custom encode/decode, ~30 lines. Standard alphabet (A-Z, a-z, 0-9, +, /).
- **Prefix `!BH1!`**: "BiS Helper format version 1" — quick validation before attempting decode.
- **EditBox max length**: `SetMaxLetters(0)` (unlimited) to handle full profile strings (estimated 3-5 KB after base64 encoding).
- **No external dependencies** — all code self-contained in `BiS_Helper.lua`.

## 4. Validation Rules (Import)

| Check | Error message |
|-------|---------------|
| Missing `!BH1!` prefix | "Invalid import string — not a BiS Helper profile" |
| Base64 decode fails | "Invalid import string — corrupted data" |
| Deserialize fails | "Invalid import string — corrupted data" |
| Missing `version` field | "Invalid import string — missing version" |
| `version > 1` | "This profile requires a newer version of BiS Helper" |
| Missing `key` field | "Invalid import string — missing spec key" |
| `key` ≠ current spec | Warning (non-blocking): "This profile is for [X] but you are [Y]. Import anyway?" |
| No overrides AND no statOverrides | "Nothing to import — profile is empty" |

## 5. Global Function

- `BiSHelper_OpenSharePanel()` — opens the Share panel (called from Share button OnClick)

## 6. Out of Scope

- Compression (base64 is sufficient for override data size)
- Guild/party sharing (future consideration)
- Chat link integration
- New list-building UI (uses existing Edit panel)
