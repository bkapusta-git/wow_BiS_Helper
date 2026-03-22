# Silvermoon / Sin'dorei Theme Redesign

## Goal

Replace the current void-purple & ethereal gold visual theme with a Silvermoon City / Sin'dorei aesthetic: warm mahogany backgrounds, crimson accents, ornamental gold borders, parchment-cream text. The addon should feel like a panel inside a Silvermoon interior — opulent, warm, regal.

## Approach

**Palette + Border Refinement** — swap the color palette and upgrade flat `WHITE8X8` borders to WoW's built-in `UI-Tooltip-Border` texture, colored gold. No layout changes, no new files, no custom textures.

## Color Palette

All changes in the `P` table in `BiS_Helper.lua`:

```lua
local P = {
    -- Backgrounds (dark mahogany, warm — never cold/blue)
    bg          = { 0.08, 0.04, 0.03, 0.97 },
    bgCard      = { 0.13, 0.07, 0.06, 1.00 },
    bgCardAlt   = { 0.10, 0.05, 0.04, 1.00 },
    bgHeader    = { 0.15, 0.08, 0.07, 1.00 },

    -- Borders (ornamental gold — Silvermoon filigree)
    gold        = { 0.85, 0.68, 0.25, 0.90 },
    goldDim     = { 0.55, 0.40, 0.15, 0.45 },

    -- Status (warmed to fit palette)
    neonGreen   = { 0.30, 0.88, 0.40, 1.00 },
    neonRed     = { 0.90, 0.22, 0.18, 1.00 },
    neonGrey    = { 0.30, 0.22, 0.20, 1.00 },
    glowGreen   = { 0.30, 0.88, 0.40, 0.14 },
    glowRed     = { 0.90, 0.22, 0.18, 0.10 },

    -- Text (parchment/cream replacing lavender/purple)
    tGold       = "|cfff5c842",
    tCream      = "|cffeddcc8",   -- warm parchment (replaces old tLavender)
    tDim        = "|cff8a7262",
    tWhite      = "|cfff0e6d8",
    tBiS        = "|cff4ee050",
    tMissing    = "|cffe63830",
}
```

**Key rename:** `P.tLavender` → `P.tCream`. All references in the file must be updated (find-and-replace `tLavender` → `tCream`). There are no external consumers of this local table.

### Design rationale

- Backgrounds shift from purple hue (~270) to warm brown-mahogany (~15). The red channel leads, green is ~half of red, blue is minimal.
- Gold accents pushed toward warm amber (matching Silvermoon filigree metalwork).
- Status greens/reds warmed to harmonize — no more cold neon.
- Text shifts from lavender tints to parchment/cream — like ancient scrolls under candlelight.
- `TRACK_COLOR` and `QUALITY_HEX` remain unchanged (standard WoW colors, users expect them).

## Hardcoded Color Replacements

Beyond the `P` table, many colors are hardcoded throughout the file. All must be updated:

### Hardcoded hex color strings

| Old hex | New hex | Usage |
|---------|---------|-------|
| `\|cff00f280` | `\|cff4ee050` (= `P.tBiS`) | BiS status text, DR "CAPPED" text, HELP_TEXT |
| `\|cffff4040` | `\|cffe63830` (= `P.tMissing`) | Missing status text, delete button "x", HELP_TEXT |
| `f5d258` | `f5c842` (= `P.tGold` value) | HELP_TEXT header gold color |

**Rule:** Replace ALL hardcoded instances. Prefer using `P.tBiS`/`P.tMissing`/`P.tGold` references where possible instead of raw hex strings.

### Hardcoded RGBA purple values (find-and-replace-all)

| Old RGBA | New RGBA | Usage |
|----------|----------|-------|
| `0.20, 0.10, 0.38, 0.95` | `0.25, 0.12, 0.08, 0.95` | Hover state on all buttons (toolbar, edit, stats, share, filter) |
| `0.06, 0.02, 0.14` | `0.08, 0.04, 0.03` (= `P.bg` rgb) | Inactive button backgrounds, input box backgrounds, tab backgrounds |
| `0.12, 0.06, 0.22, 0.85` | `0.15, 0.08, 0.06, 0.85` | ilvlBg badge background |
| `0.08, 0.04, 0.16, 0.90` | `0.10, 0.05, 0.04, 0.90` | DR bar track background |
| `0.06, 0.02, 0.14, 0.90` | `0.08, 0.04, 0.03, 0.90` | Footer progress bar track background |

