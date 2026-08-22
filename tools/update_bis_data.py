#!/usr/bin/env python3
"""
Update best-in-slot gear data and stat priorities for WoW classes from Wowhead guides or SimC profiles.
Saves updated Lua tables directly into addon/data/.
"""

import argparse
import glob
import json
import os
import re
import sys
import urllib.request
import urllib.parse
import urllib.error
import base64
import time

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.dirname(SCRIPT_DIR)
DATA_DIR = os.path.join(PROJECT_ROOT, "addon", "data")
CACHE_DIR = os.path.join(SCRIPT_DIR, "cache")

# Bump this when Blizzard starts a new season — used in the Lua header comment.
CURRENT_SEASON_LABEL = "Midnight Season 2"

# Default colors for secondary stats
STAT_COLORS = {
    "Critical Strike": {"r": 1.00, "g": 0.35, "b": 0.35},
    "Haste": {"r": 1.00, "g": 0.82, "b": 0.20},
    "Mastery": {"r": 0.30, "g": 0.75, "b": 1.00},
    "Versatility": {"r": 0.65, "g": 0.40, "b": 1.00},
}

# Wowhead slug & role mapping for the 40 specs
SPECS = {
    "DEATHKNIGHT_BLOOD": {
        "class": "DEATHKNIGHT", "spec": "Blood", "label": "Blood Death Knight",
        "filename": "deathknight_blood.lua", "class_slug": "death-knight", "spec_slug": "blood", "role": "tank"
    },
    "DEATHKNIGHT_FROST": {
        "class": "DEATHKNIGHT", "spec": "Frost", "label": "Frost Death Knight",
        "filename": "deathknight_frost.lua", "class_slug": "death-knight", "spec_slug": "frost", "role": "dps"
    },
    "DEATHKNIGHT_UNHOLY": {
        "class": "DEATHKNIGHT", "spec": "Unholy", "label": "Unholy Death Knight",
        "filename": "deathknight_unholy.lua", "class_slug": "death-knight", "spec_slug": "unholy", "role": "dps"
    },
    "DEMONHUNTER_DEVOURER": {
        "class": "DEMONHUNTER", "spec": "Devourer", "label": "Devourer Demon Hunter",
        "filename": "dh_devourer.lua", "class_slug": "demon-hunter", "spec_slug": "devourer", "role": "dps"
    },
    "DEMONHUNTER_HAVOC": {
        "class": "DEMONHUNTER", "spec": "Havoc", "label": "Havoc Demon Hunter",
        "filename": "dh_havoc.lua", "class_slug": "demon-hunter", "spec_slug": "havoc", "role": "dps"
    },
    "DEMONHUNTER_VENGEANCE": {
        "class": "DEMONHUNTER", "spec": "Vengeance", "label": "Vengeance Demon Hunter",
        "filename": "dh_vengeance.lua", "class_slug": "demon-hunter", "spec_slug": "vengeance", "role": "tank"
    },
    "DRUID_BALANCE": {
        "class": "DRUID", "spec": "Balance", "label": "Balance Druid",
        "filename": "druid_balance.lua", "class_slug": "druid", "spec_slug": "balance", "role": "dps"
    },
    "DRUID_FERAL": {
        "class": "DRUID", "spec": "Feral", "label": "Feral Druid",
        "filename": "druid_feral.lua", "class_slug": "druid", "spec_slug": "feral", "role": "dps"
    },
    "DRUID_GUARDIAN": {
        "class": "DRUID", "spec": "Guardian", "label": "Guardian Druid",
        "filename": "druid_guardian.lua", "class_slug": "druid", "spec_slug": "guardian", "role": "tank"
    },
    "DRUID_RESTORATION": {
        "class": "DRUID", "spec": "Restoration", "label": "Restoration Druid",
        "filename": "druid_restoration.lua", "class_slug": "druid", "spec_slug": "restoration", "role": "healer"
    },
    "EVOKER_AUGMENTATION": {
        "class": "EVOKER", "spec": "Augmentation", "label": "Augmentation Evoker",
        "filename": "evoker_augmentation.lua", "class_slug": "evoker", "spec_slug": "augmentation", "role": "dps"
    },
    "EVOKER_DEVASTATION": {
        "class": "EVOKER", "spec": "Devastation", "label": "Devastation Evoker",
        "filename": "evoker_devastation.lua", "class_slug": "evoker", "spec_slug": "devastation", "role": "dps"
    },
    "EVOKER_PRESERVATION": {
        "class": "EVOKER", "spec": "Preservation", "label": "Preservation Evoker",
        "filename": "evoker_preservation.lua", "class_slug": "evoker", "spec_slug": "preservation", "role": "healer"
    },
    "HUNTER_BEASTMASTERY": {
        "class": "HUNTER", "spec": "Beast Mastery", "label": "Beast Mastery Hunter",
        "filename": "hunter_beastmastery.lua", "class_slug": "hunter", "spec_slug": "beast-mastery", "role": "dps"
    },
    "HUNTER_MARKSMANSHIP": {
        "class": "HUNTER", "spec": "Marksmanship", "label": "Marksmanship Hunter",
        "filename": "hunter_marksmanship.lua", "class_slug": "hunter", "spec_slug": "marksmanship", "role": "dps"
    },
    "HUNTER_SURVIVAL": {
        "class": "HUNTER", "spec": "Survival", "label": "Survival Hunter",
        "filename": "hunter_survival.lua", "class_slug": "hunter", "spec_slug": "survival", "role": "dps"
    },
    "MAGE_ARCANE": {
        "class": "MAGE", "spec": "Arcane", "label": "Arcane Mage",
        "filename": "mage_arcane.lua", "class_slug": "mage", "spec_slug": "arcane", "role": "dps"
    },
    "MAGE_FIRE": {
        "class": "MAGE", "spec": "Fire", "label": "Fire Mage",
        "filename": "mage_fire.lua", "class_slug": "mage", "spec_slug": "fire", "role": "dps"
    },
    "MAGE_FROST": {
        "class": "MAGE", "spec": "Frost", "label": "Frost Mage",
        "filename": "mage_frost.lua", "class_slug": "mage", "spec_slug": "frost", "role": "dps"
    },
    "MONK_BREWMASTER": {
        "class": "MONK", "spec": "Brewmaster", "label": "Brewmaster Monk",
        "filename": "monk_brewmaster.lua", "class_slug": "monk", "spec_slug": "brewmaster", "role": "tank"
    },
    "MONK_MISTWEAVER": {
        "class": "MONK", "spec": "Mistweaver", "label": "Mistweaver Monk",
        "filename": "monk_mistweaver.lua", "class_slug": "monk", "spec_slug": "mistweaver", "role": "healer"
    },
    "MONK_WINDWALKER": {
        "class": "MONK", "spec": "Windwalker", "label": "Windwalker Monk",
        "filename": "monk_windwalker.lua", "class_slug": "monk", "spec_slug": "windwalker", "role": "dps"
    },
    "PALADIN_HOLY": {
        "class": "PALADIN", "spec": "Holy", "label": "Holy Paladin",
        "filename": "paladin_holy.lua", "class_slug": "paladin", "spec_slug": "holy", "role": "healer"
    },
    "PALADIN_PROTECTION": {
        "class": "PALADIN", "spec": "Protection", "label": "Protection Paladin",
        "filename": "paladin_protection.lua", "class_slug": "paladin", "spec_slug": "protection", "role": "tank"
    },
    "PALADIN_RETRIBUTION": {
        "class": "PALADIN", "spec": "Retribution", "label": "Retribution Paladin",
        "filename": "paladin_retribution.lua", "class_slug": "paladin", "spec_slug": "retribution", "role": "dps"
    },
    "PRIEST_DISCIPLINE": {
        "class": "PRIEST", "spec": "Discipline", "label": "Discipline Priest",
        "filename": "priest_discipline.lua", "class_slug": "priest", "spec_slug": "discipline", "role": "healer"
    },
    "PRIEST_HOLY": {
        "class": "PRIEST", "spec": "Holy", "label": "Holy Priest",
        "filename": "priest_holy.lua", "class_slug": "priest", "spec_slug": "holy", "role": "healer"
    },
    "PRIEST_SHADOW": {
        "class": "PRIEST", "spec": "Shadow", "label": "Shadow Priest",
        "filename": "priest_shadow.lua", "class_slug": "priest", "spec_slug": "shadow", "role": "dps"
    },
    "ROGUE_ASSASSINATION": {
        "class": "ROGUE", "spec": "Assassination", "label": "Assassination Rogue",
        "filename": "rogue_assassination.lua", "class_slug": "rogue", "spec_slug": "assassination", "role": "dps"
    },
    "ROGUE_OUTLAW": {
        "class": "ROGUE", "spec": "Outlaw", "label": "Outlaw Rogue",
        "filename": "rogue_outlaw.lua", "class_slug": "rogue", "spec_slug": "outlaw", "role": "dps"
    },
    "ROGUE_SUBTLETY": {
        "class": "ROGUE", "spec": "Subtlety", "label": "Subtlety Rogue",
        "filename": "rogue_subtlety.lua", "class_slug": "rogue", "spec_slug": "subtlety", "role": "dps"
    },
    "SHAMAN_ELEMENTAL": {
        "class": "SHAMAN", "spec": "Elemental", "label": "Elemental Shaman",
        "filename": "shaman_elemental.lua", "class_slug": "shaman", "spec_slug": "elemental", "role": "dps"
    },
    "SHAMAN_ENHANCEMENT": {
        "class": "SHAMAN", "spec": "Enhancement", "label": "Enhancement Shaman",
        "filename": "shaman_enhancement.lua", "class_slug": "shaman", "spec_slug": "enhancement", "role": "dps"
    },
    "SHAMAN_RESTORATION": {
        "class": "SHAMAN", "spec": "Restoration", "label": "Restoration Shaman",
        "filename": "shaman_restoration.lua", "class_slug": "shaman", "spec_slug": "restoration", "role": "healer"
    },
    "WARLOCK_AFFLICTION": {
        "class": "WARLOCK", "spec": "Affliction", "label": "Affliction Warlock",
        "filename": "warlock_affliction.lua", "class_slug": "warlock", "spec_slug": "affliction", "role": "dps"
    },
    "WARLOCK_DEMONOLOGY": {
        "class": "WARLOCK", "spec": "Demonology", "label": "Demonology Warlock",
        "filename": "warlock_demonology.lua", "class_slug": "warlock", "spec_slug": "demonology", "role": "dps"
    },
    "WARLOCK_DESTRUCTION": {
        "class": "WARLOCK", "spec": "Destruction", "label": "Destruction Warlock",
        "filename": "warlock_destruction.lua", "class_slug": "warlock", "spec_slug": "destruction", "role": "dps"
    },
    "WARRIOR_ARMS": {
        "class": "WARRIOR", "spec": "Arms", "label": "Arms Warrior",
        "filename": "warrior_arms.lua", "class_slug": "warrior", "spec_slug": "arms", "role": "dps"
    },
    "WARRIOR_FURY": {
        "class": "WARRIOR", "spec": "Fury", "label": "Fury Warrior",
        "filename": "warrior_fury.lua", "class_slug": "warrior", "spec_slug": "fury", "role": "dps"
    },
    "WARRIOR_PROTECTION": {
        "class": "WARRIOR", "spec": "Protection", "label": "Protection Warrior",
        "filename": "warrior_protection.lua", "class_slug": "warrior", "spec_slug": "protection", "role": "tank"
    },
}

