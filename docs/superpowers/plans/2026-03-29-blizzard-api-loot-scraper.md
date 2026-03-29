# Blizzard API Loot Scraper — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the Wowhead-based loot scraper with a single Python script that fetches M+ dungeon loot exclusively from the Blizzard Game Data API.

**Architecture:** One new script (`tools/fetch_blizzard_loot.py`) handles the full pipeline: OAuth2 auth → season detection → journal traversal → item enrichment → JSON output. The existing `tools/generate_loot_lua.py` is updated to read the new JSON format and add `ilvl` field. Old Wowhead scripts are deleted.

**Tech Stack:** Python 3.x stdlib only (`urllib`, `json`, `os`, `time`, `argparse`)

**Spec:** `docs/superpowers/specs/2026-03-29-blizzard-api-loot-scraper-design.md`

---

## File Map

| Action | File | Responsibility |
|---|---|---|
| Create | `tools/fetch_blizzard_loot.py` | Full pipeline: auth, season, journal, items, JSON output |
| Create | `tools/.env.example` | Template for API credentials (committed) |
| Update | `tools/generate_loot_lua.py` | Read new JSON format, add `ilvl` field to Lua output |
| Update | `.gitignore` | Add `tools/.env` |
| Delete | `tools/scrape_mplus_loot.py` | Replaced by new script |
| Delete | `tools/parse_loot.py` | Replaced by new script |

---

### Task 1: Project setup — .gitignore and .env template

**Files:**
- Modify: `.gitignore`
- Create: `tools/.env.example`

- [ ] **Step 1: Update .gitignore**

Add `tools/.env` to `.gitignore` so API credentials are never committed:

```gitignore
# Claude Code local settings
.claude/settings.local.json

# Blizzard API credentials
tools/.env
```

- [ ] **Step 2: Create .env.example template**

```
# Blizzard API credentials — copy this file to .env and fill in your values
# Register at https://develop.battle.net to get client_id and client_secret
BLIZZARD_CLIENT_ID=
BLIZZARD_CLIENT_SECRET=
BLIZZARD_REGION=eu
BLIZZARD_LOCALE=en_US
```

- [ ] **Step 3: Commit**

```bash
git add .gitignore tools/.env.example
git commit -m "chore: add .env template and gitignore for Blizzard API credentials"
```

---

### Task 2: Auth and API client module

**Files:**
- Create: `tools/fetch_blizzard_loot.py`

This task creates the script skeleton with OAuth2 authentication and a reusable API request function with retry logic.

- [ ] **Step 1: Create fetch_blizzard_loot.py with imports, .env loader, and auth**

