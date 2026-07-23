#!/usr/bin/env bash
set -euo pipefail

repo_root=${1:-$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)}
metadata_file=${2:-"$repo_root/metadata/assets.json"}

die() {
  echo "metadata validation failed: $*" >&2
  exit 1
}

[ -f "$metadata_file" ] || die "missing metadata sidecar: ${metadata_file#"$repo_root/"}"
command -v jq >/dev/null 2>&1 || die "jq is required to validate metadata/assets.json"

asset_fields='["color_profile","creator","date_or_era","dimensions","license_usage_note","medium","path","related_character","related_project","source_provenance","source_sha256","title"]'
copy_fields='["page_local_path","sha256","source_path"]'

jq -e --argjson asset_fields "$asset_fields" --argjson copy_fields "$copy_fields" '
  def keyset($keys): (keys | sort) == $keys;
  def sha256: type == "string" and test("^[0-9a-f]{64}$");
  def safe_relative_path:
    type == "string" and length > 0 and
    (startswith("/") | not) and
    (test("(^|/)\\.\\.?(/|$)") | not) and
    (test("[[:cntrl:]]") | not) and
    (contains("\\") | not);
  def sensitive_key:
    type == "string" and test("(?i)(gps|latitude|longitude|serial|device.?id|camera.?make|camera.?model|private.?path|absolute.?path|email|phone)");
  def sensitive_value:
    type == "string" and test("(?i)(gps|latitude|longitude|serial[ _-]?number|device[ _-]?id|camera[ _-]?(make|model)|private[ _-]?filesystem|absolute[ _-]?path)");
  def absolute_path:
    type == "string" and test("(^|[[:space:]])/(Users|home|private|tmp|var)(/|[[:space:]]|$)");
  def asset_leaves:
    [.assets[] as $asset | ($asset | paths(scalars)) as $path |
      {key: ($path | last), value: ($asset | getpath($path))}];
  . as $root |
  (type == "object") and
  (keyset(["assets","inspected_at","inspection_tool","page_local_copies","privacy","schema_version"])) and
  (.schema_version == "1.1") and
  (.inspected_at | type == "string" and test("^[0-9]{4}-[0-9]{2}-[0-9]{2}$")) and
  (.inspection_tool | type == "string" and length > 0) and
  (.privacy | type == "object" and keyset(["excluded_fields","published_fields","rule"])) and
  (.privacy.published_fields == ["path","title","creator","date_or_era","medium","dimensions","color_profile","source_provenance","license_usage_note","related_project","related_character","source_sha256"]) and
  (.privacy.excluded_fields | type == "array" and length > 0 and all(.[]; type == "string" and length > 0)) and
  (.privacy.rule | type == "string" and length > 0) and
  (.assets | type == "array" and length > 0 and (map(.path) | length == (unique | length))) and
  (all(.assets[]; keyset($asset_fields) and
    (.path | safe_relative_path) and
    (.source_sha256 | sha256) and
    (all(.[]; type == "string" and length > 0)))) and
  (.page_local_copies | type == "array" and length > 0 and
    all(.[]; keyset($copy_fields) and
      (.source_path | safe_relative_path) and
      (.page_local_path | safe_relative_path) and
      (.sha256 | sha256))) and
  (all(.page_local_copies[]; .source_path as $source | any($root.assets[]; .path == $source))) and
  (asset_leaves | all(.[]; ((.key | sensitive_key) | not) and ((.value | absolute_path) | not) and ((.value | sensitive_value) | not)))
' "$metadata_file" >/dev/null || die "schema, allowlist, or privacy policy violation"

sha256_for() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  elif command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    die "neither shasum nor sha256sum is available"
  fi
}

while IFS=$'\t' read -r source_path declared_hash; do
  source_file="$repo_root/$source_path"
  [ -f "$source_file" ] || die "metadata source does not exist: $source_path"
  [ ! -L "$source_file" ] || die "metadata source must not be a symlink: $source_path"
  actual_hash=$(sha256_for "$source_file")
  [ "$actual_hash" = "$declared_hash" ] || die "source hash mismatch: $source_path"
done < <(jq -r '.assets[] | [.path, .source_sha256] | @tsv' "$metadata_file")

while IFS=$'\t' read -r source_path page_local_path declared_hash; do
  source_file="$repo_root/$source_path"
  page_local_file="$repo_root/$page_local_path"
  [ -f "$page_local_file" ] || die "page-local copy does not exist: $page_local_path"
  [ ! -L "$page_local_file" ] || die "page-local copy must not be a symlink: $page_local_path"
  cmp -s "$source_file" "$page_local_file" || die "page-local copy drift: $page_local_path"
  actual_hash=$(sha256_for "$page_local_file")
  [ "$actual_hash" = "$declared_hash" ] || die "page-local copy hash mismatch: $page_local_path"
done < <(jq -r '.page_local_copies[] | [.source_path, .page_local_path, .sha256] | @tsv' "$metadata_file")

echo "Metadata checks passed: schema, privacy allowlist, source hashes, and page-local copies."
