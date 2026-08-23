import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from check_lua_structure import strip_lua, check


def test_strip_removes_line_comment():
    assert "end" not in strip_lua("-- end end end\n")


def test_strip_removes_block_comment():
    assert "end" not in strip_lua("--[[ end end ]]")


def test_strip_removes_double_quoted_string():
    assert "function" not in strip_lua('local s = "function do then"')


def test_strip_removes_single_quoted_string():
    assert "function" not in strip_lua("local s = 'function do then'")


def test_strip_keeps_code_outside_strings():
    assert "function" in strip_lua('local f = function() return "x" end')


def test_balanced_file_has_no_issues():
    src = 'local t = { a = 1 }\nlocal function f(x)\n  if x then return 1 end\nend\n'
    assert check(src) == []


def test_unbalanced_braces_flagged():
    issues = check("local t = { a = 1\n")
    assert any("{" in i for i in issues)


def test_missing_end_flagged():
    issues = check("local function f()\n  if true then\n    return 1\n  end\n")
    assert any("end" in i for i in issues)


def test_elseif_does_not_require_extra_end():
    src = 'if a then\n  x()\nelseif b then\n  y()\nend\n'
    assert check(src) == []


def test_unterminated_string_flagged():
    issues = check('local s = "abc\n')
    assert any("string" in i.lower() for i in issues)