```python
"""
Fetch M+ dungeon loot from the Blizzard Game Data API.
Outputs: tools/mplus_loot_{season_slug}.json
Optionally generates: addon/data/mplus_loot.lua (via generate_loot_lua.py)
"""

import argparse
import json
import os
import sys
import time
import urllib.error
import urllib.parse
import urllib.request

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))


def load_env():
    """Load key=value pairs from tools/.env file."""
    env_path = os.path.join(SCRIPT_DIR, ".env")
    if not os.path.exists(env_path):
        print(f"ERROR: {env_path} not found.")
        print("Copy tools/.env.example to tools/.env and fill in your Blizzard API credentials.")
        sys.exit(1)
    env = {}
    with open(env_path, "r") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            if "=" in line:
                key, val = line.split("=", 1)
                env[key.strip()] = val.strip()
    return env


def get_access_token(client_id, client_secret, region):
    """Obtain OAuth2 bearer token via client credentials flow."""
    token_url = f"https://{region}.battle.net/oauth/token"
    data = urllib.parse.urlencode({"grant_type": "client_credentials"}).encode("utf-8")

    # HTTP Basic auth: client_id:client_secret base64-encoded
    import base64
    credentials = base64.b64encode(f"{client_id}:{client_secret}".encode()).decode()

    req = urllib.request.Request(token_url, data=data, headers={
        "Authorization": f"Basic {credentials}",
        "Content-Type": "application/x-www-form-urlencoded",
    })

    try:
        with urllib.request.urlopen(req, timeout=15) as resp:
            body = json.loads(resp.read().decode("utf-8"))
            return body["access_token"]
    except (urllib.error.HTTPError, urllib.error.URLError, KeyError) as e:
        print(f"ERROR: Failed to authenticate with Blizzard API: {e}")
        print("Check your BLIZZARD_CLIENT_ID and BLIZZARD_CLIENT_SECRET in tools/.env")
        sys.exit(1)


def api_get(url, token, retries=3):
    """GET request to Blizzard API with retry and exponential backoff."""
    for attempt in range(retries):
        try:
            req = urllib.request.Request(url, headers={
                "Authorization": f"Bearer {token}",
                "Accept": "application/json",
            })
            with urllib.request.urlopen(req, timeout=15) as resp:
                return json.loads(resp.read().decode("utf-8"))
        except urllib.error.HTTPError as e:
            if e.code in (429, 500, 502, 503, 504) and attempt < retries - 1:
                delay = 2 ** attempt  # 1s, 2s, 4s
                print(f"  HTTP {e.code}, retrying in {delay}s...")
                time.sleep(delay)
                continue
            raise
        except urllib.error.URLError as e:
            if attempt < retries - 1:
                delay = 2 ** attempt
                print(f"  Network error, retrying in {delay}s: {e}")
                time.sleep(delay)
                continue
            raise
    return None


def api_url(region, path, namespace="static", locale="en_US"):
    """Build a Blizzard API URL with namespace and locale query params."""
    base = f"https://{region}.api.blizzard.com{path}"
    params = urllib.parse.urlencode({"namespace": f"{namespace}-{region}", "locale": locale})
    return f"{base}?{params}"
```

- [ ] **Step 2: Add a main() stub and verify auth works**

Append to the same file:

```python
def main():
    parser = argparse.ArgumentParser(description="Fetch M+ loot from Blizzard API")
    parser.add_argument("--season-id", type=int, default=None, help="Override M+ season ID")
    parser.add_argument("--region", type=str, default=None, help="API region (eu/us/kr/tw)")
    parser.add_argument("--locale", type=str, default=None, help="Locale for item names")
    parser.add_argument("--no-lua", action="store_true", help="Skip Lua generation")
    parser.add_argument("--output-dir", type=str, default=SCRIPT_DIR, help="JSON output directory")
    args = parser.parse_args()

    # Load config
    env = load_env()
    client_id = env.get("BLIZZARD_CLIENT_ID")
    client_secret = env.get("BLIZZARD_CLIENT_SECRET")
    region = args.region or env.get("BLIZZARD_REGION", "eu")
    locale = args.locale or env.get("BLIZZARD_LOCALE", "en_US")

    if not client_id or not client_secret:
        print("ERROR: BLIZZARD_CLIENT_ID and BLIZZARD_CLIENT_SECRET must be set in tools/.env")
        sys.exit(1)

    # Authenticate
    print("Authenticating...", end=" ", flush=True)
    token = get_access_token(client_id, client_secret, region)
    print("OK")


if __name__ == "__main__":
    main()
```

- [ ] **Step 3: Manual test — run the script with real credentials**

```bash
cd tools
python fetch_blizzard_loot.py
```

Expected output:
```
Authenticating... OK
```

If `.env` is missing or credentials are wrong, expect a clear error message.

- [ ] **Step 4: Commit**

```bash
git add tools/fetch_blizzard_loot.py
git commit -m "feat(tools): add Blizzard API loot scraper — auth and API client"
```

---

### Task 3: Season detection and dungeon discovery

**Files:**
- Modify: `tools/fetch_blizzard_loot.py`

- [ ] **Step 1: Add season detection function**

Add after `api_url()`:

