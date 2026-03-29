# Blizzard API Loot Scraper — Design Spec

**Date:** 2026-03-29
**Status:** Approved
**Replaces:** Wowhead tooltip scraper (`scrape_mplus_loot.py` + `parse_loot.py`)

## Goal

Replace the manual Wowhead-based loot scraping pipeline with a single script that fetches M+ dungeon loot data exclusively from the Blizzard Game Data API. This ensures a complete, authoritative item list without manually curating item IDs.

## Requirements

- All data sourced from Blizzard API only — no Wowhead dependency
- Auto-detect current M+ season with manual override option
- Stats and ilvl at base level (as returned by Item API)
- Include all items the API returns, even without boss/dungeon attribution
- Items dropping from multiple bosses: store all bosses as joined string
- Python stdlib only (no pip dependencies)
- Output: JSON intermediate file + Lua for addon (same format as existing `mplus_loot.lua`)

## Architecture

### Authentication & Configuration

**File:** `tools/.env` (gitignored)
```
BLIZZARD_CLIENT_ID=xxx
BLIZZARD_CLIENT_SECRET=xxx
BLIZZARD_REGION=eu
BLIZZARD_LOCALE=en_US
```

OAuth2 client credentials flow: `POST https://oauth.battle.net/token` → bearer token. Fresh token per run (no caching). Clear error message and exit if `.env` missing or credentials invalid.

### Season & Dungeon Discovery

1. `GET /data/wow/mythic-keystone/season/index` → latest season ID
2. `GET /data/wow/mythic-keystone/season/{seasonId}` → dungeon list

Override via `--season-id <id>` CLI flag.

**Dungeon → Journal mapping:** `GET /data/wow/mythic-keystone/dungeon/{dungeonId}` returns dungeon object with journal instance reference. If not available directly, fallback to name-based lookup against `GET /data/wow/journal-instance/index`.

**Name matching caveat:** API names may differ between endpoints (e.g. "The Magister's Terrace" vs "Magister's Terrace"). The script normalizes names for comparison by lowercasing and stripping common prefixes ("the ", "the"). If normalized match fails, a hardcoded override dict maps known exceptions.

**Output:** List of `(dungeon_name, journal_instance_id)` pairs.

### Item Collection (Journal API)

For each dungeon:
1. `GET /data/wow/journal-instance/{instanceId}` → encounter (boss) list
2. `GET /data/wow/journal-encounter/{encounterId}` → items per boss

Extracted per item:
- `itemID` — from encounter items list
- `dungeon` — parent instance name
- `boss` — encounter name

**Multiple bosses:** If an item appears under 2+ encounters, store as joined string: `"Kael'thas / Delrissa"`.

**Items without boss:** If journal instance has items outside encounters (general instance loot), add with `boss=None`, `dungeon` set.

### Item Enrichment (Item API)

For each collected item ID:
`GET /data/wow/item/{itemId}` → full item data at base ilvl.

**Extracted fields:**
- `name` — authoritative name (overrides journal name)
- `quality` — Epic, Rare, etc.
- `level` — base ilvl
- `inventory_type` — mapped to slot name (HEAD→Head, FINGER→Finger, etc.)
- `item_class` + `item_subclass` — Armor→Cloth/Leather/Mail/Plate, Weapon→Sword/Dagger/etc.
- `preview_item.stats[]` — secondary stats with type and value at base ilvl

**Stats storage:**
- `stats` string: `"Crit / Haste"` (for Lua output)
- `statsValues` dict: `{"Crit": 150, "Haste": 100}` (in JSON, for future use)

**Rate limiting:** `time.sleep(0.1)` between requests (10 req/s, matching Blizzard's 36000/hour average). ~350 total requests ≈ 35 seconds. All API calls wrapped in retry with exponential backoff (3 attempts, delays 1s/2s/4s) for HTTP 429 and 5xx errors.

### Output

**Step 1 — JSON:** `tools/mplus_loot_{season_slug}.json`

```json
{
    "source": "Blizzard Game Data API",
    "season": "Midnight Season 1",
    "season_id": 14,
    "fetched_at": "2026-03-29 15:30:00",
    "total_items": 195,
    "dungeons": ["Magister's Terrace", "..."],
    "items": [
        {
            "itemID": 251096,
            "name": "Some Necklace",
            "quality": "Epic",
            "ilvl": 597,
            "slot": "Neck",
            "armorType": null,
            "weaponType": null,
            "stats": "Crit / Haste",
            "statsValues": {"Crit": 150, "Haste": 100},
            "dungeon": "Magister's Terrace",
            "boss": "Kael'thas Sunstrider"
        }
    ]
}
```

**Step 2 — Lua:** Update existing `generate_loot_lua.py` to read new JSON format. Output to `addon/data/mplus_loot.lua` — same structure as current, with new `ilvl` field added:

```lua
{ itemID=251096, name="Some Necklace", slot="Neck", ilvl=597, armorType=nil,
  weaponType=nil, stats="Crit / Haste", dungeon="Magister's Terrace",
  boss="Kael'thas / Delrissa" },
```

### CLI Interface

**New file:** `tools/fetch_blizzard_loot.py` (replaces `scrape_mplus_loot.py` + `parse_loot.py`)

```bash
# Auto-detect season
python tools/fetch_blizzard_loot.py

# Override season
python tools/fetch_blizzard_loot.py --season-id 14

# Skip Lua generation
python tools/fetch_blizzard_loot.py --no-lua

# Different region
python tools/fetch_blizzard_loot.py --region us
```

| Parameter | Default | Description |
|---|---|---|
| `--season-id` | auto-detect | M+ season ID |
| `--region` | from `.env` (eu) | API region (eu/us/kr/tw) |
| `--locale` | from `.env` (en_US) | Item name language |
| `--no-lua` | false | Skip Lua generation |
| `--output-dir` | `tools/` | JSON output directory |

**Console output:**
```
Authenticating... OK
Detecting current M+ season... Midnight Season 1 (id=14)
Found 8 dungeons
Fetching journal data... 8/8 instances, 32 encounters
Fetching item details... 195/195 items
Saved tools/mplus_loot_midnight_s1.json (195 items)
Generating addon/data/mplus_loot.lua... done (195 items)
```

**Dependencies:** Python stdlib only (`urllib`, `json`, `os`, `time`, `argparse`).

## Files Changed

| Action | File | Notes |
|---|---|---|
| Create | `tools/fetch_blizzard_loot.py` | New main script |
| Create | `tools/.env` | API credentials (gitignored) |
| Update | `tools/generate_loot_lua.py` | Read new JSON format, add ilvl field |
| Update | `.gitignore` | Add `tools/.env` |
| Delete | `tools/scrape_mplus_loot.py` | Replaced |
| Delete | `tools/parse_loot.py` | Replaced |
| Regenerate | `addon/data/mplus_loot.lua` | From new pipeline |

## API Endpoints Used

| Endpoint | Purpose |
|---|---|
| `POST /oauth/token` | Authentication |
| `GET /data/wow/mythic-keystone/season/index` | Season auto-detect |
| `GET /data/wow/mythic-keystone/season/{id}` | Dungeon list for season |
| `GET /data/wow/mythic-keystone/dungeon/{id}` | Dungeon → journal instance mapping |
| `GET /data/wow/journal-instance/{id}` | Encounters per dungeon |
| `GET /data/wow/journal-encounter/{id}` | Items per boss |
| `GET /data/wow/item/{id}` | Item details (name, slot, stats, ilvl) |
