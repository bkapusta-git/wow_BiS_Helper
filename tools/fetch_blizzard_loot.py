"""
Fetch M+ dungeon loot from the Blizzard Game Data API.
Outputs: tools/mplus_loot_{season_slug}.json
Optionally generates: addon/data/mplus_loot.lua (via generate_loot_lua.py)
"""

import argparse
import json
import os
import subprocess
import sys
import time

from blizzard_api import (
    SCRIPT_DIR,
    load_env,
    get_access_token,
    api_get,
    api_url,
    collect_items_from_journal,
    enrich_items,
)


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