```python
def detect_season(token, region, locale, override_id=None):
    """Detect current M+ season or use override. Returns (season_id, season_name)."""
    if override_id:
        url = api_url(region, f"/data/wow/mythic-keystone/season/{override_id}", "dynamic", locale)
        data = api_get(url, token)
        return override_id, data.get("season_name", {}).get("name", f"Season {override_id}")

    url = api_url(region, "/data/wow/mythic-keystone/season/index", "dynamic", locale)
    data = api_get(url, token)
    seasons = data.get("seasons", [])
    if not seasons:
        print("ERROR: No M+ seasons found.")
        sys.exit(1)
    # Latest season = highest ID
    latest = max(seasons, key=lambda s: s["id"])
    season_id = latest["id"]

    # Fetch season name
    url = api_url(region, f"/data/wow/mythic-keystone/season/{season_id}", "dynamic", locale)
    season_data = api_get(url, token)
    season_name = season_data.get("season_name", {}).get("name", f"Season {season_id}")

    return season_id, season_name
```

- [ ] **Step 2: Add dungeon discovery with journal instance mapping**

```python
def normalize_name(name):
    """Normalize dungeon name for comparison — lowercase, strip 'the ' prefix."""
    n = name.lower().strip()
    if n.startswith("the "):
        n = n[4:]
    return n


# Hardcoded overrides for known name mismatches between M+ and Journal APIs
DUNGEON_NAME_OVERRIDES = {
    # "normalized m+ name": journal_instance_id
    # Add entries here if name-based lookup fails for specific dungeons
}


def discover_dungeons(token, region, locale, season_id):
    """Get dungeon list for a season and map to journal instance IDs.
    Returns list of dicts: {name, journal_instance_id}
    """
    # Get dungeons from season
    url = api_url(region, f"/data/wow/mythic-keystone/season/{season_id}", "dynamic", locale)
    season_data = api_get(url, token)

    periods = season_data.get("periods", [])
    if not periods:
        print("ERROR: No periods found for this season.")
        sys.exit(1)

    # Get dungeon list from the latest period
    # Each period has the same dungeon list for the season
    period_url = periods[-1]["key"]["href"]
    # Add locale param
    if "?" in period_url:
        period_url += f"&locale={locale}"
    else:
        period_url += f"?locale={locale}"
    period_data = api_get(period_url, token)

    # Collect M+ dungeon IDs
    mk_dungeons = []
    for d in season_data.get("dungeons", []):
        dk_id = d["id"]
        dk_name = d.get("name", "")
        # Fetch dungeon detail to find journal instance link
        dk_url = api_url(region, f"/data/wow/mythic-keystone/dungeon/{dk_id}", "dynamic", locale)
        dk_data = api_get(dk_url, token)
        time.sleep(0.1)

        dungeon_name = dk_data.get("dungeon", {}).get("name", dk_name)
        instance_id = dk_data.get("dungeon", {}).get("id")

        if instance_id:
            mk_dungeons.append({"name": dungeon_name, "journal_instance_id": instance_id})
        else:
            mk_dungeons.append({"name": dungeon_name, "journal_instance_id": None})

    # For dungeons without direct journal instance ID, try name-based lookup
    missing = [d for d in mk_dungeons if d["journal_instance_id"] is None]
    if missing:
        # Check overrides first
        still_missing = []
        for d in missing:
            norm = normalize_name(d["name"])
            if norm in DUNGEON_NAME_OVERRIDES:
                d["journal_instance_id"] = DUNGEON_NAME_OVERRIDES[norm]
            else:
                still_missing.append(d)

        if still_missing:
            # Fetch full journal instance index for name lookup
            ji_url = api_url(region, "/data/wow/journal-instance/index", "static", locale)
            ji_data = api_get(ji_url, token)
            ji_instances = ji_data.get("instances", [])

            # Build normalized name → id map
            ji_map = {}
            for inst in ji_instances:
                ji_map[normalize_name(inst["name"])] = inst["id"]

            for d in still_missing:
                norm = normalize_name(d["name"])
                if norm in ji_map:
                    d["journal_instance_id"] = ji_map[norm]
                else:
                    print(f"  WARNING: Could not find journal instance for dungeon '{d['name']}'")

    return [d for d in mk_dungeons if d["journal_instance_id"] is not None]
```