SIMC_SLOT_MAP = {
    "head": 1,
    "neck": 2,
    "shoulder": 3,
    "shoulders": 3,
    "chest": 5,
    "waist": 6,
    "legs": 7,
    "feet": 8,
    "wrist": 9,
    "wrists": 9,
    "hands": 10,
    "finger1": 11,
    "finger2": 12,
    "trinket1": 13,
    "trinket2": 14,
    "back": 15,
    "main_hand": 16,
    "off_hand": 17,
}

WOWHEAD_SLOT_MAP = {
    "head": 1,
    "helm": 1,
    "neck": 2,
    "shoulder": 3,
    "shoulders": 3,
    "chest": 5,
    "waist": 6,
    "belt": 6,
    "legs": 7,
    "feet": 8,
    "boots": 8,
    "wrist": 9,
    "wrists": 9,
    "bracer": 9,
    "bracers": 9,
    "hands": 10,
    "gloves": 10,
    "finger": 11,
    "ring": 11,
    "trinket": 13,
    "back": 15,
    "cloak": 15,
    "cape": 15,
    "weapon": 16,
    "main hand": 16,
    "main-hand": 16,
    "mainhand": 16,
    "one-hand": 16,
    "one hand": 16,
    "two-hand": 16,
    "two hand": 16,
    "off hand": 17,
    "off-hand": 17,
    "offhand": 17,
    "shield": 17,
}


