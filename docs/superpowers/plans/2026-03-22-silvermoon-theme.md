# Silvermoon Theme Redesign — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the void-purple visual theme with a warm Silvermoon/Sin'dorei aesthetic (mahogany backgrounds, crimson accents, ornamental gold borders, parchment-cream text).

**Architecture:** All changes in a single file (`addon/BiS_Helper.lua`). The palette table `P` is swapped, all hardcoded color references are updated, and flat 1px borders are replaced with WoW's `UI-Tooltip-Border` texture. No layout, logic, or data changes.

**Tech Stack:** WoW Lua API (Interface 120001), BackdropTemplate, CreateColor API.

**Spec:** `docs/superpowers/specs/2026-03-22-silvermoon-theme-design.md`

---

### Task 1: Create feature branch

**Files:** None

- [ ] **Step 1: Create and switch to feature branch**

```bash
git checkout -b feat/silvermoon-theme
```

- [ ] **Step 2: Verify branch**

```bash
git branch --show-current
```

Expected: `feat/silvermoon-theme`

---

### Task 2: Swap palette table `P` and add `BORDER_TEX` constant

**Files:**
- Modify: `addon/BiS_Helper.lua:38-62` (palette `P`)
- Modify: `addon/BiS_Helper.lua:62` (add `BORDER_TEX` after `WHITE_TEX`)

- [ ] **Step 1: Replace palette `P` (lines 38-60)**

Replace the entire `P` table with:

```lua
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
```

- [ ] **Step 2: Add `BORDER_TEX` constant after `WHITE_TEX` (line 62)**

After `local WHITE_TEX = "Interface/Buttons/WHITE8X8"`, add:

```lua
local BORDER_TEX = "Interface/Tooltips/UI-Tooltip-Border"
```

- [ ] **Step 3: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(theme): swap palette to Silvermoon colors, add BORDER_TEX"
```

---

### Task 3: Rename `tLavender` → `tCream` across all references

**Files:**
- Modify: `addon/BiS_Helper.lua` — 4 references (lines 912, 1160, 1282, 2395)

- [ ] **Step 1: Find-and-replace `P.tLavender` → `P.tCream`**

Replace all 4 occurrences:

| Line | Context |
|------|---------|
| 912 | `P.tLavender .. specLabel` → `P.tCream .. specLabel` |
| 1160 | `P.tLavender .. specLabel` → `P.tCream .. specLabel` |
| 1282 | `P.tLavender .. "How to use"` → `P.tCream .. "How to use"` |
| 2395 | `P.tLavender .. specData.label` → `P.tCream .. specData.label` |

- [ ] **Step 2: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "refactor(theme): rename tLavender to tCream"
```

---

### Task 4: Replace hardcoded hex color strings

**Files:**
- Modify: `addon/BiS_Helper.lua` — lines 661-663, 1219-1249, 2270, 2288, 2291

- [ ] **Step 1: Replace `|cff00f280` → `|cff4ee050` (4 locations, excluding palette def)**

| Line | Old | New |
|------|-----|-----|
| 1220 | `\|cff00f280` (×2 in HELP_TEXT) | `\|cff4ee050` |
| 2270 | `\|cff00f280CAPPED` | `\|cff4ee050CAPPED` |
| 2288 | `\|cff00f280✓` | `\|cff4ee050✓` |

- [ ] **Step 2: Replace `|cffff4040` → `|cffe63830` (4 locations, excluding palette def)**

| Line | Old | New |
|------|-----|-----|
| 661 | `\|cffff4040×` | `\|cffe63830×` |
| 663 | `\|cffff4040×` (OnLeave) | `\|cffe63830×` |
| 1221 | `\|cffff4040` (×2 in HELP_TEXT) | `\|cffe63830` |
| 2291 | `\|cffff4040✗` | `\|cffe63830✗` |

- [ ] **Step 3: Replace `|cffff8080` → `|cffe86860` (hover variant of missing color, derived from new `P.tMissing`)**

| Line | Old | New |
|------|-----|-----|
| 662 | `\|cffff8080×` | `\|cffe86860×` |

- [ ] **Step 4: Replace `f5d258` → `f5c842` in HELP_TEXT headers (6 locations, excluding palette def)**

| Line | Old | New |
|------|-----|-----|
| 1217 | `"f5d258"` (addon title) | `"f5c842"` |
| 1219 | `"f5d258"` | `"f5c842"` |
| 1224 | `"f5d258"` | `"f5c842"` |
| 1235 | `"f5d258"` | `"f5c842"` |
| 1243 | `"f5d258"` | `"f5c842"` |
| 1249 | `"f5d258"` | `"f5c842"` |