- [ ] **Step 3: Wire into main()**

Add to `main()` after the auth block:

```python
    # Detect season
    print("Detecting current M+ season...", end=" ", flush=True)
    season_id, season_name = detect_season(token, region, locale, args.season_id)
    print(f"{season_name} (id={season_id})")

    # Discover dungeons
    print("Discovering dungeons...", end=" ", flush=True)
    dungeons = discover_dungeons(token, region, locale, season_id)
    print(f"Found {len(dungeons)} dungeons")
    for d in dungeons:
        print(f"  - {d['name']} (journal id={d['journal_instance_id']})")
```

- [ ] **Step 4: Manual test**

```bash
python tools/fetch_blizzard_loot.py
```

Expected output (dungeon names and IDs will vary):
```
Authenticating... OK
Detecting current M+ season... Midnight Season 1 (id=14)
Discovering dungeons... Found 8 dungeons
  - Magister's Terrace (journal id=XXX)
  - Maisara Caverns (journal id=XXX)
  ...
```

- [ ] **Step 5: Commit**

```bash
git add tools/fetch_blizzard_loot.py
git commit -m "feat(tools): add season detection and dungeon discovery from Blizzard API"
```

---

### Task 4: Item collection from Journal API

**Files:**
- Modify: `tools/fetch_blizzard_loot.py`

- [ ] **Step 1: Add journal traversal function**

Add after `discover_dungeons()`:

```python
def collect_items_from_journal(token, region, locale, dungeons):
    """Traverse journal instances and encounters to collect all item IDs.
    Returns list of dicts: {itemID, dungeon, boss}
    Items appearing under multiple bosses get all bosses collected.
    """
    # item_id -> {itemID, dungeon, bosses: [list]}
    item_map = {}
    total_encounters = 0

    for i, dg in enumerate(dungeons):
        inst_id = dg["journal_instance_id"]
        dg_name = dg["name"]

        # Fetch journal instance
        url = api_url(region, f"/data/wow/journal-instance/{inst_id}", "static", locale)
        inst_data = api_get(url, token)
        time.sleep(0.1)

        encounters = inst_data.get("encounters", [])

        for enc_ref in encounters:
            enc_id = enc_ref["id"]
            enc_url = api_url(region, f"/data/wow/journal-encounter/{enc_id}", "static", locale)
            enc_data = api_get(enc_url, token)
            time.sleep(0.1)

            enc_name = enc_data.get("name", "Unknown")
            total_encounters += 1

            items = enc_data.get("items", [])
            for item_entry in items:
                item_obj = item_entry.get("item", {})
                item_id = item_obj.get("id")
                if not item_id:
                    continue

                if item_id in item_map:
                    # Add boss if not already listed
                    entry = item_map[item_id]
                    if enc_name not in entry["bosses"]:
                        entry["bosses"].append(enc_name)
                    # If different dungeon, note that too
                    if dg_name not in entry["dungeons"]:
                        entry["dungeons"].append(dg_name)
                else:
                    item_map[item_id] = {
                        "itemID": item_id,
                        "dungeons": [dg_name],
                        "bosses": [enc_name],
                    }

        print(f"  [{i+1}/{len(dungeons)}] {dg_name}: {len(encounters)} encounters")

    # Flatten bosses/dungeons to joined strings
    result = []
    for entry in item_map.values():
        result.append({
            "itemID": entry["itemID"],
            "dungeon": " / ".join(entry["dungeons"]),
            "boss": " / ".join(entry["bosses"]),
        })

    print(f"  Total: {total_encounters} encounters, {len(result)} unique items")
    return result
```

- [ ] **Step 2: Wire into main()**

Add after dungeon discovery:

```python
    # Collect items from journal
    print("Fetching journal data...")
    raw_items = collect_items_from_journal(token, region, locale, dungeons)
```

