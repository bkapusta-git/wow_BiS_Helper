import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from audit_bis_data import load_enchant_catalogue, audit_enchant_overrides

CATALOGUE_LUA = """
BiSHelper_Enchants = {
    season = "Midnight Season 2",
    slots = {
        [15] = {
            { name = "Chant of Winged Grace", stat = "Avoidance", ranks = {7401, 7402, 7403} },
        },
        [11] = {
            { name = "Radiant Haste", stat = "Haste", ranks = {7335, 7336, 7337} },
        },
    },
}
"""


def test_catalogue_parses_slots_and_names(tmp_path):
    path = tmp_path / "enchants.lua"
    path.write_text(CATALOGUE_LUA, encoding="utf-8")
    cat = load_enchant_catalogue(str(path))
    assert cat[15] == {"Chant of Winged Grace"}
    assert cat[11] == {"Radiant Haste"}


def test_valid_override_passes():
    spec = 'enchants = { [15] = "Chant of Winged Grace" },'
    assert audit_enchant_overrides(spec, {15: {"Chant of Winged Grace"}}) == []


def test_unknown_name_flagged():
    spec = 'enchants = { [15] = "Nonexistent Chant" },'
    issues = audit_enchant_overrides(spec, {15: {"Chant of Winged Grace"}})
    assert issues and "Nonexistent Chant" in issues[0]


def test_override_on_slot_without_catalogue_flagged():
    spec = 'enchants = { [1] = "Chant of Winged Grace" },'
    issues = audit_enchant_overrides(spec, {15: {"Chant of Winged Grace"}})
    assert issues and "1" in issues[0]


def test_file_without_enchants_section_passes():
    assert audit_enchant_overrides("content = { raid = {} }", {15: {"X"}}) == []


def test_incomplete_ranks_flagged(tmp_path):
    broken = CATALOGUE_LUA.replace("{7401, 7402, 7403}", "{7401, 7402}")
    path = tmp_path / "enchants.lua"
    path.write_text(broken, encoding="utf-8")
    from audit_bis_data import audit_catalogue_ranks
    assert audit_catalogue_ranks(str(path)) != []
