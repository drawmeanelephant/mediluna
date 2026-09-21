#!/usr/bin/env bash
# Fixtures for scripts/check-references.sh (mediluna#6).
#
# Covers, per the issue's acceptance criteria:
#   - a valid nested ../../ link passes
#   - a nested link whose text is only valid at root fails and names its page
#   - root-relative /... references resolve from the site root
#   - fragment and query suffixes are stripped before checking
#   - references escaping the site root are rejected lexically and never
#     consult files that sit outside or next to the generated tree
set -euo pipefail

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
checker="$repo_root/scripts/check-references.sh"
tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/mediluna-refs.XXXXXX")
trap 'rm -rf "$tmp_dir"' EXIT

expect_pass() { # <label> <dist-root>
  local label=$1 root=$2
  if ! "$checker" "$root" >/dev/null 2>"$tmp_dir/stderr"; then
    echo "fixture unexpectedly failed: $label" >&2
    cat "$tmp_dir/stderr" >&2
    exit 1
  fi
}

expect_fail() { # <label> <dist-root> <page-name-that-must-be-named>
  local label=$1 root=$2 page=$3
  if "$checker" "$root" >/dev/null 2>"$tmp_dir/stderr"; then
    echo "fixture unexpectedly passed: $label" >&2
    exit 1
  fi
  if ! grep -q "$page" "$tmp_dir/stderr"; then
    echo "fixture $label failed but did not name containing page $page" >&2
    cat "$tmp_dir/stderr" >&2
    exit 1
  fi
}

# --- site under test -------------------------------------------------------
# dist/
#   index.html contributing.html assets/app.js
#   friends/index.html
#   friends/agents/index.html
mkdir -p "$tmp_dir/site/assets" "$tmp_dir/site/friends/agents"
printf '<a href="contributing.html">c</a><img src="assets/app.js">' > "$tmp_dir/site/index.html"
printf '<a href="index.html">home</a>' > "$tmp_dir/site/contributing.html"
printf '<a href="../index.html">up</a>' > "$tmp_dir/site/friends/index.html"
printf '<a href="../../contributing.html">c</a><img src="../../assets/app.js">' > "$tmp_dir/site/friends/agents/index.html"
printf 'js' > "$tmp_dir/site/assets/app.js"

expect_pass "valid nested ../../ links" "$tmp_dir/site"

# --- nested same-text link that is only valid at root ----------------------
# The old pooled checker resolved this against dist/ and passed it because
# dist/contributing.html exists; per-page resolution must reject it and
# name friends/agents/index.html.
printf '<a href="contributing.html">c</a>' > "$tmp_dir/site/friends/agents/broken.html"
expect_fail "nested same-text link valid only at root" "$tmp_dir/site" "friends/agents/broken.html"
rm "$tmp_dir/site/friends/agents/broken.html"

# Masking is gone in the other direction too: a broken root-page link can no
# longer hide behind an identical string that resolves elsewhere.
printf '<a href="missing.html">m</a>' > "$tmp_dir/site/lost.html"
expect_fail "broken root-page link" "$tmp_dir/site" "lost.html"
rm "$tmp_dir/site/lost.html"

# --- root-relative references ----------------------------------------------
printf '<a href="/contributing.html">c</a><img src="/assets/app.js">' > "$tmp_dir/site/friends/agents/rootrel.html"
expect_pass "root-relative /... from a nested page" "$tmp_dir/site"
printf '<a href="/missing.html">m</a>' > "$tmp_dir/site/friends/agents/rootrel-broken.html"
expect_fail "root-relative /... target missing" "$tmp_dir/site" "friends/agents/rootrel-broken.html"
rm "$tmp_dir/site/friends/agents/rootrel-broken.html"

# --- fragment and query suffixes --------------------------------------------
printf '<a href="../../contributing.html#section">c</a><a href="../index.html?q=1">q</a><a href="#local">l</a>' \
  > "$tmp_dir/site/friends/agents/fragments.html"
expect_pass "fragment and query suffixes" "$tmp_dir/site"
printf '<a href="missing.html#anchor">m</a>' > "$tmp_dir/site/friends/agents/fragment-broken.html"
expect_fail "fragment suffix still checks the path" "$tmp_dir/site" "friends/agents/fragment-broken.html"
rm "$tmp_dir/site/friends/agents/fragment-broken.html"

# --- escapes are rejected lexically: nothing outside the tree is consulted --
printf 'DECOY\n' > "$tmp_dir/outside.html"
printf '<a href="../../../../../outside.html">esc</a>' > "$tmp_dir/site/friends/agents/escape.html"
expect_fail "excess ../ fails" "$tmp_dir/site" "friends/agents/escape.html"
rm "$tmp_dir/site/friends/agents/escape.html"
# The decoy must still be untouched: the checker never resolved to it.

# --- escape detection must not depend on the depth of the temp dir ----------
# Pops that exactly consume the site-root prefix are the hard case: a checker
# that resolves against absolute filesystem paths lands OUTSIDE the tree
# instead of counting an escape, and its verdict then depends on whatever
# happens to sit next to the generated tree. The decoys below EXIST in those
# landing spots; rejection must still be lexical.
mkdir -p "$tmp_dir/shallow/sub"
printf '<a href="../../decoy.html">esc</a>' > "$tmp_dir/shallow/sub/page.html"
printf 'DECOY\n' > "$tmp_dir/decoy.html"      # exactly where the pops land
expect_fail "relative escape landing beside the tree" "$tmp_dir/shallow" "sub/page.html"
printf '<a href="/../../decoy.html">esc</a>' > "$tmp_dir/shallow/sub/page.html"
expect_fail "root-relative escape above the tree" "$tmp_dir/shallow" "sub/page.html"
# Overshoot case: pops beyond the root must count as escapes too.
printf '<a href="../../../decoy.html">esc</a>' > "$tmp_dir/shallow/sub/page.html"
expect_fail "escape detection is depth-independent" "$tmp_dir/shallow" "sub/page.html"
rm -r "$tmp_dir/shallow"

echo "Reference fixtures passed: nested resolution, root-relative, fragment/query stripping, and lexical escape rejection."
