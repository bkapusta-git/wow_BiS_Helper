# BiS Helper

**BiS Helper** is a lightweight World of Warcraft addon that lets you instantly check whether every gear slot on your character matches the Best-in-Slot list for your current spec — straight from the game, without Alt-Tabbing to Wowhead.

---

## Features

- **Auto-detects your spec** — opens the correct BiS list the moment you log in or swap specializations
- **Raid & Mythic+ modes** — toggle between two curated lists with a single click; some specs have different BiS for each content type
- **Slot-by-slot comparison** — every equippable slot (Head through Off Hand) is shown in one scrollable panel
- **Color-coded status indicators**
  - 🟢 Green — you are wearing the BiS item for that slot
  - 🔴 Red — you are missing the BiS item; the target item name is shown in red
  - ⚫ Grey — no BiS data for this slot (e.g. a spec that doesn't use Off Hand)
- **Gear track badge** — shows the track (Myth / Hero / Champion / …) of each equipped item
- **Item level pill** — quick at-a-glance ilvl for every slot
- **Stat priority display** — the header shows your spec's secondary stat chain with colored labels and diminishing-returns thresholds
- **Hover tooltips** — hover any row to see your equipped item tooltip; hover the BiS item name to preview the target item
- **Live updates** — the panel refreshes automatically whenever you equip or unequip an item
- **Movable window** — drag the panel anywhere on screen

---

## Usage

| Action | How |
|--------|-----|
| Open / close | `/bis` |
| Switch mode | Click **Raid** or **Mythic+** button in the panel header |
| Force refresh | Click the **Refresh** button |
| See equipped item tooltip | Hover the slot row |
| See BiS item tooltip | Hover the red item name in the BiS column |

---

## Supported Specs — Midnight (Season 1)

All 13 classes and all 40 specializations are covered.

| Class | Specs |
|-------|-------|
| Death Knight | Blood · Frost · Unholy |
| Demon Hunter | Havoc · Vengeance |
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

1. Download and unzip the addon.
2. Copy the `BiS_Helper` folder into:
   ```
   World of Warcraft\_retail_\Interface\AddOns\
   ```
3. Launch the game (or type `/reload`).
4. Type `/bis` to open the panel.

---

## Data Sources

BiS lists and stat priorities are sourced from:

- [Wowhead Class Guides](https://www.wowhead.com/guides/classes) — BiS gear lists
- [Wowhead Stat Priority Guides](https://www.wowhead.com/guides/classes) — secondary stat priorities and DR thresholds

Data reflects **Midnight Season 1** (patch 12.0.1). Lists will be updated as the meta evolves.

---

## FAQ

**Does it work for all specs automatically?**
Yes. The addon reads your active specialization each time the panel is opened or refreshed. No configuration needed.

**What if my spec isn't in the list?**
The panel will display *"No BiS data for: CLASS_SPEC"* in the header. All 40 specs are currently included for Midnight Season 1.

**Why does the panel show "loading…" for some items?**
Item data is fetched asynchronously from the game client. Items that haven't been cached yet show "loading…" and update automatically within a second or two.

**The BiS list seems outdated — how do I report it?**
Please open an issue on the project repository with a link to the updated Wowhead guide and the correct item name/ID.

---

## Compatibility

- **Game version:** The War Within / Midnight (Interface 12.0.1+)
- **Dependencies:** None
- **Conflicts:** None known

---

## License

MIT — free to use, fork, and modify.
