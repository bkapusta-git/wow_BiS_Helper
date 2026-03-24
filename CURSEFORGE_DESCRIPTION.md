# BiS Helper

Simple gear checker — shows which slots match your Best in Slot list and which still need upgrades. No more alt-tabbing to Wowhead mid-raid.

---

## How it works

Open the panel with `/bis` (or the minimap button), pick Raid or Mythic+, and you'll see all 16 gear slots compared against the BiS list for your current spec. Green = you have it, red = you don't. That's it.

The addon detects your spec automatically and switches the list when you respec.

## What you see per slot

- Equipped item with icon, name, and item level
- Enchant and gems (with tooltips)
- Upgrade track and level (e.g. Hero 2/6, Champion 4/6)
- BiS item name and where it drops
- Match status (checkmark or X)

At the bottom there's a progress bar showing how many slots are BiS out of the total (e.g. "9/16 BiS").

## Stat priority & DR caps

The header shows your spec's stat priority and diminishing returns caps as visual bars — you can see at a glance how close you are to each cap. Both are editable if you disagree with the defaults.

## Share / Export / Import

Share your BiS profile with friends or save it as a backup. Click the Share button in the toolbar to export your full profile (items, stat priority, DR caps) as an encoded string. Send it via Discord, forums, or paste it anywhere — the recipient can import it with one click.

## Customization

- Override any BiS item per slot (Edit panel — paste a Wowhead item ID)
- Adjust stat priority and DR caps (Stats panel)
- Filter to show only missing slots (Filter button)
- Window is resizable, movable, position saved between sessions

## Specs

All 40 specs covered for Midnight Season 1, including the new Devourer DH spec. Data sourced from Wowhead BiS guides.

## Quick start

1. Type `/bis` or click the minimap button
2. Pick Raid or Mythic+
3. Green rows = done, red rows = go farm

---

No dependencies, no libraries. Works out of the box.

*Bug reports welcome via the CurseForge issue tracker.*
