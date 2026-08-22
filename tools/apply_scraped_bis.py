#!/usr/bin/env python3
"""
Apply Wowhead BiS gear rows scraped via a live browser (Claude in Chrome) to
addon/data/<spec>.lua.

Use this when update_bis_data.py --live gets blocked by Wowhead's Cloudflare
check (HTTP 403). Scrape the rendered "Overall BiS" table's rows as
(slot_name, item_id, item_name, source) tuples — e.g. by querying the DOM
table whose header row contains "Slot"/"Source" and reading each row's
<td> text plus the item ID out of its <a href> — then call apply_spec().

Gotcha: some guides render a 4-column table with a separate icon column, and
that icon is its own <a href="/item=NNNN"> with EMPTY text and a DIFFERENT item
id than the actual BiS piece. Taking the row's first item anchor silently
yields blank names and duplicated ids across slots. Always take the first item
anchor whose text is non-empty.

Second gotcha: Wowhead uses at least three different BiS table layouts, and some
rows carry a trailing EMPTY <td> the header row does not declare. Reading source
as `tds[tds.length - 1]` then yields empty sources for the whole spec. Locate the
source column by its header index instead, falling back to the last non-empty
<td> that is neither the slot nor the name.

Example:
    import sys
    sys.path.insert(0, r"D:\\Workspace\\wow_addon\\BiS_Helper\\tools")
    from apply_scraped_bis import apply_spec

    rows = [
        ("Weapon", 268209, "Aman'muso, Warlord's Vengeance", "The Coiled Altar"),
        ("Head", 271875, "Gaze of the Coiled Watcher", "Ula'tek"),
        ...
    ]
    apply_spec("DEMONHUNTER_HAVOC", rows)
"""
import os
import sys

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, SCRIPT_DIR)
import update_bis_data as ub

DATA_DIR = os.path.join(os.path.dirname(SCRIPT_DIR), "addon", "data")


def resolve_rows(rows):
    """Mirror update_bis_data.parse_wh_bis_table's slot resolution (ring/trinket counters).

    Duplicate slot assignments (e.g. a 3rd "situational" trinket) are left in;
    write_lua_file's own dedup keeps the first occurrence per slot_id and drops
    the rest, which is the desired behavior for extra/alt items Wowhead lists.
    """
    bis_list = []
    ring_count = 0
    trinket_count = 0
    for slot_name, item_id, item_name, source in rows:
        # Wowhead lists multiple sources pipe-separated ("Catalyst|Raid|Vault").
        # "|" starts an escape sequence in WoW's UI markup (|c, |r, |T) and would
        # break rendering, so normalize it to a plain separator.
        item_name = item_name.replace("|", " / ")
        source = source.replace("|", " / ")
        slot_name_l = slot_name.lower()
        slot_id = None
        for key, val in ub.WOWHEAD_SLOT_MAP.items():
            if key in slot_name_l:
                slot_id = val
                break
        if slot_id is None:
            print(f"  WARNING: could not map slot '{slot_name}' for {item_name} ({item_id})")
            continue
        if slot_id == 11:
            ring_count += 1
            slot_id = 11 if ring_count == 1 else 12
        elif slot_id == 13:
            trinket_count += 1
            slot_id = 13 if trinket_count == 1 else 14
        bis_list.append((slot_id, item_id, item_name, source))
    return bis_list


def apply_spec(spec_key, rows, stat_priority=None, dr=None):
    """Write scraped BiS rows into the spec's Lua data file.

    rows: list of (slot_name, item_id, item_name, source) from the Wowhead
    "Overall BiS" table — used for both raid and mythicplus content, matching
    how update_bis_data.py treats a single combined guide table.
    stat_priority/dr: pass to override; omit to keep what's already in the file
    (update_bis_data.SPEC statPriority format / dr list format — see an
    existing addon/data/*.lua file for the shape).
    """
    if spec_key not in ub.SPECS:
        raise KeyError(f"Unknown spec_key {spec_key!r} — check tools/update_bis_data.py SPECS")

    meta = ub.SPECS[spec_key]
    lua_path = os.path.join(DATA_DIR, meta["filename"])
    existing = ub.read_existing_lua(lua_path)
    if existing is None:
        raise RuntimeError(f"Could not read existing file {lua_path}")

    bis_list = resolve_rows(rows)
    if not bis_list:
        raise RuntimeError(f"{spec_key}: no rows resolved, refusing to write an empty file")

    source_urls = [
        f"https://www.wowhead.com/guide/classes/{meta['class_slug']}/{meta['spec_slug']}/bis-gear",
        f"https://www.wowhead.com/guide/classes/{meta['class_slug']}/{meta['spec_slug']}/stat-priority-pve-{meta['role']}",
    ]

    print(f"{spec_key}: {len(bis_list)} items resolved")
    for slot_id, item_id, name, source in sorted(bis_list, key=lambda x: x[0]):
        print(f"  [{slot_id}] {item_id}: {name} ({source})")

    ub.write_lua_file(
        lua_path, spec_key, existing,
        bis_list, list(bis_list),
        stat_priority if stat_priority is not None else existing["statPriority"],
        dr if dr is not None else existing["dr"],
        source_urls,
    )
    print(f"  Wrote {lua_path}")
    return lua_path


if __name__ == "__main__":
    print(__doc__)
