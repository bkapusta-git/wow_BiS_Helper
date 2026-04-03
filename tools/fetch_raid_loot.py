"""
Fetch raid loot from the Blizzard Game Data API.
Uses hardcoded journal instance IDs for current-season raids.
Outputs: tools/raid_loot_{season_slug}.json
Optionally generates: addon/data/raid_loot.lua (via generate_raid_loot_lua.py)
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


# Hardcoded raid journal instance IDs — Midnight Season 1
# Update these when the season changes.
# To find IDs: GET /data/wow/journal-instance/index and search by name
RAID_INSTANCES = [
    {"name": "The Voidspire", "journal_instance_id": 1307},
    {"name": "The Dreamrift", "journal_instance_id": 1314},
    {"name": "Midnight", "journal_instance_id": 1312},
]

SEASON_SLUG = "midnight_s1"
SEASON_LABEL = "Midnight Season 1 Raids"


def save_json(items, output_dir):
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
        "season": SEASON_LABEL,
        "fetched_at": time.strftime("%Y-%m-%d %H:%M:%S"),
        "total_items": len(items),
        "raids": raid_names,
        "items": items,
    }

    outfile = os.path.join(output_dir, f"raid_loot_{SEASON_SLUG}.json")
    with open(outfile, "w", encoding="utf-8") as f:
        json.dump(output, f, indent=2, ensure_ascii=False)

    return outfile


def main():
    parser = argparse.ArgumentParser(description="Fetch raid loot from Blizzard API")
    parser.add_argument("--region", type=str, default=None, help="API region (eu/us/kr/tw)")
    parser.add_argument("--locale", type=str, default=None, help="Locale for item names")
    parser.add_argument("--no-lua", action="store_true", help="Skip Lua generation")
    parser.add_argument("--output-dir", type=str, default=SCRIPT_DIR, help="JSON output directory")
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

    print(f"Fetching raid loot for {SEASON_LABEL}...")
    print(f"  Raids: {', '.join(r['name'] for r in RAID_INSTANCES)}")

    print("Fetching journal data...")
    raw_items = collect_items_from_journal(token, region, locale, RAID_INSTANCES)

    print("Fetching item details...")
    items = enrich_items(token, region, locale, raw_items)
    print(f"  {len(items)} equippable items enriched")

    json_path = save_json(items, args.output_dir)
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
