# BiS Helper

**BiS Helper** is a lightweight World of Warcraft addon that lets you instantly check whether every gear slot on your character matches the Best-in-Slot list for your current spec — straight from the game, without Alt-Tabbing to Wowhead.

---

## Features

- **Auto-detects your spec** — opens the correct BiS list the moment you log in or swap specializations.
- **Raid & Mythic+ modes** — toggle between two curated lists with a single click.
- **Color-coded rows** — green tint for BiS items equipped, red tint for slots that need an upgrade, grey for unknown.
- **Enhanced gear columns**
  - **Enchant** — displays the current enchant with hover tooltip.
  - **Gems** — shows up to 3 gem icons per item with hover tooltips.
  - **Track badge** — shows the upgrade track (Myth / Hero / Champion / …).
  - **iLvl pill** — quick at-a-glance item level for every slot.
- **Smart tooltips** — hover over item icons, enchants, gems, BiS item names and all header buttons to get instant information.
- **Customizable BiS lists** — override any BiS item per slot via the **Edit** panel.
- **Customizable stat priority** — edit stat weights and DR caps via the **Stats** panel.
- **Live updates** — the panel refreshes automatically when you change gear or specializations.
- **Resizable & movable window** — grab the bottom-right handle to resize; position and size are saved per account.
- **Minimap button** — draggable around the minimap, angle saved per account.
- **Addon Compartment** support.

---

## Usage

| Action | How |
|--------|-----|
| Open / close | `/bis` or click the minimap button |
| Switch mode | Click **Raid** or **Mythic+** in the header |
| Force refresh | Click the **Refresh** button |
| Override a BiS item | Click **Edit** |
| Change stat priority | Click **Stats** |
| Show help | Click **?** |
| Resize | Drag the handle in the **bottom-right corner** |

---

## Supported Specs — Midnight Season 1

All **13 classes** and all **40 specializations** are fully covered, including the new **Devourer** Demon Hunter spec.

| Class | Specs |
|-------|-------|
| Death Knight | Blood · Frost · Unholy |
| Demon Hunter | Havoc · Vengeance · Devourer |
| Druid | Balance · Feral · Guardian · Restoration |
| Evoker | Augmentation · Devastation · Preservation |
| Hunter | Beast Mastery · Marksmanship · Survival |
| Mage | Arcane · Fire · Frost |
| Monk | Brewmaster · Mistweaver · Windwalker |
| Paladin | Holy · Protection · Retribution |
| Priest | Discipline · Holy · Shadow |
| Rogue | Assassination · Outlaw · Subtlety |
| Shaman | Elemental · Enhancement · Restoration |
| Warlock | Affliction · Demonology · Destruction |
| Warrior | Arms · Fury · Protection |

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
- **No dependencies** — works without LibStub or any external libraries.
- **Storage:** Window size, position, mode, overrides and stat edits are saved in `BiSHelperDB`.

---

## License

MIT — free to use, fork, and modify. See [LICENSE](LICENSE).
