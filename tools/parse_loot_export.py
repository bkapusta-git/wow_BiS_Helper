"""
Parse BiS_Helper_LootExport SavedVariables and output a whitelist JSON.

Usage:
  python parse_loot_export.py                           # auto-detect WTF path
  python parse_loot_export.py --input path/to/BiS_Helper_LootExport.lua
  python parse_loot_export.py --wow-dir "D:/World of Warcraft/_retail_"

Output: tools/current_item_whitelist.json
"""

import argparse
import glob
import json
import os
import re
import sys

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
DEFAULT_OUTPUT = os.path.join(SCRIPT_DIR, "current_item_whitelist.json")

# Common WoW install paths to try
WOW_PATHS = [
    "D:/World of Warcraft/_retail_",
    "C:/Program Files (x86)/World of Warcraft/_retail_",
    "C:/Program Files/World of Warcraft/_retail_",
]

SAVED_VAR_FILENAME = "BiS_Helper_LootExport.lua"


def find_savedvariables():
    """Search common WoW paths for the SavedVariables file."""
    for wow_path in WOW_PATHS:
        pattern = os.path.join(wow_path, "WTF", "Account", "*", "SavedVariables", SAVED_VAR_FILENAME)
        matches = glob.glob(pattern)
        if matches:
            # Return most recently modified
            matches.sort(key=os.path.getmtime, reverse=True)
            return matches[0]
    return None


def parse_lua_table(content):
    """Parse BiSHelperLootExportDB from Lua SavedVariables file.

    Extracts itemIDs, names, slots, dungeons, and bosses from the items table.
    Uses regex — not a full Lua parser, but sufficient for SavedVariables format.
    """
    items = []
    dungeons = []
    exported_at = None

    # Extract exportedAt
    m = re.search(r'\["exportedAt"\]\s*=\s*"([^"]+)"', content)
    if m:
        exported_at = m.group(1)

    # Extract dungeon names
    dungeons_match = re.search(r'\["dungeons"\]\s*=\s*\{(.*?)\}', content, re.DOTALL)
    if dungeons_match:
        dungeons = re.findall(r'"([^"]+)"', dungeons_match.group(1))

    # Extract items — each item is a sub-table within ["items"] = { ... }
    items_match = re.search(r'\["items"\]\s*=\s*\{(.+)\}[\s,]*\["itemCount"\]', content, re.DOTALL)
    if not items_match:
        # Try alternative: items block before closing brace
        items_match = re.search(r'\["items"\]\s*=\s*\{(.+?)\n\t?\}', content, re.DOTALL)

    if items_match:
        items_block = items_match.group(1)
        # Each item: { ... },
        item_pattern = re.compile(r'\{([^}]+)\}', re.DOTALL)
        for m in item_pattern.finditer(items_block):
            entry_text = m.group(1)
            item = {}

            # Extract fields
            id_m = re.search(r'\["itemID"\]\s*=\s*(\d+)', entry_text)
            if id_m:
                item["itemID"] = int(id_m.group(1))

            name_m = re.search(r'\["name"\]\s*=\s*"([^"]*)"', entry_text)
            if name_m:
                item["name"] = name_m.group(1)

            slot_m = re.search(r'\["slot"\]\s*=\s*"([^"]*)"', entry_text)
            if slot_m:
                item["slot"] = slot_m.group(1)

            dungeon_m = re.search(r'\["dungeon"\]\s*=\s*"([^"]*)"', entry_text)
            if dungeon_m:
                item["dungeon"] = dungeon_m.group(1)

            boss_m = re.search(r'\["boss"\]\s*=\s*"([^"]*)"', entry_text)
            if boss_m:
                item["boss"] = boss_m.group(1)

            if "itemID" in item:
                items.append(item)

    return {
        "exportedAt": exported_at,
        "dungeons": dungeons,
        "items": items,
    }


def main():
    parser = argparse.ArgumentParser(description="Parse LootExport SavedVariables to whitelist JSON")
    parser.add_argument("--input", type=str, default=None, help="Path to SavedVariables .lua file")
    parser.add_argument("--wow-dir", type=str, default=None, help="WoW _retail_ directory")
    parser.add_argument("--output", type=str, default=DEFAULT_OUTPUT, help="Output whitelist JSON path")
    args = parser.parse_args()

    # Find input file
    sv_path = args.input
    if not sv_path and args.wow_dir:
        pattern = os.path.join(args.wow_dir, "WTF", "Account", "*", "SavedVariables", SAVED_VAR_FILENAME)
        matches = glob.glob(pattern)
        if matches:
            matches.sort(key=os.path.getmtime, reverse=True)
            sv_path = matches[0]
    if not sv_path:
        sv_path = find_savedvariables()

    if not sv_path or not os.path.exists(sv_path):
        print("ERROR: SavedVariables file not found.")
        print("Options:")
        print("  1. Run /bisexport in WoW, then log out")
        print("  2. Use --input path/to/BiS_Helper_LootExport.lua")
        print("  3. Use --wow-dir \"D:/World of Warcraft/_retail_\"")
        sys.exit(1)

    print(f"Reading: {sv_path}")

    with open(sv_path, "r", encoding="utf-8") as f:
        content = f.read()

    data = parse_lua_table(content)

    if not data["items"]:
        print("ERROR: No items found in SavedVariables. Did you run /bisexport in-game?")
        sys.exit(1)

    # Build whitelist
    item_ids = sorted(set(item["itemID"] for item in data["items"]))

    whitelist = {
        "source": "BiS_Helper_LootExport addon (in-game Encounter Journal)",
        "exportedAt": data["exportedAt"],
        "dungeons": data["dungeons"],
        "itemCount": len(item_ids),
        "itemIDs": item_ids,
        "items": data["items"],
    }

    with open(args.output, "w", encoding="utf-8") as f:
        json.dump(whitelist, f, indent=2, ensure_ascii=False)

    print(f"Whitelist saved: {args.output}")
    print(f"  {len(item_ids)} unique item IDs from {len(data['dungeons'])} dungeons")
    print(f"  Exported at: {data['exportedAt']}")
    print(f"\nNext step: python generate_loot_lua.py --whitelist {args.output}")


if __name__ == "__main__":
    main()
