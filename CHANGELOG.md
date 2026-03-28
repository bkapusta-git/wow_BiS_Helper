# Changelog

## [0.8.5] — 2026-03-29

### Added
- **Loot Browser (beta)** — new standalone window for browsing all 190 Mythic+ items from Midnight Season 1
- Search items by name, filter by slot, armor type, dungeon, and secondary stat
- Armor type filter defaults to your class (e.g. Cloth for Mage) — shows accessories and weapons for all classes
- Hover any item for a full GameTooltip, click to copy itemID
- New "Loot" button in toolbar (next to Mythic+) and `/bis loot` slash command
- Custom dropdown menu component for filter controls
- Item data sourced from Wowhead and bundled as addon data file

### Fixed
- Fixed Loot button overlapping other toolbar buttons — moved to left side of toolbar

## [0.8.0] — 2026-03-27

### Added
- Dawncrest progress bar — shows all 5 crest tiers (Adventurer, Veteran, Champion, Hero, Myth) with current quantity, season earned, and season cap
- Crest bar sits between toolbar and gear table, updates live via CURRENCY_DISPLAY_UPDATE
- Tooltips with full details: in bags count, earned/cap, status (remaining or CAPPED), and drop sources
- Settings panel — new "Settings" toolbar button opens a configuration panel
- Per-crest visibility toggles and master show/hide toggle in Settings
- Settings persist across sessions in SavedVariables

## [0.7.1] — 2026-03-26

### Fixed
- Fixed "no BiS data" on non-English WoW clients (German, French, etc.) — spec detection now uses locale-independent specID instead of localized spec name

## [0.7.0] — 2026-03-26

### Added
- Profiles panel — save, load, rename, and delete named BiS profiles
- New "Profiles" toolbar button (between Share and Help)
- Profiles are universal — save from any spec, load to any spec (with mismatch warning)
- Unlimited named profiles stored in SavedVariables

## [0.6.1] — 2026-03-25

### Changed
- Removed redundant BiS status column (✓/✗) — accent bar and row glow already indicate status
- BiS item name now stays visible (in green) when equipped instead of disappearing
- Source column widened with reclaimed space

## [0.6.0] — 2026-03-24

### Added
- Upgrade level displayed in Track column (e.g. "Champion 2/6" instead of "Champion Track")

### Changed
- Track column widened to accommodate upgrade level text
- Adjusted column layout — BiS separator and columns shifted to match wider Track

### Fixed
- Window size no longer gets overridden by WoW layout cache (SetUserPlaced fix)

## [0.5.0] — 2026-03-23

### Added
- Copy item links — Shift+click on any equipped or BiS item to get a Wowhead link popup, Shift+Ctrl+click for raw Item ID
- Escape key closes all addon panels one at a time (sub-panels first, then main window)
- Help panel updated with Copy Item Link section

## [0.4.0] — 2026-03-22

### Changed
- Complete visual theme overhaul — new Silvermoon / Sin'dorei aesthetic replacing the void-purple motif
- Warm mahogany backgrounds, crimson header gradient, parchment-cream text
- Ornamental gold borders (UI-Tooltip-Border) on all window frames and buttons
- Warmed status colors — softer greens and reds for BiS/missing indicators
- Wider accent bars (4px) for better visibility

## [0.3.0] — 2026-03-20

### Added
- Share panel — export your full BiS profile (items + stat priority + DR caps) as an encoded string, share it via Discord/forums, and import profiles from others
- Import confirmation dialogs with spec mismatch warning

### Changed
- Redesigned main window header — two-row layout with logically grouped toolbar buttons (Filter/Refresh | Raid/M+ | Stats/Edit/Share/Help)
- All header buttons now use consistent custom styling (Refresh no longer uses Blizzard default button template)
- Title left-aligned with spec name inline instead of truncated centered title

## [0.2.1] — 2026-03-18

### Changed
- Custom addon icon (TGA) replaces placeholder Achievement_Zone_Silvermoon on minimap button, addon list, and Addon Compartment
- Filter button to hide BiS-complete rows (toggle show/hide slots already matching BiS)
- Main frame strata raised to prevent overlap issues

## [0.2.0] — 2026-03-18

### Added
- DR caps progress bars — visual bars showing your current stat rating vs diminishing returns cap for each stat (Haste, Crit, Mastery, Versatility) with color fill and hover tooltip
- BiS progress footer — counter at the bottom of the main window showing how many slots match BiS (e.g. "9/16 BiS (56%)") with color gradient progress bar
- Item ID help hint in Edit panel explaining where to find Item IDs on Wowhead

## [0.1.0] — 2026-03-15

### Added
- Initial release
- Best in Slot gear comparison for all 40 specs (13 classes, Midnight Season 1)
- Raid and Mythic+ BiS lists per spec
- Stat priority display with diminishing returns caps
- Enchant and gem columns with tooltips
- Upgrade track detection (Myth / Hero / Champion / Veteran…)
- Resizable and movable main window
- Minimap button (draggable)
- Addon Compartment support
- Edit panel — override BiS items per slot
- Stats panel — customize stat priority and DR caps
- Help panel (`?` button)
