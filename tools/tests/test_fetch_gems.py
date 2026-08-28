import sys, os
import pytest
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from fetch_gems import parse_effect, pick_best, render_lua, SECONDARY_STATS


def test_parse_effect_reads_single_stat():
    assert parse_effect("+15 Haste") == (15, "Haste")


def test_parse_effect_reads_two_word_stat():
    assert parse_effect("+15 Critical Strike") == (15, "Critical Strike")


def test_parse_effect_rejects_hybrid():
    # A hybrid would need a weighting rule the addon has no basis for.
    assert parse_effect("+11 Critical Strike & +4 Haste") is None


def test_parse_effect_rejects_proc_text():
    assert parse_effect("+20 Primary Stat and +5% Damage Reduction") is None


def test_parse_effect_handles_missing_effect():
    assert parse_effect(None) is None
    assert parse_effect("") is None


def test_pick_best_keeps_strongest_per_stat():
    gems = [
        {"id": 240855, "name": "Quick Peridot", "stat": "Haste", "amount": 11},
        {"id": 240888, "name": "Flawless Quick Peridot", "stat": "Haste", "amount": 15},
        {"id": 240856, "name": "Quick Peridot", "stat": "Haste", "amount": 12},
    ]
    assert pick_best(gems)["Haste"]["id"] == 240888


def test_pick_best_breaks_ties_on_lower_id():
    # Without a tiebreak the choice would depend on API result order and could
    # change between runs with nothing in the diff to explain it.
    gems = [
        {"id": 300, "name": "B", "stat": "Haste", "amount": 15},
        {"id": 200, "name": "A", "stat": "Haste", "amount": 15},
    ]
    assert pick_best(gems)["Haste"]["id"] == 200


def test_pick_best_separates_stats():
    gems = [
        {"id": 1, "name": "A", "stat": "Haste", "amount": 15},
        {"id": 2, "name": "B", "stat": "Mastery", "amount": 15},
    ]
    assert set(pick_best(gems)) == {"Haste", "Mastery"}


def test_secondary_stats_match_spec_file_names():
    # Compared verbatim against statPriority[mode].stats[].name; a variant
    # silently never matches and the gem is never recommended.
    assert SECONDARY_STATS == {"Critical Strike", "Haste", "Mastery", "Versatility"}


def test_render_lua_emits_by_stat_table():
    best = {"Haste": {"id": 240888, "name": "Flawless Quick Peridot", "amount": 15}}
    out = render_lua(best, "Midnight Season 2")
    assert "BiSHelper_Gems" in out
    assert 'season = "Midnight Season 2"' in out
    assert '["Haste"] = { itemID = 240888, name = "Flawless Quick Peridot" }' in out


def test_render_lua_has_no_pipe_character():
    best = {"Haste": {"id": 1, "name": "Flawless Quick Peridot", "amount": 15}}
    assert "|" not in render_lua(best, "Midnight Season 2")


def test_render_lua_rejects_markup_in_name():
    best = {"Haste": {"id": 1, "name": "Gem |cffff0000X|r", "amount": 15}}
    with pytest.raises(ValueError):
        render_lua(best, "Midnight Season 2")


def test_render_lua_rejects_double_quote_in_name():
    best = {"Haste": {"id": 1, "name": 'Gem "X"', "amount": 15}}
    with pytest.raises(ValueError):
        render_lua(best, "Midnight Season 2")
