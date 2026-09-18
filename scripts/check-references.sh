#!/usr/bin/env bash
# Validate internal href/src references relative to the page that carries
# each one (mediluna#6).
#
# Usage: check-references.sh <dist-root>
#
# The generated tree is walked page by page; every href/src value on a page
# is resolved the way a browser would:
#   - relative values  -> against the containing page's directory
#   - "/..." values    -> site-root-relative, against <dist-root>
# Query strings and fragments are stripped before the existence check, and
# empty references, pure fragments, and external schemes are skipped.
#
# Dot segments are collapsed lexically (RFC 3986 §5.2.4). A reference that
# pops above the site root is rejected without touching the filesystem, so
# the checker never depends on what happens to sit next to the generated
# tree (or outside it).
#
# Diagnostics name the containing page (relative to <dist-root>) so a
# failure can be located without re-deriving which page held the reference.
set -euo pipefail

usage() {
  echo "usage: $0 <dist-root>" >&2
  exit 2
}

[ "$#" -eq 1 ] || usage
[ -d "$1" ] || { echo "not a directory: $1" >&2; exit 2; }
dist_root=$(cd -- "$1" && pwd)

failures=0

report_broken() { # <page-relative> <reference> <reason>
  echo "broken internal reference in $1: $2 ($3)" >&2
  failures=$((failures + 1))
}

# normalize <abs-base> <reference-path> — lexically resolves the reference
# against <abs-base>; sets _norm to the absolute result and _escapes to the
# number of ".." segments that popped above the site root. A nonzero
# _escapes means the reference leaves the generated tree; the caller
# rejects it without an exists-check.
normalize() {
  local base=$1 ref=$2 acc='' seg escapes=0
  local IFS=/
  local p
  case $ref in
    /*) p="$base$ref" ;;   # site-root-relative: base is the site root
    *)  p="$base/$ref" ;;  # relative to the containing page
  esac
  set -f
  for seg in $p; do
    case $seg in
      ''|.) ;;
      ..)
        if [ -n "$acc" ]; then
          acc=${acc%/*}
        else
          escapes=$((escapes + 1))
        fi
        ;;
      *) acc="$acc/$seg" ;;
    esac
  done
  set +f
  _norm=$acc
  _escapes=$escapes
}

check_page() { # <abs-page>
  local page=$1
  local page_rel=${page#"$dist_root"/}
  local base
  base=$(dirname -- "$page")
  local ref path
  while IFS= read -r ref; do
    case $ref in
      ''|\#*|http://*|https://*|//*|mailto:*|javascript:*|data:*) continue ;;
    esac
    path=${ref%%\?*}
    path=${path%%\#*}
    [ -n "$path" ] || continue
    case $path in
      /*) normalize "$dist_root" "$path" ;;   # site-root-relative
      *)  normalize "$base" "$path" ;;        # relative to the page
    esac
    if [ "$_escapes" -gt 0 ]; then
      report_broken "$page_rel" "$ref" "escapes the generated tree by $_escapes level(s)"
    elif [ "$_norm" = "$dist_root" ]; then
      report_broken "$page_rel" "$ref" "resolves to the site root, not a file"
    elif [ ! -f "$_norm" ]; then
      report_broken "$page_rel" "$ref" "target not found: ${_norm#"$dist_root"/}"
    fi
  done < <(
    { grep -Eo '(href|src)="[^"]+"' "$page" || true; } |
      sed -E 's/.*(href|src)="([^"]+)"/\2/'
  )
}

while IFS= read -r page; do
  check_page "$page"
done < <(find "$dist_root" -type f -name '*.html' -print | sort)

if [ "$failures" -gt 0 ]; then
  echo "internal reference check failed: $failures broken reference(s)" >&2
  exit 1
fi