- [ ] **Step 3: Manual test**

```bash
python tools/fetch_blizzard_loot.py
```

Expected: dungeon-by-dungeon progress and item count summary.

- [ ] **Step 4: Commit**

```bash
git add tools/fetch_blizzard_loot.py
git commit -m "feat(tools): collect items from journal encounters"
```

---

### Task 5: Item enrichment from Item API

**Files:**
- Modify: `tools/fetch_blizzard_loot.py`

- [ ] **Step 1: Add inventory type and stat mapping constants**

Add after the imports:

```python
# Blizzard API inventory_type.type -> display slot name
INVENTORY_TYPE_MAP = {
    "HEAD": "Head",
    "NECK": "Neck",
    "SHOULDER": "Shoulder",
    "BODY": "Shirt",
    "CHEST": "Chest",
    "ROBE": "Chest",
    "WAIST": "Waist",
    "LEGS": "Legs",
    "FEET": "Feet",
    "WRIST": "Wrist",
    "HAND": "Hands",
    "HANDS": "Hands",
    "FINGER": "Finger",
    "TRINKET": "Trinket",
    "CLOAK": "Back",
    "SHIELD": "Off Hand",
    "HOLDABLE": "Off Hand",
    "HELD_IN_OFF_HAND": "Off Hand",
    "MAIN_HAND": "Main Hand",
    "ONE_HAND": "One-Hand",
    "TWO_HAND": "Two-Hand",
    "TWOHWEAPON": "Two-Hand",
    "RANGED": "Ranged",
    "RANGEDRIGHT": "Ranged",
}

# Blizzard API stat type.type -> short display name
STAT_TYPE_MAP = {
    "CRIT_RATING": "Crit",
    "HASTE_RATING": "Haste",
    "MASTERY_RATING": "Mastery",
    "VERSATILITY": "Vers",
    "INTELLECT": "Intellect",
    "AGILITY": "Agility",
    "STRENGTH": "Strength",
    "STAMINA": "Stamina",
}

# Blizzard API item_subclass names -> armor type
ARMOR_SUBCLASS_MAP = {
    "Cloth": "Cloth",
    "Leather": "Leather",
    "Mail": "Mail",
    "Plate": "Plate",
}

# Quality ID -> name
QUALITY_MAP = {
    0: "Poor",
    1: "Common",
    2: "Uncommon",
    3: "Rare",
    4: "Epic",
    5: "Legendary",
}

SECONDARY_STATS = {"CRIT_RATING", "HASTE_RATING", "MASTERY_RATING", "VERSATILITY"}
```

- [ ] **Step 2: Add item enrichment function**

