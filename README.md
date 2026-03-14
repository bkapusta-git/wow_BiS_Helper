# BiS Helper

**BiS Helper** is a lightweight World of Warcraft addon that lets you instantly check whether every gear slot on your character matches the Best-in-Slot list for your current spec — straight from the game, without Alt-Tabbing to Wowhead.

---

## Features

- **Auto-detects your spec** — opens the correct BiS list the moment you log in or swap specializations.
- **Raid & Mythic+ modes** — toggle between two curated lists with a single click.
- **Enhanced Gear Tracking**
  - **Enchant column** — displays current enchants with auto-cleaning (removes "Enchanted:" prefixes).
  - **Gems column** — shows up to 3 gem icons per item.
  - **Gear track badge** — shows the track (Myth / Hero / Champion / …) with localization support.
- **Modern UI & Visuals**
  - **Resizable window** — grab the bottom-right handle to scale the UI; position and size are saved per account.
  - **Texture-based indicators** — uses professional game icons (Green check / Red cross) for BiS status.
  - **Item level pill** — quick at-a-glance ilvl for every slot.
- **Smart Tooltips**
  - Hover **Item Icon or Name** to see equipped item details.
  - Hover **Enchant Name** to see specific enchantment info (with automatic fallback to item info).
  - Hover **Gem Icons** to see gem properties.
  - Hover **Stat Priority** in the header for spec-specific notes.
  - Hover **BiS Item Name** to preview the target item.
- **Live updates** — the panel refreshes automatically when you change gear or specializations.

---

## Usage

| Action | How |
|--------|-----|
| Open / close | `/bis` |
| Resize | Drag the handle in the **bottom-right corner** |
| Switch mode | Click **Raid** or **Mythic+** button in the header |
| Force refresh | Click the **Refresh** button |

---

## Supported Specs — Midnight (Season 1)

All 13 classes and all 40 specializations are covered, including the new **Devourer** and **Vengeance** updates for Demon Hunters.

---

## Installation

1. Copy the `BiS_Helper` folder into:
   ```
   World of Warcraft\_retail_\Interface\AddOns\
   ```
2. Launch the game (or type `/reload`).
3. Type `/bis` to open the panel.

---

## Technical Details

- **Game version:** The War Within / Midnight (Interface 12.0.1+)
- **Storage:** Settings (window size, position, mode) are saved in `BiSHelperDB`.
- **Localization:** Improved detection for "Track" and "Enchanted" lines to support non-English clients.

---

## License

MIT — free to use, fork, and modify.
