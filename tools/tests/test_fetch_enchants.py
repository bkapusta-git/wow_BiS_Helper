import sys, os
import pytest
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from fetch_enchants import parse_tier, group_ranks, render_lua, SLOT_MAP


def test_parse_tier_extracts_name_and_tier():
    raw = "Chant of Winged Grace |A:Professions-ChatIcon-Quality-Tier3:20:20|a"
    assert parse_tier(raw) == ("Chant of Winged Grace", 3)


def test_parse_tier_handles_tier1():
    raw = "Chant of Winged Grace |A:Professions-ChatIcon-Quality-Tier1:20:20|a"
    assert parse_tier(raw) == ("Chant of Winged Grace", 1)


def test_parse_tier_returns_none_without_marker():
    assert parse_tier("Some Old Enchant") is None


def test_group_ranks_orders_by_tier():
    rows = [
        (7403, "Chant of Winged Grace |A:Professions-ChatIcon-Quality-Tier3:20:20|a"),
        (7401, "Chant of Winged Grace |A:Professions-ChatIcon-Quality-Tier1:20:20|a"),
        (7402, "Chant of Winged Grace |A:Professions-ChatIcon-Quality-Tier2:20:20|a"),
    ]
    assert group_ranks(rows) == {"Chant of Winged Grace": [7401, 7402, 7403]}


def test_group_ranks_skips_incomplete_families():
    rows = [
        (7401, "Half Enchant |A:Professions-ChatIcon-Quality-Tier1:20:20|a"),
        (7402, "Half Enchant |A:Professions-ChatIcon-Quality-Tier2:20:20|a"),
    ]
    assert group_ranks(rows) == {}


def test_render_lua_groups_by_slot():
    catalog = {
        15: [{"name": "Chant of Winged Grace", "stat": "Avoidance", "ranks": [7401, 7402, 7403]}],
    }
    out = render_lua(catalog, "Midnight Season 2")
    assert "BiSHelper_Enchants" in out
    assert 'season = "Midnight Season 2"' in out
    assert "[15] = {" in out
    assert 'stat = "Avoidance"' in out
    assert "ranks = {7401, 7402, 7403}" in out


def test_render_lua_has_no_pipe_character():
    # "|" starts an escape sequence in WoW UI markup and corrupts rendering.
    catalog = {15: [{"name": "Chant of Winged Grace", "stat": "Avoidance", "ranks": [1, 2, 3]}]}
    assert "|" not in render_lua(catalog, "Midnight Season 2")


def test_slot_map_uses_full_wow_stat_names():
    # Matching against statPriority compares these strings verbatim.
    for entry in SLOT_MAP.values():
        assert entry["stat"] != "Crit", "uzyj pelnej nazwy 'Critical Strike'"
        assert entry["stat"] != "Vers", "uzyj pelnej nazwy 'Versatility'"


def test_unknown_enchant_name_raises():
    from fetch_enchants import resolve_slot
    with pytest.raises(KeyError):
        resolve_slot("Enchant That Does Not Exist")
