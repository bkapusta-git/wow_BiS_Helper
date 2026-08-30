# BiS Helper

I got tired of alt-tabbing to Wowhead to check what I should be wearing, so I made this. BiS Helper shows your current gear next to your Best-in-Slot list for every slot, tells you where each piece drops, and tracks your stats.

Works for all 40 specs. Detects your class and spec automatically, updates when you respec.

`/bis` to open. I have it on a CTRL+C macro, but you'll need to set that up yourself.

---

## Gear Comparison

The main window shows all 16 equipment slots: what you have equipped vs. what your BiS is (you can override any slot with your own pick).

- Green = BiS. Red = not yet.
- Shows item names, icons, ilvl, enchants, gems, and upgrade track (e.g. Hero 2/6).
- Drop source next to every BiS item, so you know where to go.
- **Filter** button hides the slots you've already completed.

BiS data pre-loaded for all 40 specs in Midnight Season 2 (including Devourer DH).

---

## Enchants & Gems

The Enchant column doesn't just name your enchant, it judges it. Green when you're on the recommended one at max crafting rank, and a warning when you're a rank behind, wearing something outside the season's catalogue, or haven't enchanted the slot at all.

Hover it and you get the rank you're on, the stat, and how many points the enchant is actually worth on that item — measured off your own gear, so it's correct at any item level. If yours isn't the recommended one, it tells you which to use.

Gems work the same way: a ring around anything that isn't the recommended gem, and empty sockets show up as placeholders instead of just not being there. No more finding an unsocketed ring three weeks later.

Enchant picks follow your spec's stat priority. Where a slot's enchants grant stats no stat priority ranks — this season that's everything except rings, which is most of them — the column shows what you're wearing and leaves it alone rather than guessing at you. You can pin a specific enchant per slot if you sim differently.

---

## Stat Priorities

Stat priorities for Raid and Mythic+ come with each spec. DR cap bars show where you're at relative to Diminishing Returns thresholds.

You can edit everything: stat order, cap values, notes. If you sim differently than the defaults, just change them.

---

## Loot Browser

Browse loot from M+ dungeons and raids in one place. 223 M+ items from the Season 2 dungeon rotation, plus 216 raid items from all seven current-season raids including The Venomous Abyss.

- Filter by slot, armor type, source (dungeon or raid), or secondary stats. Or just search by name.
- **Type** filter to show All, M+ only, or Raid only.
- **My Class** shows only gear your class can equip. Way better than the Dungeon Journal for quickly finding what's relevant.
- **Current Season** toggle hides old expansion items.

`/bis loot` to open (or button in UI)

---

## Crest Tracker

Bar above the gear table showing your Mistcrest progress across all 5 tiers: how many you have, how many you've earned this season, and the cap. Hover for drop source tooltips. Handy for tracking when a track hits 6/6 and the next tier upgrade becomes free.

---

## Share

Export your profile (items + stats + DR caps) as a string. Paste it to a guildie or import someone else's setup. Useful for alts or sharing builds in Discord.

You can also override individual slots with Wowhead item IDs if you want a custom BiS.

---

## Themes

5 built-in UI themes: **Silvermoon** (default — warm mahogany + gold), **Gray** (neutral dark), **Kaldorei** (deep indigo + moonsilver), **Frost** (navy + icy blue), **Ember** (charcoal + amber). Switch in Settings, takes effect after `/reload`.

---

## Other Details

- No dependencies. No Ace3, no LibStub.
- Minimap button and Addon Compartment supported.
- `/bis` for the main window, `/bis loot` for the Loot Browser.

---

## Getting Started

1. `/bis` or click the minimap icon.
2. Pick **Raid** or **Mythic+**.
3. Green rows are done, red rows need work.

---

*Bug reports and suggestions welcome — just leave a comment on the addon page.*
