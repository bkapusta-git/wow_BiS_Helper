#!/usr/bin/env python3
"""Sanity-check every addon/data/<class>_<spec>.lua after a bulk BiS refresh.

Fork/scraper reports are not trustworthy on their own — a batch can report
"clean" while a slot silently got the wrong item. This catches the failure modes
the Wowhead scrapers actually produce (see tools/apply_scraped_bis.py):

  - empty item names or sources  -> icon-column / trailing-empty-<td> trap
  - the same itemID in two slots -> a row got copied into the neighbouring slot
  - missing slots                -> an unmapped Wowhead slot label was dropped
  - a literal "|" anywhere       -> starts an escape sequence in WoW's UI markup

Run from the repo root:  python tools/audit_bis_data.py
Exits non-zero if anything is flagged, so it can gate a release.
"""
import glob
import os
import re
import sys

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA = os.path.join(REPO, "addon", "data")

# Slot 4 does not exist in the WoW API; 17 is optional (2H specs have no off-hand).
EXPECTED_SLOTS = [1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
SKIP = {"mplus_loot.lua", "raid_loot.lua", "enchants.lua", "gems.lua"}
MODES = ("raid", "mythicplus")

ENTRY = re.compile(
    r"\[(\d+)\]\s*=\s*\{\s*itemID\s*=\s*(\d+)\s*,"
    r"\s*name\s*=\s*\"([^\"]*)\"\s*,\s*source\s*=\s*\"([^\"]*)\""
)

ENCHANTS_LUA = os.path.join(DATA, "enchants.lua")

CATALOGUE_SLOT = re.compile(r"\[(\d+)\]\s*=\s*\{(.*?)\n        \},", re.S)
CATALOGUE_ENTRY = re.compile(
    r"\{\s*name\s*=\s*\"([^\"]+)\"\s*,\s*stat\s*=\s*\"([^\"]+)\"\s*,"
    r"\s*ranks\s*=\s*\{([^}]*)\}"
)
OVERRIDE_BLOCK = re.compile(r"enchants\s*=\s*\{(.*?)\}", re.S)
OVERRIDE_ENTRY = re.compile(r"\[(\d+)\]\s*=\s*\"([^\"]*)\"")


def load_enchant_catalogue(path=ENCHANTS_LUA):
    """{slot_id: {enchant name, ...}} from the generated catalogue."""
    if not os.path.exists(path):
        return {}
    text = open(path, encoding="utf-8", newline="").read()
    catalogue = {}
    for slot, body in CATALOGUE_SLOT.findall(text):
        names = {name for name, _stat, _ranks in CATALOGUE_ENTRY.findall(body)}
        catalogue[int(slot)] = names
    return catalogue


def audit_catalogue_ranks(path=ENCHANTS_LUA):
    """Every family needs all three ranks: a partial family makes the addon
    call a legitimate max-rank enchant 'low rank'."""
    if not os.path.exists(path):
        return []
    text = open(path, encoding="utf-8", newline="").read()
    issues = []
    for name, _stat, ranks in CATALOGUE_ENTRY.findall(text):
        count = len([r for r in ranks.split(",") if r.strip()])
        if count != 3:
            issues.append(f"enchants.lua: {name} ma {count} rang zamiast 3")
    return issues


def audit_enchant_overrides(text, catalogue):
    """Check a spec file's optional enchants = {...} block against the catalogue.

    An override naming an entry outside the catalogue silently falls back to
    the stat rule in game, so nothing looks broken — only the audit catches it.
    """
    block = OVERRIDE_BLOCK.search(text)
    if not block:
        return []

    issues = []
    for slot, name in OVERRIDE_ENTRY.findall(block.group(1)):
        slot_id = int(slot)
        key = 11 if slot_id == 12 else slot_id
        if key not in catalogue:
            issues.append(
                f"enchants: slot {slot_id} nie wystepuje w katalogu enchants.lua"
            )
        elif name not in catalogue[key]:
            issues.append(
                f"enchants: slot {slot_id} wskazuje na \"{name}\", "
                f"ktorego nie ma w katalogu"
            )
    return issues


def audit_file(path, catalogue):
    """Return a list of human-readable problems with one spec data file."""
    text = open(path, encoding="utf-8").read()
    issues = []

    # Only look inside content = { ... }; statPriority has its own raid/mythicplus keys.
    if "content = {" not in text:
        return ["brak sekcji content"]
    content = text.split("content = {", 1)[1]

    for mode in MODES:
        match = re.search(rf"\n        {mode}\s*=\s*\{{(.*?)\n        \}}", content, re.S)
        if not match:
            issues.append(f"{mode}: brak bloku")
            continue

        entries = ENTRY.findall(match.group(1))
        if not entries:
            issues.append(f"{mode}: blok pusty lub w nieznanym formacie")
            continue

        slots = [int(s) for s, _, _, _ in entries]
        ids = [int(i) for _, i, _, _ in entries]

        blank_name = [s for s, _, name, _ in entries if not name.strip()]
        if blank_name:
            issues.append(f"{mode}: puste nazwy w slotach {blank_name}")

        blank_source = [s for s, _, _, src in entries if not src.strip()]
        if blank_source:
            issues.append(f"{mode}: puste zrodla w slotach {blank_source}")

        by_id = {}
        for slot, item_id in zip(slots, ids):
            by_id.setdefault(item_id, []).append(slot)
        duplicated = {i: s for i, s in by_id.items() if len(s) > 1}
        if duplicated:
            issues.append(f"{mode}: ten sam itemID w kilku slotach {duplicated}")

        if len(set(slots)) != len(slots):
            issues.append(f"{mode}: powtorzony numer slotu")

        missing = [s for s in EXPECTED_SLOTS if s not in slots]
        if missing:
            issues.append(f"{mode}: brak slotow {missing}")

    if "|" in text:
        issues.append("zawiera znak | (escape w UI WoW, psuje renderowanie)")

    issues.extend(audit_enchant_overrides(text, catalogue))

    return issues


def main():
    flagged = 0
    checked = 0

    catalogue = load_enchant_catalogue()
    rank_issues = audit_catalogue_ranks()
    if rank_issues:
        print("\nenchants.lua")
        for issue in rank_issues:
            print(f"   {issue}")
        flagged += 1

    for path in sorted(glob.glob(os.path.join(DATA, "*.lua"))):
        name = os.path.basename(path)
        if name in SKIP:
            continue
        checked += 1
        issues = audit_file(path, catalogue)
        if issues:
            flagged += 1
            print(f"\n{name}")
            for issue in issues:
                print(f"   {issue}")

    print(f"\n=== sprawdzono {checked} plikow, {flagged} z uwagami ===")
    return 1 if flagged else 0


if __name__ == "__main__":
    sys.exit(main())
