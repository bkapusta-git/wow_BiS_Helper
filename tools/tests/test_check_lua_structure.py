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


def test_bare_long_bracket_string_with_keywords_as_prose():
    # Long strings should be stripped; keywords inside them should not count
    src = '''local HELP_TEXT = [[Some help text]] .. "x" .. [[
If you click Share and then Export, do this before you end your session.
]]
local function f()
    return 1
end
'''
    assert check(src) == []


def test_leveled_long_bracket_string():
    # [=[ ... ]=] should be recognized as a string
    src = '''local s = [=[
    This has "quotes" and 'apostrophes' and the word then and end and function
    ]=]
local function f() return 1 end
'''
    assert check(src) == []


def test_block_comment_with_leveled_brackets():
    # --[=[ ... ]=] should be recognized as a comment
    src = '''--[=[
    This is a comment with then, end, do, function keywords
    ]=]
local function f() return 1 end
'''
    assert check(src) == []


def test_unterminated_long_bracket_string_flagged():
    issues = check('local s = [=[unterminated\n')
    assert any("string" in i.lower() for i in issues)


def test_polish_comment_apostrophe_and_data_string_apostrophe():
    # An apostrophe inside a comment is an unclosed quote character. If comment
    # stripping ever ran after string scanning, that lone ' would open a string
    # literal and swallow the rest of the file. This pins the ordering.
    src = """-- nadpisujemy overridey gracza, potem czytamy Kings' Rest
local item = { name = "Kings' Rest", id = 123 }
local function f() return 1 end
"""
    assert check(src) == []


def test_apostrophe_in_comment_does_not_swallow_following_code():
    # The `end` below must still be counted: if the comment's apostrophe opened
    # a string, everything after it would vanish from the code stream.
    src = """local function f()
    -- to jest gracza's item, nie nasz
    return 1
end
"""
    assert check(src) == []
