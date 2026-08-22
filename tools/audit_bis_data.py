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
SKIP = {"mplus_loot.lua", "raid_loot.lua"}
MODES = ("raid", "mythicplus")

ENTRY = re.compile(
    r"\[(\d+)\]\s*=\s*\{\s*itemID\s*=\s*(\d+)\s*,"
    r"\s*name\s*=\s*\"([^\"]*)\"\s*,\s*source\s*=\s*\"([^\"]*)\""
)


def audit_file(path):
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

    return issues


def main():
    flagged = 0
    checked = 0
    for path in sorted(glob.glob(os.path.join(DATA, "*.lua"))):
        name = os.path.basename(path)
        if name in SKIP:
            continue
        checked += 1
        issues = audit_file(path)
        if issues:
            flagged += 1
            print(f"\n{name}")
            for issue in issues:
                print(f"   {issue}")

    print(f"\n=== sprawdzono {checked} plikow, {flagged} z uwagami ===")
    return 1 if flagged else 0


if __name__ == "__main__":
    sys.exit(main())
