#!/usr/bin/env python3
"""Generate addon/data/enchants.lua from SpellItemEnchantment.db2.

Blizzard's Game Data API has no enchantment endpoint (every plausible path
404s), so enchant IDs and their crafting ranks come from wago.tools' db2
export. Everything else the catalogue needs is in that same file:

  * slot  - the trade name carries it as a prefix, "Enchant Ring - <name>"
  * stat  - EffectArg_N holds an ItemStatType whenever Effect_N is 5 (stat)

That makes the old hand-written SLOT_MAP unnecessary; it survives only as an
override for the odd family the two rules get wrong. --verify-api cross-checks
the family list against Enchanting formulas in the Game Data API, which is the
second independent source the data needs before anyone trusts it in game.

Usage:  python tools/fetch_enchants.py [--verify-api] [--quality-set N]
"""
import argparse
import csv
import os
import re
import sys

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CACHE = os.path.join(REPO, "tools", "cache", "SpellItemEnchantment.csv")
OUT = os.path.join(REPO, "addon", "data", "enchants.lua")
SEASON = "Midnight Season 2"

# The quality marker gained an expansion number in Midnight: The War Within
# emitted "Quality-Tier1", Midnight emits "Quality-12-Tier1". An absent number
# sorts as 0, so picking the highest set keeps the newest catalogue.
TIER_RE = re.compile(r"^(.*?)\s*\|A:Professions-ChatIcon-Quality(?:-(\d+))?-Tier(\d):")

# Trade names read "Enchant <Slot> - <Name>". Anything else in the table is a
# cosmetic illusion, a tool enchant, or a raw stat line, none of which belong
# on an equipment row.
PREFIX_RE = re.compile(r"^Enchant\s+([A-Za-z]+)\s+-\s+(.+)$")

# Slot ids follow SLOTS in BiS_Helper.lua. Ring 11 also covers ring 12, which
# EnchantSlotKey() folds. Off-hand 17 is NOT folded into Weapon 16: an off-hand
# can be a shield or a holdable, and neither takes a weapon enchant.
SLOT_IDS = {
    "Helm": 1, "Shoulders": 3, "Chest": 5, "Legs": 7, "Boots": 8,
    "Bracers": 9, "Ring": 11, "Cloak": 15, "Back": 15, "Weapon": 16,
}

# Profession tool enchants share the naming scheme but have no equipment slot.
SKIP_SLOTS = {"Tool"}

# ItemStatType -> the stat name used in statPriority[mode].stats[].name.
# Only secondary stats can match a priority list; the rest are carried so the
# tooltip can still name what an enchant gives.
ITEM_STAT = {
    3: "Agility", 4: "Strength", 5: "Intellect", 6: "Spirit", 7: "Stamina",
    32: "Critical Strike", 36: "Haste", 38: "Attack Power", 40: "Versatility",
    45: "Spell Power", 49: "Mastery", 50: "Armor",
    61: "Speed", 62: "Leech", 63: "Avoidance",
    71: "Agility/Strength/Intellect",
}

# Weapon enchants grant a proc rather than a stat, so nothing here matches a
# priority list. The placeholder keeps the row evaluable instead of silent.
NO_STAT = "Special"

# Hand-written corrections for families the two rules above get wrong.
# Empty is the healthy state; every entry here is a rule that failed.
SLOT_MAP = {}

# Fallback ordering. GetRecommendedEnchant() falls back to the first catalogue
# entry when no option matches the spec's stat priority, which is every slot
# but Ring. Naming a sane default here beats alphabetical accident; the real
# per-spec answer belongs in the spec file's enchants = {} override.
PREFERRED_FIRST = {
    5: "Mark of the Worldsoul",           # works for every primary stat
    1: "Empowered Rune of Avoidance",
    3: "Amirdrassil's Grace",
    8: "Farstrider's Hunt",
}


def parse_tier(raw_name):
    """('Enchant Ring - X |A:...-12-Tier2:...') -> ('Enchant Ring - X', 2, 12)

    Returns None when the name carries no quality marker at all.
    """
    match = TIER_RE.match(raw_name)
    if not match:
        return None
    return match.group(1).strip(), int(match.group(3)), int(match.group(2) or 0)


def pick_quality_set(rows):
    """Highest quality-marker set present, i.e. the newest expansion's catalogue."""
    sets = {parsed[2] for parsed in (parse_tier(name) for _id, name in rows) if parsed}
    return max(sets) if sets else None


