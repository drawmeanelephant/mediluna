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
# Dot segments are collapsed lexically (RFC 3986 §5.2.4), relative to the
# site root. A reference that pops above the site root is rejected without
# touching the filesystem, so the checker never depends on what happens to
# sit next to the generated tree (or outside it) and its verdict cannot
# vary with the depth of the directory it runs in. This is deliberately
# stricter than browser clamping: in a deployed static site nothing exists
# above the tree, so a root page linking "../x" is an authoring error.
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

# normalize <rel-path> — collapses dot segments in <rel-path>, which is
# relative to the site root; sets _norm_rel to the normalized relative
# path ('' meaning the site root itself) and _escapes to the number of
# ".." segments that popped above the site root.
normalize() {
  local rel=$1 acc='' seg escapes=0
  local IFS=/
  set -f
  for seg in $rel; do
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
  _norm_rel=$acc
  _escapes=$escapes
}

check_page() { # <abs-page>
  local page=$1
  local page_rel=${page#"$dist_root"/}
  local base_rel
  base_rel=$(dirname -- "$page_rel")
  local ref path rel
  while IFS= read -r ref; do
    case $ref in
      ''|\#*|http://*|https://*|//*|mailto:*|javascript:*|data:*) continue ;;
    esac
    path=${ref%%\?*}
    path=${path%%\#*}
    [ -n "$path" ] || continue
    case $path in
      /*) rel=${path#/} ;;                   # site-root-relative
      .) rel=$base_rel ;;
      *)
        if [ "$base_rel" = "." ]; then
          rel=$path                          # page at the site root
        else
          rel="$base_rel/$path"              # relative to the page
        fi
        ;;
    esac
    normalize "$rel"
    if [ "$_escapes" -gt 0 ]; then
      report_broken "$page_rel" "$ref" "escapes the site root by $_escapes level(s)"
    elif [ -z "$_norm_rel" ]; then
      report_broken "$page_rel" "$ref" "resolves to the site root, not a file"
    elif [ ! -f "$dist_root$_norm_rel" ]; then
      report_broken "$page_rel" "$ref" "target not found: ${_norm_rel#/}"
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
