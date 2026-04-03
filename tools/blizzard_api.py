"""
Shared Blizzard Game Data API utilities.
Used by fetch_blizzard_loot.py and fetch_raid_loot.py.
"""

import base64
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


def collect_items_from_journal(token, region, locale, instances):
    """Traverse journal instances and encounters to collect all item IDs.
    Returns list of dicts: {itemID, dungeon, boss}
    Items appearing under multiple bosses get all bosses collected.
    Each entry in instances must have keys: name, journal_instance_id.
    """
    # item_id -> {itemID, dungeon, bosses: [list]}
    item_map = {}
    total_encounters = 0

    for i, inst in enumerate(instances):
        inst_id = inst["journal_instance_id"]
        inst_name = inst["name"]

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
                    # If different instance, note that too
                    if inst_name not in entry["dungeons"]:
                        entry["dungeons"].append(inst_name)
                else:
                    item_map[item_id] = {
                        "itemID": item_id,
                        "dungeons": [inst_name],
                        "bosses": [enc_name],
                    }

        print(f"  [{i+1}/{len(instances)}] {inst_name}: {len(encounters)} encounters")

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