def group_ranks(rows, quality_set=None):
    """[(id, raw_name)] -> {base_name: [rank1_id, rank2_id, ...]}

    Rank counts are per expansion: The War Within shipped three tiers, Midnight
    ships two. Requiring a fixed count would drop a whole catalogue, so the only
    rule is that ranks run unbroken from tier 1 and that there are at least two
    of them. A gap would make the addon misreport rank position.
    """
    by_name = {}
    for enchant_id, raw_name in rows:
        parsed = parse_tier(raw_name)
        if not parsed:
            continue
        base, tier, marker = parsed
        if quality_set is not None and marker != quality_set:
            continue
        by_name.setdefault(base, {})[tier] = int(enchant_id)

    catalog = {}
    for name, tiers in by_name.items():
        expected = set(range(1, len(tiers) + 1))
        if len(tiers) >= 2 and set(tiers) == expected:
            catalog[name] = [tiers[t] for t in sorted(tiers)]
    return catalog


def split_slot(base_name):
    """'Enchant Ring - Silvermoon's Tenacity' -> ('Ring', "Silvermoon's Tenacity")"""
    match = PREFIX_RE.match(base_name)
    if not match:
        return None
    return match.group(1), match.group(2).strip()


def resolve_slot(name):
    """Slot id and stat for a family, or KeyError when the name is not an
    equipment enchant. Guessing would put an enchant on the wrong row."""
    if name in SLOT_MAP:
        return SLOT_MAP[name]
    parts = split_slot(name)
    if not parts or parts[0] not in SLOT_IDS:
        raise KeyError(name)
    return {"slot": SLOT_IDS[parts[0]]}


def stats_from_row(row):
    """Stat names an enchant grants, read from the db2 effect columns.

    Effect_N == 5 is ITEM_ENCHANTMENT_TYPE_STAT, and then EffectArg_N is an
    ItemStatType. Other effect types are procs and carry no stat.
    """
    def as_int(key):
        try:
            return int(row.get(key) or 0)
        except ValueError:
            return 0

    names = []
    for n in (0, 1, 2):
        if as_int("Effect_%d" % n) == 5:
            stat = ITEM_STAT.get(as_int("EffectArg_%d" % n))
            if stat and stat not in names:
                names.append(stat)
    return names


def primary_stat(names):
    """The stat an enchant should be matched on. Stamina rides along with a
    real stat on several families and never drives a choice, so it loses."""
    for name in names:
        if name != "Stamina":
            return name
    return names[0] if names else NO_STAT


def _reject_markup(value, field):
    """`|` opens an escape sequence in WoW's UI markup and `"` would break the
    Lua string literal. Neither can be escaped away safely, so refuse to emit."""
    if "|" in value or '"' in value:
        raise ValueError(
            "niedozwolony znak w polu %s: %r (| psuje markup UI, \" psuje skladnie Lua)"
            % (field, value)
        )


def sort_key(slot_id):
    """Preferred default first, everything else alphabetical."""
    preferred = PREFERRED_FIRST.get(slot_id)
    return lambda entry: (entry["name"] != preferred, entry["name"])


def render_lua(catalog, season):
    """{slot_id: [{name, stat, ranks}]} -> contents of enchants.lua"""
    lines = [
        "-- Generated by tools/fetch_enchants.py",
        "-- Source: wago.tools SpellItemEnchantment.db2",
        "-- Slot from the trade-name prefix, stat from the db2 effect columns",
        '-- stat = "%s" marks a proc enchant: no secondary stat to match on,' % NO_STAT,
        "-- so the pick falls back to catalogue order or a per-spec override.",
        "",
        "BiSHelper_Enchants = {",
        '    season = "%s",' % season,
        "    slots = {",
    ]
    for slot_id in sorted(catalog):
        lines.append("        [%d] = {" % slot_id)
        for entry in sorted(catalog[slot_id], key=sort_key(slot_id)):
            _reject_markup(entry["name"], "name")
            _reject_markup(entry["stat"], "stat")
            ranks = ", ".join(str(r) for r in entry["ranks"])
            lines.append(
                '            { name = "%s", stat = "%s", ranks = {%s} },'
                % (entry["name"], entry["stat"], ranks)
            )
        lines.append("        },")
    lines += ["    },", "}", ""]
    return "\n".join(lines)


def load_rows(path):
    with open(path, encoding="utf-8", newline="") as fh:
        return list(csv.DictReader(fh))


