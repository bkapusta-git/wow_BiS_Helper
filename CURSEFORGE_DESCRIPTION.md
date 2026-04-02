# BiS Helper

BiS Helper is a lightweight gear checker that compares your current equipment against Best-in-Slot lists for your spec. It eliminates the need to constantly alt-tab to Wowhead or class discords during raids or mythic+ runs.

The addon automatically detects your specialization and updates the gear list as soon as you respec.

---

## Core Features

### Gear Comparison Table
The main window (`/bis`) provides a complete breakdown of all 16 equipment slots:
- **Match Status:** Instant visual feedback (Green/Red) on whether your item is BiS.
- **Detailed Info:** View item names, icons, item levels, enchants, and gems.
- **Upgrade Paths:** Displays current upgrade tracks (e.g. Hero 2/6) directly in the list.
- **Drop Sources:** Shows where your BiS items drop so you know what to farm next.

### Stat Priorities and DR Caps
Stay optimized with built-in stat tracking:
- **Visual Progress:** Bars showing how close you are to Diminishing Returns (DR) caps.
- **Customizable:** You can manually edit stat priorities and caps in the settings if you prefer a custom build.

### Profile Management
- **Multiple Profiles:** Save different BiS setups for various scenarios (e.g. Single Target vs AoE).
- **Import/Export:** Share your entire profile (items, stats, and caps) as an encoded string. Copy-paste to share with friends or guildmates.

### Dawncrest Tracker
A compact bar above the gear table tracks your Dawncrest progress:
- Monitor all 5 tiers of crests.
- Shows current amount in bags, total earned this season, and the season cap.
- Hover for detailed tooltips on drop sources.

### Loot Browser
Browse all Mythic+ loot drops from Midnight Season 1 directly in-game:
- **464 items** from all 8 M+ dungeons, searchable and filterable.
- **Smart Filters:** Search by name, filter by slot, armor type, dungeon, or secondary stat.
- **Current Season:** Toggle to show only items from the current M+ rotation.
- **My Class:** Filter to show only items your class can equip.
- **Quick Access:** Open with the **Loot** toolbar button or `/bis loot`.

---

## Customization and Compatibility
- **Manual Overrides:** Use Wowhead item IDs to set custom BiS items for any slot.
- **UI Settings:** The window is resizable and movable; position and scale are saved between sessions.
- **Full Spec Support:** Pre-loaded data for all 40 specs in Midnight Season 1, including Devourer Demon Hunter.
- **No Dependencies:** Built with performance in mind. No external libraries or heavy frameworks required.

## Quick Start
1. Open the panel with `/bis` or use the minimap icon.
2. Toggle between **Raid** and **Mythic+** lists.
3. Check your progress: **Green rows** are complete, **Red rows** still need upgrades.

---

*Found a bug? Report it on the CurseForge issue tracker.*