- [ ] **Step 6: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(theme): replace hardcoded hex colors with warm Silvermoon values"
```

---

### Task 5: Replace hardcoded RGBA purple values

**Files:**
- Modify: `addon/BiS_Helper.lua` — ~22 locations

- [ ] **Step 1: Replace hover purple `0.20, 0.10, 0.38, 0.95` → `0.25, 0.12, 0.08, 0.95` (10 locations)**

Lines: 796, 846, 897, 1140, 1381, 1443, 1655, 1689, 1819, 1831

Use replace-all for exact string `0.20, 0.10, 0.38, 0.95` → `0.25, 0.12, 0.08, 0.95`.

- [ ] **Step 2: Replace inactive purple backgrounds `0.06, 0.02, 0.14` (6 locations)**

| Line | Current | New |
|------|---------|-----|
| 775 | `0.06, 0.02, 0.14, 1` | `0.08, 0.04, 0.03, 1` |
| 1086 | `0.06, 0.02, 0.14, 1` | `0.08, 0.04, 0.03, 1` |
| 1385 | `0.06, 0.02, 0.14, 0.90` | `0.08, 0.04, 0.03, 0.90` |
| 1418 | `0.06, 0.02, 0.14, 1.00` | `0.08, 0.04, 0.03, 1.00` |
| 1693 | `0.06, 0.02, 0.14, 0.90` | `0.08, 0.04, 0.03, 0.90` |
| 2100 | `0.06, 0.02, 0.14, 0.90` | `0.08, 0.04, 0.03, 0.90` |

- [ ] **Step 3: Replace ilvlBg purple `0.12, 0.06, 0.22, 0.85` → `0.15, 0.08, 0.06, 0.85` (2 locations)**

Lines: 1985, 2319

- [ ] **Step 4: Replace DR bar track `0.08, 0.04, 0.16, 0.90` → `0.10, 0.05, 0.04, 0.90` (1 location)**

Line: 2226

- [ ] **Step 5: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(theme): replace all hardcoded purple RGBA with warm mahogany values"
```

---

### Task 6: Update header gradient overlay

**Files:**
- Modify: `addon/BiS_Helper.lua:1779-1780`

- [ ] **Step 1: Replace gradient colors in existing `topGlow:SetGradient` call**

Current (line 1780):
```lua
topGlow:SetGradient("VERTICAL", CreateColor(0.20, 0.06, 0.40, 0.50), CreateColor(0.04, 0.01, 0.10, 0.00))
```

New:
```lua
topGlow:SetGradient("VERTICAL", CreateColor(0.70, 0.14, 0.14, 0.15), CreateColor(0.70, 0.14, 0.14, 0.0))
```

Keep the existing `if topGlow.SetGradient then` guard on line 1779.

- [ ] **Step 2: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(theme): update header gradient to crimson Silvermoon warmth"
```

---

### Task 7: Replace flat borders with `UI-Tooltip-Border` on window frames

**Files:**
- Modify: `addon/BiS_Helper.lua` — backdrop definitions for 5 main frames

These are the **window-level** frames (large panels). Replace `edgeFile = WHITE_TEX, edgeSize = 1` with `edgeFile = BORDER_TEX, edgeSize = 16` and update `insets` to `{ left=4, right=4, top=4, bottom=4 }`.

- [ ] **Step 1: EditFrame backdrop (line 740)**

```lua
-- Old:
bgFile = WHITE_TEX, edgeFile = WHITE_TEX, edgeSize = 1,
insets = { left=1, right=1, top=1, bottom=1 },
-- New:
bgFile = WHITE_TEX, edgeFile = BORDER_TEX, edgeSize = 16,
insets = { left=4, right=4, top=4, bottom=4 },
```

- [ ] **Step 2: StatsFrame backdrop (line 1047)**

Same pattern: `WHITE_TEX` → `BORDER_TEX`, `edgeSize = 1` → `16`, insets `1` → `4`.

- [ ] **Step 3: HelpFrame backdrop (line 1266)**

Same pattern.

- [ ] **Step 4: ShareFrame backdrop (line 1335)**

Same pattern.

- [ ] **Step 5: MainFrame backdrop (lines 1761-1766, multiline)**

Same pattern. Note: this backdrop spans multiple lines with spaces around `=` in insets (`{ left = 1, right = 1, top = 1, bottom = 1 }`) — match the exact formatting when replacing.

- [ ] **Step 6: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(theme): upgrade window frame borders to UI-Tooltip-Border"
```

---

### Task 8: Replace flat borders on buttons and input boxes

**Files:**
- Modify: `addon/BiS_Helper.lua` — remaining ~11 backdrop definitions (buttons, inputs)

