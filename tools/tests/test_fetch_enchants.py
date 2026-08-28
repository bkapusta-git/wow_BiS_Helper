import sys, os
import pytest
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from fetch_enchants import (parse_tier, pick_quality_set, group_ranks, split_slot,
                            resolve_slot, stats_from_row, primary_stat, sort_key,
                            render_lua, SLOT_IDS, ITEM_STAT, PREFERRED_FIRST, NO_STAT)

TWW = "Chant of Winged Grace |A:Professions-ChatIcon-Quality-Tier%d:20:20|a"
MIDNIGHT = "Enchant Ring - Silvermoon's Tenacity |A:Professions-ChatIcon-Quality-12-Tier%d:20:20|a"

VALID_STATS = {"Critical Strike", "Haste", "Mastery", "Versatility",
               "Leech", "Avoidance", "Speed"}


def test_parse_tier_extracts_name_tier_and_set():
    assert parse_tier(TWW % 3) == ("Chant of Winged Grace", 3, 0)


def test_parse_tier_reads_expansion_numbered_marker():
    # Midnight added an expansion number to the marker. Matching only the old
    # shape yields an empty catalogue with no error at all.
    assert parse_tier(MIDNIGHT % 2) == ("Enchant Ring - Silvermoon's Tenacity", 2, 12)


def test_parse_tier_returns_none_without_marker():
    assert parse_tier("Some Old Enchant") is None


def test_pick_quality_set_prefers_newest():
    rows = [(1, TWW % 1), (2, TWW % 2), (3, MIDNIGHT % 1)]
    assert pick_quality_set(rows) == 12


def test_group_ranks_orders_by_tier():
    rows = [(7403, TWW % 3), (7401, TWW % 1), (7402, TWW % 2)]
    assert group_ranks(rows) == {"Chant of Winged Grace": [7401, 7402, 7403]}


def test_group_ranks_accepts_two_rank_family():
    # Midnight ships two crafting ranks, not three. Demanding three drops the
    # entire expansion's catalogue.
    rows = [(8026, MIDNIGHT % 1), (8027, MIDNIGHT % 2)]
    assert group_ranks(rows) == {"Enchant Ring - Silvermoon's Tenacity": [8026, 8027]}


def test_group_ranks_rejects_gap_in_ranks():
    # Tier 1 and 3 without 2 would make ranks[2] read as max rank and the addon
    # would call a mid-rank enchant fully upgraded.
    rows = [(7401, TWW % 1), (7403, TWW % 3)]
    assert group_ranks(rows) == {}


def test_group_ranks_rejects_single_rank():
    assert group_ranks([(7401, TWW % 1)]) == {}


def test_group_ranks_filters_by_quality_set():
    rows = [(7401, TWW % 1), (7402, TWW % 2), (8026, MIDNIGHT % 1), (8027, MIDNIGHT % 2)]
    assert list(group_ranks(rows, quality_set=12)) == ["Enchant Ring - Silvermoon's Tenacity"]
    assert list(group_ranks(rows, quality_set=0)) == ["Chant of Winged Grace"]


def test_split_slot_reads_prefix():
    assert split_slot("Enchant Ring - Silvermoon's Tenacity") == (
        "Ring", "Silvermoon's Tenacity")


def test_split_slot_returns_none_for_illusion():
    assert split_slot("Illusory Adornment - Voidtouched") is None


def test_resolve_slot_maps_prefix_to_slot_id():
    assert resolve_slot("Enchant Ring - Silvermoon's Tenacity")["slot"] == 11
    assert resolve_slot("Enchant Chest - Mark of the Magister")["slot"] == 5


def test_unknown_enchant_name_raises():
    with pytest.raises(KeyError):
        resolve_slot("Enchant That Does Not Exist")


def test_tool_enchant_has_no_equipment_slot():
    # Profession tools share the naming scheme but no gear row can show them.
    with pytest.raises(KeyError):
        resolve_slot("Enchant Tool - Amani Perception")


def test_stats_from_row_reads_stat_effects():
    # Effect_N == 5 is a stat effect; EffectArg_N is then an ItemStatType.
    row = {"Effect_0": "5", "EffectArg_0": "63", "Effect_1": "5", "EffectArg_1": "7"}
    assert stats_from_row(row) == ["Avoidance", "Stamina"]


def test_stats_from_row_ignores_proc_effects():
    row = {"Effect_0": "3", "EffectArg_0": "1236707"}
    assert stats_from_row(row) == []


def test_primary_stat_skips_stamina():
    # Stamina rides along on several families and must never drive the match.
    assert primary_stat(["Avoidance", "Stamina"]) == "Avoidance"
    assert primary_stat(["Stamina", "Speed"]) == "Speed"


def test_primary_stat_falls_back_for_proc_enchants():
    assert primary_stat([]) == NO_STAT


def test_item_stat_uses_full_wow_stat_names():
    # These strings are compared verbatim against statPriority[mode].stats[].name
    # in the spec data files; an abbreviation or a variant silently never matches.
    secondaries = {32: "Critical Strike", 36: "Haste", 40: "Versatility", 49: "Mastery"}
    for stat_id, name in secondaries.items():
        assert ITEM_STAT[stat_id] == name


def test_preferred_first_names_a_real_slot():
    for slot_id in PREFERRED_FIRST:
        assert slot_id in SLOT_IDS.values()


def test_sort_key_puts_preferred_entry_first():
    entries = [{"name": "Mark of Nalorakk"}, {"name": "Mark of the Worldsoul"}]
    assert sorted(entries, key=sort_key(5))[0]["name"] == "Mark of the Worldsoul"


def test_render_lua_groups_by_slot():
    catalog = {
        11: [{"name": "Silvermoon's Tenacity", "stat": "Versatility", "ranks": [8026, 8027]}],
    }
    out = render_lua(catalog, "Midnight Season 2")
    assert "BiSHelper_Enchants" in out
    assert 'season = "Midnight Season 2"' in out
    assert "[11] = {" in out
    assert 'stat = "Versatility"' in out
    assert "ranks = {8026, 8027}" in out


def test_render_lua_has_no_pipe_character():
    # "|" starts an escape sequence in WoW UI markup and corrupts rendering.
    catalog = {15: [{"name": "Chant of Winged Grace", "stat": "Avoidance", "ranks": [1, 2, 3]}]}
    assert "|" not in render_lua(catalog, "Midnight Season 2")


def test_render_lua_rejects_markup_that_survives_parse_tier():
    # parse_tier only strips the trailing tier marker, so markup earlier in the
    # raw name reaches render_lua. That must be refused, not emitted.
    raw = "Chant of |cffff0000Danger|r Grace |A:Professions-ChatIcon-Quality-Tier3:20:20|a"
    name, tier, marker = parse_tier(raw)
    assert "|" in name, "fixture must actually carry markup past parse_tier"
    with pytest.raises(ValueError):
        render_lua({15: [{"name": name, "stat": "Avoidance", "ranks": [1, 2, 3]}]}, "Midnight Season 2")


def test_render_lua_rejects_double_quote_in_name():
    with pytest.raises(ValueError):
        render_lua({15: [{"name": 'Chant of "Danger"', "stat": "Avoidance", "ranks": [1, 2, 3]}]}, "Midnight Season 2")