```python
def enrich_items(token, region, locale, raw_items):
    """Fetch full item details from Item API for each item.
    Returns list of enriched item dicts.
    """
    enriched = []

    for i, raw in enumerate(raw_items):
        item_id = raw["itemID"]
        url = api_url(region, f"/data/wow/item/{item_id}", "static", locale)

        try:
            data = api_get(url, token)
        except Exception as e:
            print(f"  WARNING: Failed to fetch item {item_id}: {e}")
            enriched.append({
                "itemID": item_id,
                "name": f"Unknown (ID: {item_id})",
                "quality": "Unknown",
                "ilvl": 0,
                "slot": None,
                "armorType": None,
                "weaponType": None,
                "stats": None,
                "statsValues": None,
                "dungeon": raw["dungeon"],
                "boss": raw["boss"],
            })
            time.sleep(0.1)
            continue

        # Name
        name = data.get("name", {})
        if isinstance(name, dict):
            name = name.get(locale, name.get("en_US", str(name)))
        name = str(name)

        # Quality
        quality_info = data.get("quality", {})
        quality = quality_info.get("name", QUALITY_MAP.get(quality_info.get("type"), "Unknown"))
        if isinstance(quality, dict):
            quality = quality.get(locale, quality.get("en_US", "Unknown"))

        # Item level
        ilvl = data.get("level", 0)

        # Slot
        inv_type = data.get("inventory_type", {})
        inv_type_key = inv_type.get("type", "")
        slot = INVENTORY_TYPE_MAP.get(inv_type_key)

        # Armor type / weapon type
        item_class = data.get("item_class", {}).get("name", "")
        if isinstance(item_class, dict):
            item_class = item_class.get(locale, item_class.get("en_US", ""))
        item_subclass = data.get("item_subclass", {}).get("name", "")
        if isinstance(item_subclass, dict):
            item_subclass = item_subclass.get(locale, item_subclass.get("en_US", ""))

        armor_type = None
        weapon_type = None
        if item_class == "Armor" and item_subclass in ARMOR_SUBCLASS_MAP:
            armor_type = ARMOR_SUBCLASS_MAP[item_subclass]
        elif item_class == "Weapon":
            weapon_type = item_subclass

        # Stats from preview_item
        preview = data.get("preview_item", {})
        stats_list = preview.get("stats", [])

        secondary_stats = {}
        for stat in stats_list:
            stat_type = stat.get("type", {}).get("type", "")
            if stat_type in SECONDARY_STATS:
                display_name = STAT_TYPE_MAP.get(stat_type, stat_type)
                secondary_stats[display_name] = stat.get("value", 0)

        stats_str = " / ".join(sorted(secondary_stats.keys())) if secondary_stats else None
        stats_values = secondary_stats if secondary_stats else None

        enriched.append({
            "itemID": item_id,
            "name": name,
            "quality": quality,
            "ilvl": ilvl,
            "slot": slot,
            "armorType": armor_type,
            "weaponType": weapon_type,
            "stats": stats_str,
            "statsValues": stats_values,
            "dungeon": raw["dungeon"],
            "boss": raw["boss"],
        })

        if (i + 1) % 25 == 0 or i + 1 == len(raw_items):
            print(f"  [{i+1}/{len(raw_items)}] items enriched")

        time.sleep(0.1)

    return enriched
```

- [ ] **Step 3: Wire into main()**

Add after journal collection:

```python
    # Enrich items
    print("Fetching item details...")
    items = enrich_items(token, region, locale, raw_items)
    print(f"  {len(items)} items enriched")
```

- [ ] **Step 4: Manual test**

```bash
python tools/fetch_blizzard_loot.py
```

Expected: item-by-item progress counter showing enrichment.

- [ ] **Step 5: Commit**

```bash
git add tools/fetch_blizzard_loot.py
git commit -m "feat(tools): enrich items with details from Blizzard Item API"
```

---

### Task 6: JSON output and season slug

**Files:**
- Modify: `tools/fetch_blizzard_loot.py`

- [ ] **Step 1: Add JSON output function**

Add after `enrich_items()`:

```python
def make_season_slug(season_name):
    """Convert season name to filesystem-safe slug. e.g. 'Midnight Season 1' -> 'midnight_s1'"""
    slug = season_name.lower().strip()
    slug = slug.replace("season ", "s")
    slug = slug.replace(" ", "_")
    # Remove non-alphanumeric chars except underscore
    slug = "".join(c for c in slug if c.isalnum() or c == "_")
    return slug


def save_json(items, season_name, season_id, dungeons, output_dir):
    """Save enriched items to JSON file. Returns the output file path."""
    slug = make_season_slug(season_name)
    dungeon_names = sorted(set(d["name"] for d in dungeons))

    # Sort items by slot, then armor type, then name
    slot_order = ["Head", "Neck", "Shoulder", "Back", "Chest", "Wrist",
                  "Hands", "Waist", "Legs", "Feet", "Finger", "Trinket",
                  "Main Hand", "One-Hand", "Two-Hand", "Off Hand", "Ranged"]

    def sort_key(item):
        slot = item.get("slot") or "zzz"
        slot_idx = slot_order.index(slot) if slot in slot_order else 99
        return (slot_idx, item.get("armorType") or "zzz", item.get("name") or "")

    items.sort(key=sort_key)

    output = {
        "source": "Blizzard Game Data API",
        "season": season_name,
        "season_id": season_id,
        "fetched_at": time.strftime("%Y-%m-%d %H:%M:%S"),
        "total_items": len(items),
        "dungeons": dungeon_names,
        "items": items,
    }

    outfile = os.path.join(output_dir, f"mplus_loot_{slug}.json")
    with open(outfile, "w", encoding="utf-8") as f:
        json.dump(output, f, indent=2, ensure_ascii=False)

    return outfile
```

