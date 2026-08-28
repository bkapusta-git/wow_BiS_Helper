#!/usr/bin/env python3
"""Structural sanity check for Lua files — no interpreter required.

WoW addons run Lua 5.1 and this machine has no lua/luac, so syntax errors
only surface after /reload in game. This catches the two failure modes that
scripted edits actually produce: unbalanced delimiters and unclosed blocks.

Strips comments and string literals first, so `end` inside a comment or a
quoted string cannot skew the count.

Usage:  python tools/check_lua_structure.py addon/BiS_Helper.lua
Exits non-zero if anything is flagged, so it can gate a commit.
"""
import re
import sys

# Keywords that open a block requiring a matching `end`.
# `elseif` continues an `if` — it opens no new block and needs no `end`.
OPENERS = ("function", "do", "then")


def _detect_long_bracket(text, i):
    """Detect if position i starts a long bracket sequence.

    Returns (level, close_pattern) if it's a long bracket, or (None, None) if not.
    A long bracket is [=*[ where * is zero or more '='.
    Examples:
      - [[ ... ]] (level 0)
      - [=[ ... ]=] (level 1)
      - [==[ ... ]==] (level 2)
    """
    if i >= len(text) or text[i] != '[':
        return None, None

    j = i + 1
    while j < len(text) and text[j] == '=':
        j += 1

    if j < len(text) and text[j] == '[':
        level = j - i - 1
        close_pattern = "]" + "=" * level + "]"
        return level, close_pattern

    return None, None


def _scan(text):
    """Single pass over the source.

    Returns (code, unterminated) where `code` has comments and string
    literals removed, and `unterminated` is True when a quote opened and
    the file ended before it closed.

    Counting quotes per line does NOT work here: apostrophes appear inside
    comments (Polish text) and inside data strings ("Kings' Rest"), and
    both would look like an odd quote count. Only a real scanner that
    already knows it is inside a comment can tell those apart.
    """
    out = []
    i, n = 0, len(text)
    unterminated = False
    while i < n:
        # Handle line comments and block comments
        if text[i:i + 2] == "--":
            # Check if it's a block comment (--[[, --[=[, etc.)
            level, close_pattern = _detect_long_bracket(text, i + 2)
            if level is not None:
                # It's a block comment
                pos = text.find(close_pattern, i + level + 4)
                i = n if pos == -1 else pos + len(close_pattern)
            else:
                # It's a line comment
                end = text.find("\n", i)
                i = n if end == -1 else end
            continue

        # Handle bare long bracket strings (not after --)
        level, close_pattern = _detect_long_bracket(text, i)
        if level is not None:
            # It's a long bracket string
            pos = text.find(close_pattern, i + level + 2)
            if pos == -1:
                # Unterminated long bracket string
                unterminated = True
                i = n
            else:
                i = pos + len(close_pattern)
            continue

        # Handle quoted strings
        if text[i] in "\"'":
            quote = text[i]
            i += 1
            closed = False
            while i < n:
                if text[i] == "\\":
                    i += 2
                    continue
                if text[i] == quote:
                    closed = True
                    i += 1
                    break
                # A newline ends a Lua short string; an unescaped one means
                # the literal was never closed.
                if text[i] == "\n":
                    break
                i += 1
            if not closed:
                unterminated = True
        else:
            out.append(text[i])
            i += 1
    return "".join(out), unterminated


def strip_lua(text):
    """Remove comments and string literals, preserving everything else."""
    return _scan(text)[0]


def check(text):
    """Return a list of human-readable structural problems."""
    issues = []
    code, unterminated = _scan(text)
    if unterminated:
        issues.append("niedomkniety string literal")

    for open_ch, close_ch in (("(", ")"), ("[", "]"), ("{", "}")):
        delta = code.count(open_ch) - code.count(close_ch)
        if delta:
            issues.append(
                f"niezbalansowane {open_ch}{close_ch}: roznica {delta:+d}"
            )

    words = re.findall(r"\b\w+\b", code)
    # `elseif x then` contributes a `then` but continues the enclosing `if`
    # rather than opening a block, so it must be subtracted back out.
    opens = sum(words.count(k) for k in OPENERS) - words.count("elseif")
    ends = words.count("end")
    if opens != ends:
        issues.append(
            f"niezbalansowane bloki: function+do+then-elseif={opens}, end={ends} "
            f"(roznica {opens - ends:+d})"
        )
    return issues


def main(paths):
    flagged = 0
    for path in paths:
        with open(path, encoding="utf-8", newline="") as fh:
            issues = check(fh.read())
        if issues:
            flagged += 1
            print(f"\n{path}")
            for issue in issues:
                print(f"   {issue}")
    print(f"\n=== sprawdzono {len(paths)} plikow, {flagged} z uwagami ===")
    return 1 if flagged else 0


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(2)
    sys.exit(main(sys.argv[1:]))