def verify_against_api(full_names):
    """Cross-check the catalogue against Enchanting formulas in the Game Data
    API. db2 alone would happily hand us a catalogue from the wrong expansion,
    and the quality marker that identifies an expansion is undocumented.

    This confirms the SET, not every family: only about half of Midnight's
    enchants are taught by a formula scroll, the rest come from a profession
    specialisation and exist as a spell with no item behind it. Spell search
    cannot close that gap either, because it ranks fuzzy matches across many
    pages and buries the exact name. So a family without a formula is normal,
    and a run where NOTHING matches is the real alarm.
    """
    import urllib.parse
    import blizzard_api

    env = blizzard_api.load_env()
    region = env.get("BLIZZARD_REGION", "eu")
    locale = env.get("BLIZZARD_LOCALE", "en_US")
    token = blizzard_api.get_access_token(
        env["BLIZZARD_CLIENT_ID"], env["BLIZZARD_CLIENT_SECRET"], region)

    formulas = set()
    for page in range(1, 8):
        params = urllib.parse.urlencode({
            "namespace": "static-%s" % region, "locale": locale,
            "item_class.id": 9, "item_subclass.id": 8,
            "orderby": "id:desc", "_page": page, "_pageSize": 100,
        })
        data = blizzard_api.api_get(
            "https://%s.api.blizzard.com/data/wow/search/item?%s" % (region, params), token)
        results = data.get("results", [])
        if not results:
            break
        for hit in results:
            name = (hit["data"].get("name") or {}).get(locale) or ""
            if name.startswith("Formula: Enchant "):
                formulas.add(name[len("Formula: "):].strip())
        if data.get("pageCount") and page >= data["pageCount"]:
            break

    confirmed = sorted(n for n in full_names if n in formulas)
    unconfirmed = sorted(n for n in full_names if n not in formulas)
    return confirmed, unconfirmed


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--verify-api", action="store_true",
                        help="cross-check family names against Enchanting formulas")
    parser.add_argument("--quality-set", type=int, default=None,
                        help="quality marker set to build from (default: newest)")
    args = parser.parse_args()

    if not os.path.exists(CACHE):
        print("Brak %s - pobierz go najpierw (Task 2, krok 1)." % CACHE)
        return 2

    rows = load_rows(CACHE)
    pairs = [(row["ID"], row["Name_lang"] or "") for row in rows]
    stats_by_id = {int(row["ID"]): stats_from_row(row) for row in rows}

    quality_set = args.quality_set
    if quality_set is None:
        quality_set = pick_quality_set(pairs)
    print("Zestaw jakosci: %s" % ("(bez numeru)" if quality_set == 0 else quality_set))

    ranks_by_name = group_ranks(pairs, quality_set)

    catalog, skipped, full_names = {}, [], []
    for name, ranks in sorted(ranks_by_name.items()):
        parts = split_slot(name)
        try:
            info = resolve_slot(name)
        except KeyError:
            if not parts or parts[0] not in SKIP_SLOTS:
                skipped.append(name)
            continue
        short = parts[1] if parts else name
        stat = info.get("stat") or primary_stat(stats_by_id.get(ranks[0], []))
        catalog.setdefault(info["slot"], []).append(
            {"name": short, "stat": stat, "ranks": ranks}
        )
        full_names.append(name)

    if not catalog:
        print("Zadna rodzina nie ma slotu - sprawdz marker jakosci i PREFIX_RE.")
        return 1

    if args.verify_api:
        confirmed, unconfirmed = verify_against_api(full_names)
        print("\nAPI: %d z %d rodzin ma formule-zwoj" % (len(confirmed), len(full_names)))
        if not confirmed:
            print("Zadna rodzina nie ma formuly w API - komplet moze byc")
            print("z innej ekspansji. Sprawdz marker jakosci przed uzyciem.")
            return 1
        print("Reszta pochodzi ze specjalizacji profesji i nie ma itemu:")
        for name in unconfirmed:
            print("   %s" % name)

    # CRLF: .lua files in this repo use CRLF; newline="" preserves what we write.
    with open(OUT, "w", encoding="utf-8", newline="") as fh:
        fh.write(render_lua(catalog, SEASON).replace("\n", "\r\n"))

    total = sum(len(v) for v in catalog.values())
    print("\nZapisano %s - %d enchantow w %d slotach" % (OUT, total, len(catalog)))
    for slot_id in sorted(catalog):
        print("   slot %-3d %d" % (slot_id, len(catalog[slot_id])))
    if skipped:
        print("\nRodziny z markerem, ale bez rozpoznanego slotu (%d):" % len(skipped))
        for name in skipped:
            print("   %s" % name)
    return 0


if __name__ == "__main__":
    sys.exit(main())