- [ ] **Step 2: Wire into main() and add Lua generation call**

Add after enrichment:

```python
    # Save JSON
    json_path = save_json(items, season_name, season_id, dungeons, args.output_dir)
    print(f"Saved {json_path} ({len(items)} items)")

    # Generate Lua
    if not args.no_lua:
        print("Generating Lua...", end=" ", flush=True)
        lua_script = os.path.join(SCRIPT_DIR, "generate_loot_lua.py")
        import subprocess
        result = subprocess.run(
            [sys.executable, lua_script, "--input", json_path],
            capture_output=True, text=True,
        )
        if result.returncode == 0:
            print("done")
            if result.stdout.strip():
                print(f"  {result.stdout.strip()}")
        else:
            print("FAILED")
            print(f"  {result.stderr.strip()}")
```

- [ ] **Step 3: Manual test**

```bash
python tools/fetch_blizzard_loot.py --no-lua
```

Expected: JSON file created at `tools/mplus_loot_midnight_s1.json` (or similar slug). Verify the JSON structure has all expected fields.

- [ ] **Step 4: Commit**

```bash
git add tools/fetch_blizzard_loot.py
git commit -m "feat(tools): add JSON output with season slug naming"
```

---

### Task 7: Update generate_loot_lua.py

**Files:**
- Modify: `tools/generate_loot_lua.py`

- [ ] **Step 1: Update to accept --input argument and new JSON format**

Replace the entire file:

```python
"""
Generate addon/data/mplus_loot.lua from a JSON loot file.
Usage: python generate_loot_lua.py [--input path/to/loot.json]
"""

import argparse
import json
import os
import time

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
DEFAULT_LUA_PATH = os.path.join(SCRIPT_DIR, "..", "addon", "data", "mplus_loot.lua")

SLOT_NORMALIZE = {
    "Main Hand": "Weapon",
    "Off Hand": "Weapon",
    "One-Hand": "Weapon",
    "Two-Hand": "Weapon",
    "Ranged": "Weapon",
    "Held In Off-hand": "Weapon",
}


def lua_str(s):
    if s is None:
        return "nil"
    return '"' + s.replace("\\", "\\\\").replace('"', '\\"').replace("'", "\\'") + '"'


def find_latest_json():
    """Find the most recently modified mplus_loot_*.json in the script directory."""
    candidates = []
    for f in os.listdir(SCRIPT_DIR):
        if f.startswith("mplus_loot_") and f.endswith(".json"):
            path = os.path.join(SCRIPT_DIR, f)
            candidates.append((os.path.getmtime(path), path))
    if not candidates:
        return None
    candidates.sort(reverse=True)
    return candidates[0][1]


def main():
    parser = argparse.ArgumentParser(description="Generate mplus_loot.lua from JSON")
    parser.add_argument("--input", type=str, default=None, help="Path to JSON loot file")
    parser.add_argument("--output", type=str, default=DEFAULT_LUA_PATH, help="Output Lua path")
    args = parser.parse_args()

    json_path = args.input or find_latest_json()
    if not json_path or not os.path.exists(json_path):
        print("ERROR: No JSON loot file found. Run fetch_blizzard_loot.py first.")
        return

    with open(json_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    items = data["items"]
    season = data.get("season", "Unknown")
    source = data.get("source", "Unknown")

    lines = []
    lines.append(f"-- Generated by tools/generate_loot_lua.py")
    lines.append(f"-- Source: {source}")
    lines.append(f"-- Generated: {time.strftime('%Y-%m-%d %H:%M:%S')}")
    lines.append(f"-- Items: {len(items)}")
    lines.append("")
    lines.append("BiSHelper_MplusLoot = {")
    lines.append(f'    season = {lua_str(season)},')
    lines.append(f"    items = {{")

    for item in items:
        item_id = item["itemID"]
        name = item.get("name", "Unknown")
        slot_raw = item.get("slot")
        slot = SLOT_NORMALIZE.get(slot_raw, slot_raw)
        ilvl = item.get("ilvl", 0)
        armor_type = item.get("armorType")
        weapon_type = item.get("weaponType")
        stats = item.get("stats")
        dungeon = item.get("dungeon")
        boss = item.get("boss")

        parts = [
            f"itemID={item_id}",
            f"name={lua_str(name)}",
            f"slot={lua_str(slot)}",
            f"ilvl={ilvl}",
            f"armorType={lua_str(armor_type)}",
            f"weaponType={lua_str(weapon_type)}",
            f"stats={lua_str(stats)}",
            f"dungeon={lua_str(dungeon)}",
            f"boss={lua_str(boss)}",
        ]
        lines.append(f"        {{ {', '.join(parts)} }},")

    lines.append("    },")
    lines.append("}")
    lines.append("")

    with open(args.output, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    print(f"Generated {args.output} with {len(items)} items.")


if __name__ == "__main__":
    main()
```