def load_blizzard_credentials(tools_dir):
    """Load key=value pairs from tools/.env file."""
    env_path = os.path.join(tools_dir, ".env")
    if not os.path.exists(env_path):
        return None
    env = {}
    with open(env_path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            if "=" in line:
                key, val = line.split("=", 1)
                env[key.strip()] = val.strip()
    return env


def get_blizzard_token(tools_dir):
    """Obtain OAuth2 bearer token via client credentials flow."""
    env = load_blizzard_credentials(tools_dir)
    if not env:
        return None
        
    client_id = env.get("BLIZZARD_CLIENT_ID")
    client_secret = env.get("BLIZZARD_CLIENT_SECRET")
    region = env.get("BLIZZARD_REGION", "eu")
    locale = env.get("BLIZZARD_LOCALE", "en_US")
    
    if not client_id or not client_secret:
        return None
        
    token_url = f"https://{region}.battle.net/oauth/token"
    data = urllib.parse.urlencode({"grant_type": "client_credentials"}).encode("utf-8")
    credentials = base64.b64encode(f"{client_id}:{client_secret}".encode()).decode()
    
    req = urllib.request.Request(token_url, data=data, headers={
        "Authorization": f"Basic {credentials}",
        "Content-Type": "application/x-www-form-urlencoded",
    })
    
    try:
        with urllib.request.urlopen(req, timeout=10) as resp:
            body = json.loads(resp.read().decode("utf-8"))
            return body["access_token"], region, locale
    except Exception as e:
        print(f"Warning: Failed to authenticate with Blizzard API: {e}")
        return None


def fetch_item_from_api(item_id, token, region="eu", locale="en_US"):
    """Fetch item name and details from Blizzard API."""
    url = f"https://{region}.api.blizzard.com/data/wow/item/{item_id}?namespace=static-{region}&locale={locale}"
    req = urllib.request.Request(url, headers={
        "Authorization": f"Bearer {token}",
        "Accept": "application/json",
    })
    try:
        with urllib.request.urlopen(req, timeout=10) as resp:
            data = json.loads(resp.read().decode("utf-8"))
            name = data.get("name", {})
            if isinstance(name, dict):
                name = name.get(locale, name.get("en_US", f"Item {item_id}"))
            return str(name)
    except Exception as e:
        print(f"  Warning: Failed to fetch item {item_id}: {e}")
        return None


def load_item_db():
    """Load items from all *loot*.json files in tools directory."""
    db = {}
    for path in glob.glob(os.path.join(SCRIPT_DIR, "*loot*.json")):
        try:
            with open(path, "r", encoding="utf-8") as f:
                data = json.load(f)
                for item in data.get("items", []):
                    item_id = int(item["itemID"])
                    db[item_id] = {
                        "name": item["name"],
                        "slot": item["slot"],
                        "dungeon": item.get("dungeon"),
                        "boss": item.get("boss"),
                        "sourceType": item.get("sourceType", "mplus" if "mplus" in path else "raid"),
                    }
        except Exception as e:
            print(f"Warning: Failed to load database file {path}: {e}")
    return db


def get_item_source(item_id, item_db, parsed_source=""):
    """Format the source string based on database lookup and parsed source."""
    if item_id in item_db:
        entry = item_db[item_id]
        if entry.get("sourceType") == "mplus":
            return entry.get("dungeon", "Mythic+")
        else:
            boss = entry.get("boss")
            dungeon = entry.get("dungeon")
            if boss and dungeon:
                return f"{boss} · {dungeon}"
            return dungeon or "Raid"
    
    # Custom fallbacks
    if parsed_source:
        ps_lower = parsed_source.lower()
        if "tier" in ps_lower:
            return "Tier Set"
        if "craft" in ps_lower or "profession" in ps_lower:
            return "Crafted"
        return parsed_source
        
    return "Unknown Source"


def parse_wh_stats(content):
    """Parse stat priorities from Wowhead guide content."""
    content_clean = content.replace(r"\/", "/").replace(r'\"', '"').replace(r"\'", "'")
    lists = re.findall(r"\[ol\](.*?)\[/ol\]", content_clean, re.DOTALL | re.IGNORECASE)
    
    best_list = None
    for lst in lists:
        lst_clean = re.sub(r"\[.*?\]", "", lst).lower()
        match_count = sum(1 for stat in ["haste", "mastery", "crit", "vers"] if stat in lst_clean)
        if match_count >= 2:
            best_list = lst
            break
            
    if not best_list:
        return None

    items = re.findall(r"\[li\](.*?)\[/li\]", best_list, re.DOTALL | re.IGNORECASE)
    stats_chain = []
    
    for item in items:
        item_clean = re.sub(r"\[.*?\]", "", item).strip()
        found = []
        for word in ["Haste", "Mastery", "Critical Strike", "Crit", "Versatility", "Vers"]:
            if re.search(r"\b" + re.escape(word) + r"\b", item_clean, re.IGNORECASE):
                name = "Critical Strike" if word.lower() in ["crit", "critical strike"] else (
                       "Versatility" if word.lower() in ["vers", "versatility"] else word.capitalize())
                if name not in found:
                    found.append(name)
        if found:
            stats_chain.append(found)

    stats_list = []
    for i, group in enumerate(stats_chain):
        is_last_group = (i == len(stats_chain) - 1)
        for j, stat in enumerate(group):
            is_last_in_group = (j == len(group) - 1)
            if is_last_group and is_last_in_group:
                op = None
            elif not is_last_in_group:
                op = "="
            else:
                op = ">"
            stats_list.append((stat, op))
            
    return stats_list


def parse_wh_bis_table(content, item_db, token_info=None):
    """Parse item tables from Wowhead BBCode content."""
    content_clean = content.replace(r"\/", "/").replace(r'\"', '"').replace(r"\'", "'")
    tables = re.findall(r"\[table.*?\]((?:(?!\[table).)*?)\[/table\]", content_clean, re.DOTALL | re.IGNORECASE)
    
    bis_list = []
    
    for table in tables:
        rows = re.findall(r"\[tr\](.*?)\[/tr\]", table, re.DOTALL)
        if not rows:
            continue
        
        first_row_cols = re.findall(r"\[td.*?\](.*?)\[/td\]", rows[0], re.DOTALL)
        first_row_clean = [re.sub(r"\[.*?\]", "", c).strip().lower() for c in first_row_cols]
        
        slot_idx = -1
        item_idx = -1
        source_idx = -1
        
        for idx, col in enumerate(first_row_clean):
            if "slot" in col:
                slot_idx = idx
            elif "item" in col or "name" in col:
                item_idx = idx
            elif "source" in col:
                source_idx = idx
                
        if slot_idx == -1 or item_idx == -1:
            continue
        
        ring_count = 0
        trinket_count = 0
        
        for row in rows[1:]:
            cols = re.findall(r"\[td.*?\](.*?)\[/td\]", row, re.DOTALL)
            if len(cols) <= max(slot_idx, item_idx):
                continue
                
            slot_name = re.sub(r"\[.*?\]", "", cols[slot_idx]).strip().lower()
            item_cell = cols[item_idx]
            source_text = re.sub(r"\[.*?\]", "", cols[source_idx]).strip() if (source_idx != -1 and len(cols) > source_idx) else ""
            
            item_ids = re.findall(r"\[(?:item|icon-badge)=(\d+)", item_cell)
            if not item_ids:
                continue
                
            item_id = int(item_ids[0])
            
            slot_id = None
            for key, val in WOWHEAD_SLOT_MAP.items():
                if key in slot_name:
                    slot_id = val
                    break
                    
            if slot_id is None:
                continue
                
            if slot_id == 11:
                ring_count += 1
                slot_id = 11 if ring_count == 1 else 12
            elif slot_id == 13:
                trinket_count += 1
                slot_id = 13 if trinket_count == 1 else 14
                
            item_name = ""
            if item_id in item_db:
                item_name = item_db[item_id]["name"]
            elif token_info:
                token, region, locale = token_info
                print(f"  Fetching name for item {item_id} from Blizzard API...", end=" ", flush=True)
                fetched_name = fetch_item_from_api(item_id, token, region, locale)
                if fetched_name:
                    item_name = fetched_name
                    print(f"OK ({item_name})")
                else:
                    print("Failed")
                    
            if not item_name:
                item_name = re.sub(r"\[.*?\]", "", item_cell).strip()
                
            if not item_name:
                item_name = f"Item {item_id}"
                
            source = get_item_source(item_id, item_db, source_text)
            bis_list.append((slot_id, item_id, item_name, source))
            
    return bis_list


def parse_simc(simc_str, item_db, token_info=None):
    """Parse SimulationCraft profile string into slot lists."""
    bis_list = []
    
    for line in simc_str.split("\n"):
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        
        parts = line.split(",")
        slot_part = parts[0].split("=")
        if len(slot_part) != 2:
            continue
            
        slot_name = slot_part[0].strip().lower()
        if slot_name not in SIMC_SLOT_MAP:
            continue
            
        slot_id = SIMC_SLOT_MAP[slot_name]
        
        item_id = None
        for p in parts[1:]:
            if "=" in p:
                k, v = p.split("=", 1)
                k = k.strip().lower()
                if k in ("id", "item_id"):
                    item_id = int(v.strip())
                    break
                    
        if item_id is None:
            continue
            
        item_name = ""
        if item_id in item_db:
            item_name = item_db[item_id]["name"]
        elif token_info:
            token, region, locale = token_info
            print(f"  Fetching name for item {item_id} from Blizzard API...", end=" ", flush=True)
            fetched_name = fetch_item_from_api(item_id, token, region, locale)
            if fetched_name:
                item_name = fetched_name
                print(f"OK ({item_name})")
            else:
                print("Failed")
                
        if not item_name:
            item_name = f"Item {item_id}"
            
        source = get_item_source(item_id, item_db)
        bis_list.append((slot_id, item_id, item_name, source))
        
    return bis_list


def read_existing_lua(filepath):
    """Parse existing Lua file to extract DR settings and other metadata."""
    dr_list = []
    label, class_name, spec_name = "", "", ""
    stat_priority = {
        "raid": {"note": "Priority from guide", "stats": []},
        "mythicplus": {"note": "Priority from guide", "stats": []}
    }
    
    if not os.path.exists(filepath):
        return None
        
    with open(filepath, "r", encoding="utf-8") as f:
        lines = f.readlines()
        
    current_mode = None
    
    for line in lines:
        line_strip = line.strip()
        if not line_strip:
            continue
            
        lbl_m = re.search(r'label\s*=\s*"(.*?)"', line_strip)
        if lbl_m: label = lbl_m.group(1)
        cls_m = re.search(r'class\s*=\s*"(.*?)"', line_strip)
        if cls_m: class_name = cls_m.group(1)
        spc_m = re.search(r'spec\s*=\s*"(.*?)"', line_strip)
        if spc_m: spec_name = spc_m.group(1)
        
        if "raid = {" in line_strip:
            current_mode = "raid"
        elif "mythicplus = {" in line_strip:
            current_mode = "mythicplus"
        elif "dr = {" in line_strip:
            current_mode = "dr"
        elif "content = {" in line_strip:
            current_mode = None
            
        if current_mode in ("raid", "mythicplus"):
            note_m = re.search(r'note\s*=\s*"(.*?)"', line_strip)
            if note_m:
                stat_priority[current_mode]["note"] = note_m.group(1)
                
            stat_m = re.search(r'\{\s*name\s*=\s*"(.*?)"\s*,\s*op\s*=\s*(.*?)\s*,\s*r\s*=\s*([0-9.]+)\s*,\s*g\s*=\s*([0-9.]+)\s*,\s*b\s*=\s*([0-9.]+)\s*\}', line_strip)
            if stat_m:
                op_val = stat_m.group(2).replace('"', '').strip()
                if op_val == "nil":
                    op_val = None
                stat_priority[current_mode]["stats"].append({
                    "name": stat_m.group(1),
                    "op": op_val,
                    "r": float(stat_m.group(3)),
                    "g": float(stat_m.group(4)),
                    "b": float(stat_m.group(5)),
                })
                
        elif current_mode == "dr":
            dr_m = re.search(r'\{\s*name\s*=\s*"(.*?)"\s*,\s*rating\s*=\s*(\d+)\s*,\s*r\s*=\s*([0-9.]+)\s*,\s*g\s*=\s*([0-9.]+)\s*,\s*b\s*=\s*([0-9.]+)\s*\}', line_strip)
            if dr_m:
                dr_list.append({
                    "name": dr_m.group(1),
                    "rating": int(dr_m.group(2)),
                    "r": float(dr_m.group(3)),
                    "g": float(dr_m.group(4)),
                    "b": float(dr_m.group(5)),
                })
                
    return {
        "label": label,
        "class": class_name,
        "spec": spec_name,
        "dr": dr_list,
        "statPriority": stat_priority
    }


def write_lua_file(filepath, spec_key, spec_meta, raid_bis, mplus_bis, stat_priority, dr_caps, source_urls):
    """Write updated data to Lua file."""
    lines = []
    lines.append(f"-- BiS data: {spec_meta['label']} — {CURRENT_SEASON_LABEL}")
    for url in source_urls:
        lines.append(f"-- Source: {url}")
    lines.append(f"-- Last updated: {time_date_now()}")
    lines.append("")
    lines.append("BiSHelper_Data = BiSHelper_Data or {}")
    lines.append("")
    lines.append(f'BiSHelper_Data["{spec_key}"] = {{')
    lines.append(f'    label = "{spec_meta["label"]}",')
    lines.append(f'    class = "{spec_meta["class"]}",')
    lines.append(f'    spec  = "{spec_meta["spec"]}",')
    lines.append("")
    
    lines.append("    statPriority = {")
    for mode in ("raid", "mythicplus"):
        mode_data = stat_priority.get(mode, {"note": "Priority from guide", "stats": []})
        lines.append(f'        {mode} = {{')
        lines.append(f'            note  = "{mode_data["note"]}",')
        lines.append("            stats = {")
        for stat in mode_data["stats"]:
            op_str = f'"{stat["op"]}"' if stat.get("op") else "nil"
            lines.append(f'                {{ name = "{stat["name"]}", op = {op_str.ljust(5)}, r = {stat["r"]:.2f}, g = {stat["g"]:.2f}, b = {stat["b"]:.2f} }},')
        lines.append("            },")
        lines.append("        },")
        
    lines.append("        dr = {")
    for dr in dr_caps:
        lines.append(f'            {{ name = "{dr["name"]}", rating = {dr["rating"]}, r = {dr["r"]:.2f}, g = {dr["g"]:.2f}, b = {dr["b"]:.2f} }},')
    lines.append("        },")
    lines.append("    },")
    lines.append("")
    
    lines.append("    content = {")
    lines.append("        -- ── Raid BiS ────────────────────────────────────────")
    lines.append("        raid = {")
    
    seen_raid = set()
    raid_bis_filtered = []
    for s_id, i_id, nm, src in raid_bis:
        if s_id not in seen_raid:
            seen_raid.add(s_id)
            raid_bis_filtered.append((s_id, i_id, nm, src))
            
    raid_bis_sorted = sorted(raid_bis_filtered, key=lambda x: x[0])
    for slot_id, item_id, name, source in raid_bis_sorted:
        comment = f"-- {get_slot_comment(slot_id)}"
        lines.append(f'            [{slot_id}]'.ljust(9) + f'= {{ itemID = {item_id}, name = "{name}",'.ljust(64) + f'source = "{source}"'.ljust(45) + f'}}, {comment}')
    lines.append("        },")
    lines.append("")
    
    lines.append("        -- ── Mythic+ BiS ──────────────────────────────────────")
    lines.append("        mythicplus = {")
    
    seen_mplus = set()
    mplus_bis_filtered = []
    for s_id, i_id, nm, src in mplus_bis:
        if s_id not in seen_mplus:
            seen_mplus.add(s_id)
            mplus_bis_filtered.append((s_id, i_id, nm, src))
            
    mplus_bis_sorted = sorted(mplus_bis_filtered, key=lambda x: x[0])
    for slot_id, item_id, name, source in mplus_bis_sorted:
        comment = f"-- {get_slot_comment(slot_id)}"
        lines.append(f'            [{slot_id}]'.ljust(9) + f'= {{ itemID = {item_id}, name = "{name}",'.ljust(64) + f'source = "{source}"'.ljust(45) + f'}}, {comment}')
    lines.append("        },")
    
    lines.append("    },")
    lines.append("}")
    
    with open(filepath, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")


def time_date_now():
    import time
    return time.strftime("%Y-%m-%d")


def get_slot_comment(slot_id):
    comments = {
        1: "Head", 2: "Neck", 3: "Shoulder", 5: "Chest", 6: "Waist",
        7: "Legs", 8: "Feet", 9: "Wrist", 10: "Hands", 11: "Ring 1",
        12: "Ring 2", 13: "Trinket 1", 14: "Trinket 2", 15: "Back",
        16: "Main Hand", 17: "Off Hand"
    }
    return comments.get(slot_id, "Unknown Slot")


def format_stats(parsed_stats):
    """Format parsed stats list with default colors and operators."""
    formatted = []
    for name, op in parsed_stats:
        color = STAT_COLORS.get(name, {"r": 0.5, "g": 0.5, "b": 0.5})
        formatted.append({
            "name": name,
            "op": op,
            "r": color["r"],
            "g": color["g"],
            "b": color["b"],
        })
    return formatted


def fetch_wowhead_live(url):
    """Fetch live Wowhead guide page using custom headers to avoid bot block."""
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
        "Accept-Language": "en-US,en;q=0.5",
    }
    req = urllib.request.Request(url, headers=headers)
    try:
        with urllib.request.urlopen(req, timeout=15) as resp:
            return resp.read().decode("utf-8")
    except Exception as e:
        print(f"  Warning: Live fetch failed for {url}: {e}")
        return None


def main():
    parser = argparse.ArgumentParser(description="Update class Best-in-Slot lists and stat priorities")
    parser.add_argument("--spec", type=str, help="Addon Spec Key (e.g. DRUID_BALANCE) or 'all' to run on all mapping specs")
    parser.add_argument("--simc", type=str, help="SimulationCraft profile string to import from")
    parser.add_argument("--file", type=str, help="File path to import SimC or Wowhead BBCode text from")
    parser.add_argument("--cache-dir", type=str, default=CACHE_DIR, help="Directory to search for cached Wowhead pages")
    parser.add_argument("--no-write", action="store_true", help="Don't write files, just print updates")
    parser.add_argument("--live", action="store_true", help="Attempt to fetch guide pages live from Wowhead")
    args = parser.parse_args()

    item_db = load_item_db()
    print(f"Loaded {len(item_db)} items from loot database.")

    token_info = get_blizzard_token(SCRIPT_DIR)
    if token_info:
        print("Authenticated with Blizzard API for item name enrichment.")
    else:
        print("Warning: Blizzard API credentials not found or invalid in tools/.env. Missing item names will fallback to local db or placeholders.")

    if not args.spec:
        print("ERROR: --spec <spec_key> or --spec all is required.")
        parser.print_help()
        sys.exit(1)

    spec_keys = []
    if args.spec.upper() == "ALL":
        spec_keys = sorted(SPECS.keys())
    else:
        if args.spec.upper() not in SPECS:
            print(f"ERROR: Invalid spec key '{args.spec}'. Valid keys: {sorted(list(SPECS.keys()))}")
            sys.exit(1)
        spec_keys = [args.spec.upper()]

    if not os.path.exists(args.cache_dir):
        os.makedirs(args.cache_dir)

    for spec_key in spec_keys:
        meta = SPECS[spec_key]
        print(f"\nProcessing {meta['label']}...")
        
        lua_path = os.path.join(DATA_DIR, meta["filename"])
        existing = read_existing_lua(lua_path)
        
        if existing is None:
            existing = {
                "label": meta["label"],
                "class": meta["class"],
                "spec": meta["spec"],
                "dr": [
                    {"name": "Haste", "rating": 1320, "r": 1.0, "g": 0.82, "b": 0.2},
                    {"name": "Crit / Mastery", "rating": 1380, "r": 1.0, "g": 0.6, "b": 0.3},
                    {"name": "Versatility", "rating": 1620, "r": 0.65, "g": 0.4, "b": 1.0},
                ],
                "statPriority": {
                    "raid": {"note": "Priority from guide", "stats": []},
                    "mythicplus": {"note": "Priority from guide", "stats": []}
                }
            }

        raid_items = []
        mplus_items = []
        
        source_urls = [
            f"https://www.wowhead.com/guide/classes/{meta['class_slug']}/{meta['spec_slug']}/bis-gear",
            f"https://www.wowhead.com/guide/classes/{meta['class_slug']}/{meta['spec_slug']}/stat-priority-pve-{meta['role']}"
        ]

        stat_priority = existing["statPriority"]
        dr_caps = existing["dr"]

        if args.simc:
            print("Importing items from SimulationCraft string...")
            parsed_items = parse_simc(args.simc, item_db, token_info)
            raid_items = parsed_items
            mplus_items = parsed_items
            
        elif args.file:
            if not os.path.exists(args.file):
                print(f"ERROR: File not found: {args.file}")
                continue
                
            with open(args.file, "r", encoding="utf-8") as f:
                file_content = f.read()
                
            if "head=" in file_content.lower() or "neck=" in file_content.lower():
                print(f"Importing SimC profile from file {args.file}...")
                parsed_items = parse_simc(file_content, item_db, token_info)
                raid_items = parsed_items
                mplus_items = parsed_items
            else:
                print(f"Parsing Wowhead guide content from file {args.file}...")
                raid_items = parse_wh_bis_table(file_content, item_db, token_info)
                mplus_items = list(raid_items)
                
                parsed_stats = parse_wh_stats(file_content)
                if parsed_stats:
                    formatted_stats = format_stats(parsed_stats)
                    stat_priority["raid"] = {"note": "Parsed from Wowhead guide", "stats": formatted_stats}
                    stat_priority["mythicplus"] = {"note": "Parsed from Wowhead guide", "stats": formatted_stats}
                    print("  Parsed stat priority:", [s["name"] for s in formatted_stats])

        else:
            # Live fetch or cache fetch
            bis_content = ""
            stats_content = ""
            
            if args.live:
                print(f"Fetching live guide: {source_urls[0]}")
                bis_content = fetch_wowhead_live(source_urls[0])
                if bis_content:
                    # Cache it
                    cache_bis_path = os.path.join(args.cache_dir, f"{meta['class_slug']}_{meta['spec_slug']}_bis.txt")
                    with open(cache_bis_path, "w", encoding="utf-8") as f:
                        f.write(bis_content)
                
                print(f"Fetching live stats guide: {source_urls[1]}")
                stats_content = fetch_wowhead_live(source_urls[1])
                if stats_content:
                    cache_stats_path = os.path.join(args.cache_dir, f"{meta['class_slug']}_{meta['spec_slug']}_stats.txt")
                    with open(cache_stats_path, "w", encoding="utf-8") as f:
                        f.write(stats_content)
            
            # Fallback to cache files if live failed or not requested
            if not bis_content:
                pattern_bis = os.path.join(args.cache_dir, f"{meta['class_slug']}_{meta['spec_slug']}_bis.txt")
                if not os.path.exists(pattern_bis):
                    pattern_bis = os.path.join(args.cache_dir, f"{meta['spec_slug']}_bis.txt")
                    
                if os.path.exists(pattern_bis):
                    print(f"Found cached BiS file: {pattern_bis}")
                    with open(pattern_bis, "r", encoding="utf-8") as f:
                        bis_content = f.read()
                else:
                    print(f"No cached file found at {pattern_bis} and live fetch not performed.")
                    continue
                    
            if not stats_content:
                pattern_stats = os.path.join(args.cache_dir, f"{meta['class_slug']}_{meta['spec_slug']}_stats.txt")
                if not os.path.exists(pattern_stats):
                    pattern_stats = os.path.join(args.cache_dir, f"{meta['spec_slug']}_stats.txt")
                    
                if os.path.exists(pattern_stats):
                    print(f"Found cached Stats file: {pattern_stats}")
                    with open(pattern_stats, "r", encoding="utf-8") as f:
                        stats_content = f.read()

            raid_items = parse_wh_bis_table(bis_content, item_db, token_info)
            mplus_items = list(raid_items)
            
            # Check for M+ specific table if any
            pattern_mplus_bis = os.path.join(args.cache_dir, f"{meta['class_slug']}_{meta['spec_slug']}_mplus_bis.txt")
            if not os.path.exists(pattern_mplus_bis):
                pattern_mplus_bis = os.path.join(args.cache_dir, f"{meta['spec_slug']}_mplus_bis.txt")
            if os.path.exists(pattern_mplus_bis):
                print(f"Found cached M+ BiS file: {pattern_mplus_bis}")
                with open(pattern_mplus_bis, "r", encoding="utf-8") as f:
                    mplus_bis_content = f.read()
                mplus_items = parse_wh_bis_table(mplus_bis_content, item_db, token_info)

            if stats_content:
                parsed_stats = parse_wh_stats(stats_content)
                if parsed_stats:
                    formatted_stats = format_stats(parsed_stats)
                    stat_priority["raid"] = {"note": "Parsed from Wowhead stats guide", "stats": formatted_stats}
                    stat_priority["mythicplus"] = {"note": "Parsed from Wowhead stats guide", "stats": formatted_stats}
                    print("  Parsed stat priority:", [s["name"] for s in formatted_stats])

        if not raid_items and not mplus_items:
            print("  Warning: No items found/parsed. Spec file will not be updated.")
            continue

        print(f"  Parsed {len(raid_items)} Raid items and {len(mplus_items)} M+ items.")

        if args.no_write:
            print("  Dry-run: Write skipped. Raid items:")
            for slot, item_id, name, src in raid_items:
                print(f"    [{slot}] {item_id}: {name} ({src})")
        else:
            write_lua_file(lua_path, spec_key, existing, raid_items, mplus_items, stat_priority, dr_caps, source_urls)
            print(f"  Successfully updated {lua_path}")


if __name__ == "__main__":
    main()
