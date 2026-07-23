#!/usr/bin/env bash
set -euo pipefail

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
validator="$repo_root/scripts/validate-metadata.sh"
tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/mediluna-metadata.XXXXXX")
trap 'rm -rf "$tmp_dir"' EXIT

mkdir -p "$tmp_dir/root/art" "$tmp_dir/root/content/art-archive.assets"
cp "$repo_root/art/mascot.png" "$tmp_dir/root/art/mascot.png"
cp "$repo_root/content/art-archive.assets/mascot.png" "$tmp_dir/root/content/art-archive.assets/mascot.png"

jq '{
  schema_version,
  inspected_at,
  inspection_tool,
  privacy,
  assets: [.assets[0]],
  page_local_copies: [.page_local_copies[0]]
}' "$repo_root/metadata/assets.json" > "$tmp_dir/root/assets-valid.json"

"$validator" "$tmp_dir/root" "$tmp_dir/root/assets-valid.json" >/dev/null

jq '.assets[0].source_provenance = "GPS: 51.5,-0.1"' "$tmp_dir/root/assets-valid.json" > "$tmp_dir/assets-private.json"
if "$validator" "$tmp_dir/root" "$tmp_dir/assets-private.json" >/dev/null 2>&1; then
  echo "privacy fixture unexpectedly passed" >&2
  exit 1
fi

printf 'drift\n' > "$tmp_dir/root/content/art-archive.assets/mascot.png"
if "$validator" "$tmp_dir/root" "$tmp_dir/root/assets-valid.json" >/dev/null 2>&1; then
  echo "drift fixture unexpectedly passed" >&2
  exit 1
fi

echo "Metadata fixtures passed: valid record, sensitive field rejection, and copy-drift rejection."
