#!/usr/bin/env bash
set -euo pipefail

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/mediluna-ci.XXXXXX")
trap 'rm -rf "$tmp_dir"' EXIT

check_file() {
  if [ ! -s "$1" ]; then
    echo "missing or empty required file: ${1#"$tmp_dir/"}" >&2
    exit 1
  fi
}

for path in \
  bin/boris \
  build.sh \
  index.css \
  app.js \
  layouts/main.html \
  content/index.md \
  content/contributing.md \
  content/cvi.md \
  content/lore.md \
  content/art-archive.md \
  metadata/assets.json \
  metadata/vocabulary.md \
  content/art-archive.assets/mascot.png \
  content/art-archive.assets/wallpaper_adventure.png \
  art/mascot.png \
  avatars/avatar_standard.png \
  stickers/sticker_got_this.png \
  wallpapers/wallpaper_adventure.png \
  logos/logo_simple.png
do
  check_file "$repo_root/$path"
done

# Build from a clean copy so ignored files and a previous dist/ cannot mask defects.
tar -C "$repo_root" --exclude=.git -cf - . | tar -xf - -C "$tmp_dir"

run_clean_build() {
  rm -rf "$tmp_dir/dist"
  (
    cd "$tmp_dir"
    ./build.sh
  )
}

check_output() {
  for path in \
    dist/index.html \
    dist/contributing.html \
    dist/cvi.html \
    dist/lore.html \
    dist/art-archive.html \
    dist/index.css \
    dist/app.js \
    dist/art/mascot.png \
    dist/avatars/avatar_standard.png \
    dist/stickers/sticker_got_this.png \
    dist/wallpapers/wallpaper_adventure.png \
    dist/logos/logo_simple.png \
    dist/art-archive.assets/mascot.png \
    dist/art-archive.assets/wallpaper_adventure.png \
    dist/metadata/assets.json \
    dist/metadata/vocabulary.md
  do
    check_file "$tmp_dir/$path"
  done
}

validate_internal_references() {
  local ref path target file
  while IFS= read -r ref; do
    case "$ref" in
      ""|\#*|http://*|https://*|//*|mailto:*|javascript:*|data:*) continue ;;
    esac
    path=${ref%%\?*}
    path=${path%%\#*}
    [ -n "$path" ] || continue
    case "$path" in
      /*) target="$tmp_dir/dist$path" ;;
      *) target="$tmp_dir/dist/$path" ;;
    esac
    if [ ! -f "$target" ]; then
      echo "broken internal reference: $ref" >&2
      exit 1
    fi
  done < <(
    while IFS= read -r file; do
      grep -Eo '(href|src)="[^"]+"' "$file" || true
    done < <(find "$tmp_dir/dist" -type f -name '*.html' -print) |
      sed -E 's/.*(href|src)="([^"]+)"/\2/' |
      sort -u
  )
}

hash_output() {
  local file digest
  while IFS= read -r file; do
    digest=$(shasum -a 256 "$file" | awk '{print $1}')
    printf '%s  %s\n' "$digest" "${file#"$tmp_dir/"}"
  done < <(find "$tmp_dir/dist" -type f -print | sort)
}

run_clean_build
check_output
validate_internal_references
hash_output > "$tmp_dir/dist.sha256.first"

run_clean_build
check_output
validate_internal_references
hash_output > "$tmp_dir/dist.sha256.second"

if ! diff -u "$tmp_dir/dist.sha256.first" "$tmp_dir/dist.sha256.second"; then
  echo "generated output is not deterministic" >&2
  exit 1
fi

echo "CI checks passed: required files, build output, internal references, and deterministic output."
