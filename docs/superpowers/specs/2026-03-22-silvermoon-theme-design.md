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
    tLavender   = "|cffeddcc8",   -- renamed conceptually to "cream", key kept for compat
    tDim        = "|cff8a7262",
    tWhite      = "|cfff0e6d8",
    tBiS        = "|cff4ee050",
    tMissing    = "|cffe63830",
}
```

### Design rationale

- Backgrounds shift from purple hue (~270) to warm brown-mahogany (~15). The red channel leads, green is ~half of red, blue is minimal.
- Gold accents pushed toward warm amber (matching Silvermoon filigree metalwork).
- Status greens/reds warmed to harmonize — no more cold neon.
- Text shifts from lavender tints to parchment/cream — like ancient scrolls under candlelight.
- `TRACK_COLOR` and `QUALITY_HEX` remain unchanged (standard WoW colors, users expect them).

## Border Changes

### New constant

```lua
local BORDER_TEX = "Interface/Tooltips/UI-Tooltip-Border"
```

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

### InputBox (Edit panel)

`BORDER_TEX` with `edgeSize = 12`, border color `goldDim`.

## Accent Bar

In `SetRowVisualStatus()`:

- Width: 3px → 4px
- BiS color: `neonGreen` (now warmed `{0.30, 0.88, 0.40}`)
- Missing color: `neonRed` (now warmed `{0.90, 0.22, 0.18}`)

No structural change — only color values differ via the updated `P` table.

## Header Gradient Overlay

Add one `WHITE8X8` texture in `CreateMainFrame()` header area:

- Color: crimson `{0.70, 0.14, 0.14}`
- Gradient: `SetGradient("VERTICAL", 0.70, 0.14, 0.14, 0.15, 0.70, 0.14, 0.14, 0.0)` (top → bottom fade)
- Layer: `BACKGROUND` sublayer 2 (above header bg, below content)

This adds depth and Silvermoon-banner warmth to the header without layout changes.

## Button Hover States

Update `OnEnter`/`OnLeave` in all toolbar buttons:

- Current hover: `0.20, 0.10, 0.38, 0.95` (purple tint)
- New hover: `0.25, 0.12, 0.08, 0.95` (warm mahogany-red tint)
- Border on hover: upgrade from `goldDim` to `gold`

## Scope

### Files changed

- `addon/BiS_Helper.lua` — sole file modified

### Estimated edits

~15-20 targeted edits (palette swap, backdrop definitions, hover colors, accent bar width, header overlay addition).

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

1. Main frame opens with new colors — no purple remnants
2. Borders render correctly (no stretched/broken textures)
3. Accent bars show warm colors for BiS/missing
4. All panels (Edit, Stats, Help, Share) use new theme consistently
5. Button hovers feel responsive with new warm tones
6. Header gradient visible but subtle
7. Text readable on new backgrounds (contrast check)
8. Resize behavior unaffected