## Border Changes

### New constant

```lua
local BORDER_TEX = "Interface/Tooltips/UI-Tooltip-Border"
```

`bgFile` remains `WHITE_TEX` in all backdrops — only `edgeFile` changes.

### Window frames (5 frames)

Replace in `SetBackdrop()` calls for: MainFrame, EditFrame, StatsFrame, HelpFrame, ShareFrame.

| Property | Current | New |
|----------|---------|-----|
| `edgeFile` | `WHITE_TEX` | `BORDER_TEX` |
| `edgeSize` | `1` | `16` |
| `insets` | `{1,1,1,1}` | `{4,4,4,4}` |

Border colored with `SetBackdropBorderColor(P.gold)`.

### Toolbar buttons

Same `BORDER_TEX` but with `edgeSize = 12`. Border color `goldDim` default, `gold` on hover.

**Note:** Buttons shorter than ~30px may need `edgeSize = 8` if borders visually overlap. Verify in-game; the spec defaults to 12 but this is a testing checkpoint.

### InputBox (Edit panel)

`BORDER_TEX` with `edgeSize = 12`, border color `goldDim`.

## Accent Bar

In `SetRowVisualStatus()`:

- Width: 3px → 4px
- BiS color: `neonGreen` (now warmed `{0.30, 0.88, 0.40}`)
- Missing color: `neonRed` (now warmed `{0.90, 0.22, 0.18}`)

No structural change — only color values differ via the updated `P` table.

## Header Gradient Overlay

Update the **existing** `topGlow` gradient in `CreateFrameHeader()` (~line 1779-1781). Do NOT create a new texture — the gradient overlay already exists.

Current:
```lua
topGlow:SetGradient("VERTICAL", CreateColor(0.20, 0.06, 0.40, 0.50), CreateColor(0.04, 0.01, 0.10, 0.00))
```

New (using WoW 12.0 `CreateColor` API):
```lua
if topGlow.SetGradient then
    topGlow:SetGradient("VERTICAL", CreateColor(0.70, 0.14, 0.14, 0.15), CreateColor(0.70, 0.14, 0.14, 0.0))
end
```

## Button Hover States

Update `OnEnter`/`OnLeave` in **all** buttons across the file (not just toolbar — also Edit panel buttons, Stats panel buttons, Share panel buttons, Filter button):

- Current hover bg: `0.20, 0.10, 0.38, 0.95` (purple tint)
- New hover bg: `0.25, 0.12, 0.08, 0.95` (warm mahogany-red tint)
- Border on hover: upgrade from `goldDim` to `gold`

## Scope

### Files changed

- `addon/BiS_Helper.lua` — sole file modified

### Estimated edits

~30-35 targeted edits:
- 1 palette table swap
- 1 new constant (`BORDER_TEX`)
- 1 key rename (`tLavender` → `tCream` + all references)
- ~7 backdrop definition updates (5 frames + inputbox + buttons)
- ~10 hardcoded purple RGBA replacements
- ~7 hardcoded hex string replacements
- 1 gradient update
- ~5 hover state updates
- 1 accent bar width change

### Not changed

- Layout, sizing, positioning of any element
- BiS logic, refresh, events, data handling
- Data files (`addon/data/*.lua`)
- TOC file (except version bump if releasing)
- `TRACK_COLOR`, `QUALITY_HEX` (standard WoW colors)
- Font objects (`GameFontNormal*`)
- Share/Export/Import functionality
- Minimap button behavior

## Testing

Manual in-game testing via `/reload`. Key checkpoints:

1. Main frame opens with new colors — no purple remnants anywhere
2. Borders render correctly on all frames (no stretched/broken textures)
3. **Button borders** — verify `edgeSize = 12` looks good on small buttons (22px height); if not, reduce to 8
4. Accent bars show warm colors for BiS/missing
5. All panels (Edit, Stats, Help, Share) use new theme consistently
6. Button hovers feel responsive with new warm tones across all panels
7. Header gradient visible but subtle (crimson warmth)
8. Text readable on new backgrounds (contrast check)
9. Resize behavior unaffected
10. HELP_TEXT displays correct warm colors (no old purple/neon remnants)
11. DR bars and footer progress bar use warm backgrounds
12. BiS status checkmarks (✓/✗) use warm green/red, not old neon