For buttons and inputs use `edgeFile = BORDER_TEX, edgeSize = 12` and `insets = { left=3, right=3, top=3, bottom=3 }`.

- [ ] **Step 1: EditFrame buttons and input (lines 772, 788, 839, 889)**

| Line | Element | Current insets | New insets |
|------|---------|----------------|------------|
| 772 | `inputBox` backdrop | `{ left=2, right=2, top=2, bottom=2 }` | `{ left=3, right=3, top=3, bottom=3 }` |
| 788 | `addBtn` backdrop | `{ left=1, right=1, top=1, bottom=1 }` | `{ left=3, right=3, top=3, bottom=3 }` |
| 839 | picker button `pb` backdrop | `{ left=1, right=1, top=1, bottom=1 }` | `{ left=3, right=3, top=3, bottom=3 }` |
| 889 | `resetBtn` backdrop | `{ left=1, right=1, top=1, bottom=1 }` | `{ left=3, right=3, top=3, bottom=3 }` |

Replace each: `edgeFile = WHITE_TEX, edgeSize = 1` → `edgeFile = BORDER_TEX, edgeSize = 12`. Update insets as shown above (note: inputBox has non-standard insets).

- [ ] **Step 2: StatsFrame buttons and input (lines 1083, 1132)**

| Line | Element | Current insets | New insets |
|------|---------|----------------|------------|
| 1083 | `statBox` input backdrop | `{ left=3, right=3, top=2, bottom=2 }` | `{ left=3, right=3, top=3, bottom=3 }` |
| 1132 | stat panel buttons backdrop | `{ left=1, right=1, top=1, bottom=1 }` | `{ left=3, right=3, top=3, bottom=3 }` |

Replace each: `edgeFile = WHITE_TEX, edgeSize = 1` → `edgeFile = BORDER_TEX, edgeSize = 12`. Update insets as shown (note: statBox has non-standard insets).

- [ ] **Step 3: ShareFrame elements (lines 1371, 1425, 1435)**

| Line | Element |
|------|---------|
| 1371 | tab button backdrop |
| 1425 | editBox/scrollframe backdrop |
| 1435 | action button backdrop |

Same replacement. Line 1425 has no `bgFile` — only update `edgeFile` and `edgeSize`.

- [ ] **Step 4: Toolbar buttons (lines 1644, 1681)**

| Line | Element |
|------|---------|
| 1644 | `ToolbarBtn` backdrop |
| 1681 | `ModeButton` backdrop |

Same replacement.

- [ ] **Step 5: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(theme): upgrade button and input borders to UI-Tooltip-Border"
```

---

### Task 9: Update accent bar width

**Files:**
- Modify: `addon/BiS_Helper.lua` — accent bar `SetWidth` in row creation

- [ ] **Step 1: Find the accent bar width definition**

Search for `accent` and `:SetWidth(3)` or `:SetSize` near accent bar creation. Change width from `3` to `4`.

- [ ] **Step 2: Commit**

```bash
git add addon/BiS_Helper.lua
git commit -m "feat(theme): widen accent bar to 4px"
```

---

### Task 10: Copy addon to WoW directory and verify in-game

**Files:** None (deployment step)

- [ ] **Step 1: Copy addon files**

```bash
cp -r "D:/Workspace/wow_addon/BiS_Helper/addon/." "/d/World of Warcraft/_retail_/Interface/AddOns/BiS_Helper/"
```

- [ ] **Step 2: In-game verification checklist**

In WoW, run `/reload` and check:

1. Main frame — warm mahogany background, no purple remnants
2. Ornamental gold borders on all window frames
3. Buttons have ornamental borders (check if edgeSize 12 looks good on small buttons; reduce to 8 if needed)
4. Header has subtle crimson gradient
5. BiS rows — warm green accent bar and glow for matched items
6. Missing rows — warm red accent bar and glow
7. ilvl badges — warm brown background
8. DR bars — warm track background, "CAPPED" text in warm green
9. Footer progress bar — warm track background
10. Edit panel — cream text, warm input backgrounds, ornamental borders
11. Stats panel — consistent theme
12. Help panel — warm gold headers, correct BiS/Missing color descriptions
13. Share panel — consistent theme
14. Hover states on all buttons — warm mahogany tint
15. Text readability — sufficient contrast on all backgrounds

- [ ] **Step 3: Fix any issues found during testing**

If `edgeSize = 12` looks bad on small buttons, change to `edgeSize = 8` in those specific backdrops.

- [ ] **Step 4: Final commit if fixes were needed**

```bash
git add addon/BiS_Helper.lua
git commit -m "fix(theme): adjust border sizes after in-game testing"
```