- [ ] **Step 2: Manual test with existing JSON**

If a JSON file was generated in Task 6:

```bash
python tools/generate_loot_lua.py
```

Verify `addon/data/mplus_loot.lua` contains `ilvl=` fields in each entry.

- [ ] **Step 3: Commit**

```bash
git add tools/generate_loot_lua.py
git commit -m "feat(tools): update Lua generator for new Blizzard API JSON format with ilvl"
```

---

### Task 8: End-to-end test and cleanup

**Files:**
- Delete: `tools/scrape_mplus_loot.py`
- Delete: `tools/parse_loot.py`
- Regenerate: `addon/data/mplus_loot.lua`

- [ ] **Step 1: Run full pipeline end-to-end**

```bash
python tools/fetch_blizzard_loot.py
```

Expected:
```
Authenticating... OK
Detecting current M+ season... <season name> (id=<N>)
Discovering dungeons... Found <N> dungeons
  - <dungeon1> (journal id=<N>)
  ...
Fetching journal data...
  [1/<N>] <dungeon1>: <N> encounters
  ...
  Total: <N> encounters, <N> unique items
Fetching item details...
  [25/<N>] items enriched
  ...
  <N> items enriched
Saved tools/mplus_loot_<slug>.json (<N> items)
Generating Lua... done
  Generated addon/data/mplus_loot.lua with <N> items.
```

- [ ] **Step 2: Verify generated files**

Check `tools/mplus_loot_*.json` — valid JSON, all items have `itemID`, `name`, `slot`, `stats`, `dungeon`, `boss` fields.

Check `addon/data/mplus_loot.lua` — valid Lua, each entry has `ilvl=` field, no `FETCH_FAILED` entries.

- [ ] **Step 3: Delete old Wowhead scraper files**

```bash
rm tools/scrape_mplus_loot.py tools/parse_loot.py
```

- [ ] **Step 4: Copy addon to WoW directory for in-game testing**

```bash
cp -r "D:/Workspace/wow_addon/BiS_Helper/addon/." "/d/World of Warcraft/_retail_/Interface/AddOns/BiS_Helper/"
```

In-game: `/reload`, open Loot Browser, verify items display correctly.

- [ ] **Step 5: Commit**

```bash
git add -A
git commit -m "feat(tools): replace Wowhead scraper with Blizzard API loot pipeline

Remove scrape_mplus_loot.py and parse_loot.py.
New pipeline: fetch_blizzard_loot.py -> generate_loot_lua.py -> mplus_loot.lua"
```
