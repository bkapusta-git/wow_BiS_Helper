"""
Fetch raid loot from the Blizzard Game Data API.
Discovers current-season raids from the "Current Season" journal expansion.
Outputs: tools/raid_loot_{season_slug}.json
Optionally generates: addon/data/raid_loot.lua (via generate_raid_loot_lua.py)
"""

import argparse
import json
import os
import subprocess
import re
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


# Journal expansion holding whatever Blizzard currently flags as the live season.
# Mirrors the "Current Season" section of the in-game Dungeon Journal.
CURRENT_SEASON_EXPANSION_ID = 505


def discover_raids(token, region, locale, expansion_id):
    """Return current-season raids as [{name, journal_instance_id}, ...]."""
    url = api_url(region, f"/data/wow/journal-expansion/{expansion_id}", "static", locale)
    data = api_get(url, token)
    return [
        {"name": r["name"], "journal_instance_id": r["id"]}
        for r in data.get("raids", [])
    ]


def detect_season_label(token, region, locale):
    """Derive a raid season label, e.g. 'Midnight Season 2 Raids'.

    The M+ season endpoint names the live season; its name carries the
    expansion+season in parentheses, e.g. 'Mythic+ Dungeons (Midnight Season 2)'.
    """
    url = api_url(region, "/data/wow/mythic-keystone/season/index", "dynamic", locale)
    seasons = api_get(url, token).get("seasons", [])
    if not seasons:
        return "Current Season Raids"

    season_id = max(seasons, key=lambda s: s["id"])["id"]
    url = api_url(region, f"/data/wow/mythic-keystone/season/{season_id}", "dynamic", locale)
    raw_name = api_get(url, token).get("season_name", "")
    name = raw_name if isinstance(raw_name, str) else raw_name.get("name", "")

    inner = re.search(r"\(([^)]+)\)", name)
    if inner:
        return f"{inner.group(1)} Raids"
    return f"{name} Raids".strip() or "Current Season Raids"


def make_season_slug(season_label):
    """Convert a season label to a filesystem-safe slug.

    e.g. 'Midnight Season 2 Raids' -> 'midnight_s2'
    """
    slug = season_label.lower().strip()
    slug = slug.replace(" raids", "")
    slug = slug.replace("season ", "s")
    slug = slug.replace(" ", "_")
    return "".join(c for c in slug if c.isalnum() or c == "_")


def save_json(items, season_label, output_dir):
    """Save enriched items to JSON file."""
    raid_names = sorted(set(item.get("dungeon", "") for item in items))

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
        "season": season_label,
        "fetched_at": time.strftime("%Y-%m-%d %H:%M:%S"),
        "total_items": len(items),
        "raids": raid_names,
        "items": items,
    }

    outfile = os.path.join(output_dir, f"raid_loot_{make_season_slug(season_label)}.json")
    with open(outfile, "w", encoding="utf-8") as f:
        json.dump(output, f, indent=2, ensure_ascii=False)

    return outfile


def main():
    parser = argparse.ArgumentParser(description="Fetch raid loot from Blizzard API")
    parser.add_argument("--region", type=str, default=None, help="API region (eu/us/kr/tw)")
    parser.add_argument("--locale", type=str, default=None, help="Locale for item names")
    parser.add_argument("--no-lua", action="store_true", help="Skip Lua generation")
    parser.add_argument("--output-dir", type=str, default=SCRIPT_DIR, help="JSON output directory")
    parser.add_argument("--expansion-id", type=int, default=CURRENT_SEASON_EXPANSION_ID,
                        help="Journal expansion ID to pull raids from")
    parser.add_argument("--instance-id", type=int, action="append", default=None,
                        help="Fetch only these journal instance IDs (repeatable)")
    parser.add_argument("--season-label", type=str, default=None,
                        help="Override season label, e.g. 'Midnight Season 2 Raids'")
    args = parser.parse_args()

    env = load_env()
    client_id = env.get("BLIZZARD_CLIENT_ID")
    client_secret = env.get("BLIZZARD_CLIENT_SECRET")
    region = args.region or env.get("BLIZZARD_REGION", "eu")
    locale = args.locale or env.get("BLIZZARD_LOCALE", "en_US")

    if not client_id or not client_secret:
        print("ERROR: BLIZZARD_CLIENT_ID and BLIZZARD_CLIENT_SECRET must be set in tools/.env")
        sys.exit(1)

    print("Authenticating...", end=" ", flush=True)
    token = get_access_token(client_id, client_secret, region)
    print("OK")

    season_label = args.season_label or detect_season_label(token, region, locale)

    print("Discovering raids...", end=" ", flush=True)
    raids = discover_raids(token, region, locale, args.expansion_id)
    if args.instance_id:
        wanted = set(args.instance_id)
        raids = [r for r in raids if r["journal_instance_id"] in wanted]
    if not raids:
        print("none found")
        print(f"ERROR: No raids found in journal expansion {args.expansion_id}.")
        sys.exit(1)
    print(f"Found {len(raids)} raids")
    for r in raids:
        print(f"  - {r['name']} (journal id={r['journal_instance_id']})")

    print(f"Fetching raid loot for {season_label}...")
    print("Fetching journal data...")
    raw_items = collect_items_from_journal(token, region, locale, raids)

    print("Fetching item details...")
    items = enrich_items(token, region, locale, raw_items)
    print(f"  {len(items)} equippable items enriched")

    json_path = save_json(items, season_label, args.output_dir)
    print(f"Saved {json_path} ({len(items)} items)")

    if not args.no_lua:
        print("Generating Lua...", end=" ", flush=True)
        lua_script = os.path.join(SCRIPT_DIR, "generate_raid_loot_lua.py")
        cmd = [sys.executable, lua_script, "--input", json_path]
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
