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
    "WEAPON": "One-Hand",
    "WEAPONMAINHAND": "Main Hand",
    "MAIN_HAND": "Main Hand",
    "ONE_HAND": "One-Hand",
    "TWO_HAND": "Two-Hand",
    "TWOHAND": "Two-Hand",
    "TWOHWEAPON": "Two-Hand",
    "TWOHHAND": "Two-Hand",
    "RANGED": "Ranged",
    "RANGEDRIGHT": "Ranged",
}

# item_class IDs for equippable gear (used to filter out quest items, recipes, etc.)
EQUIPPABLE_ITEM_CLASSES = {"Armor", "Weapon"}

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


def detect_season(token, region, locale, override_id=None):
    """Detect current M+ season or use override. Returns (season_id, season_name)."""
    if override_id:
        url = api_url(region, f"/data/wow/mythic-keystone/season/{override_id}", "dynamic", locale)
        data = api_get(url, token)
        raw_name = data.get("season_name", f"Season {override_id}")
        return override_id, raw_name if isinstance(raw_name, str) else raw_name.get("name", f"Season {override_id}")

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
    raw_name = season_data.get("season_name", f"Season {season_id}")
    season_name = raw_name if isinstance(raw_name, str) else raw_name.get("name", f"Season {season_id}")

    return season_id, season_name


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
    """Get dungeon list for current M+ rotation and map to journal instance IDs.
    Uses is_tracked field from dungeon detail to identify active rotation.
    Returns list of dicts: {name, journal_instance_id}
    """
    # Fetch all M+ dungeons from the index
    url = api_url(region, "/data/wow/mythic-keystone/dungeon/index", "dynamic", locale)
    index_data = api_get(url, token)
    all_dungeons = index_data.get("dungeons", [])

    if not all_dungeons:
        print("ERROR: No dungeons found in mythic-keystone index.")
        sys.exit(1)

    # Check each dungeon for is_tracked=true (current rotation)
    mk_dungeons = []
    for d in all_dungeons:
        dk_id = d["id"]
        dk_url = api_url(region, f"/data/wow/mythic-keystone/dungeon/{dk_id}", "dynamic", locale)
        dk_data = api_get(dk_url, token)
        time.sleep(0.1)

        if not dk_data.get("is_tracked"):
            continue

        dungeon_name = dk_data.get("dungeon", {}).get("name", d.get("name", ""))
        instance_id = dk_data.get("dungeon", {}).get("id")

        if instance_id:
            mk_dungeons.append({"name": dungeon_name, "journal_instance_id": instance_id})
        else:
            # Fallback: check hardcoded overrides or name-based lookup
            norm = normalize_name(dungeon_name)
            if norm in DUNGEON_NAME_OVERRIDES:
                mk_dungeons.append({"name": dungeon_name, "journal_instance_id": DUNGEON_NAME_OVERRIDES[norm]})
            else:
                mk_dungeons.append({"name": dungeon_name, "journal_instance_id": None})

    # For dungeons without journal instance ID, try name-based lookup
    missing = [d for d in mk_dungeons if d["journal_instance_id"] is None]
    if missing:
        ji_url = api_url(region, "/data/wow/journal-instance/index", "static", locale)
        ji_data = api_get(ji_url, token)
        ji_instances = ji_data.get("instances", [])

        ji_map = {}
        for inst in ji_instances:
            ji_map[normalize_name(inst["name"])] = inst["id"]

        for d in missing:
            norm = normalize_name(d["name"])
            if norm in ji_map:
                d["journal_instance_id"] = ji_map[norm]
            else:
                print(f"  WARNING: Could not find journal instance for dungeon '{d['name']}'")

    return [d for d in mk_dungeons if d["journal_instance_id"] is not None]


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

        # Filter: skip non-equippable items (quest items, recipes, mounts, etc.)
        item_class_name = data.get("item_class", {}).get("name", "")
        if isinstance(item_class_name, dict):
            item_class_name = item_class_name.get(locale, item_class_name.get("en_US", ""))
        if item_class_name not in EQUIPPABLE_ITEM_CLASSES:
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

        # Armor type / weapon type (item_class_name already extracted above for filtering)
        item_subclass = data.get("item_subclass", {}).get("name", "")
        if isinstance(item_subclass, dict):
            item_subclass = item_subclass.get(locale, item_subclass.get("en_US", ""))

        armor_type = None
        weapon_type = None
        if item_class_name == "Armor" and item_subclass in ARMOR_SUBCLASS_MAP:
            armor_type = ARMOR_SUBCLASS_MAP[item_subclass]
        elif item_class_name == "Weapon":
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


def main():
    parser = argparse.ArgumentParser(description="Fetch M+ loot from Blizzard API")
    parser.add_argument("--season-id", type=int, default=None, help="Override M+ season ID")
    parser.add_argument("--region", type=str, default=None, help="API region (eu/us/kr/tw)")
    parser.add_argument("--locale", type=str, default=None, help="Locale for item names")
    parser.add_argument("--no-lua", action="store_true", help="Skip Lua generation")
    parser.add_argument("--output-dir", type=str, default=SCRIPT_DIR, help="JSON output directory")
    parser.add_argument("--min-ilvl", type=int, default=None, help="Min ilvl for current-season flag (passed to Lua generator)")
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

    # Collect items from journal
    print("Fetching journal data...")
    raw_items = collect_items_from_journal(token, region, locale, dungeons)

    # Enrich items
    print("Fetching item details...")
    items = enrich_items(token, region, locale, raw_items)
    print(f"  {len(items)} items enriched")

    # Save JSON
    json_path = save_json(items, season_name, season_id, dungeons, args.output_dir)
    print(f"Saved {json_path} ({len(items)} items)")

    # Generate Lua
    if not args.no_lua:
        print("Generating Lua...", end=" ", flush=True)
        lua_script = os.path.join(SCRIPT_DIR, "generate_loot_lua.py")
        import subprocess
        cmd = [sys.executable, lua_script, "--input", json_path]
        if args.min_ilvl is not None:
            cmd.extend(["--min-ilvl", str(args.min_ilvl)])
        result = subprocess.run(cmd, capture_output=True, text=True)
        if result.returncode == 0:
            print("done")
            if result.stdout.strip():
                print(f"  {result.stdout.strip()}")
        else:
            print("FAILED")
            print(f"  {result.stderr.strip()}")


if __name__ == "__main__":
    main()
