# Mediluna Metadata Vocabulary

This vocabulary is a small archival layer for public, project-relevant asset metadata. It is designed to stay useful if the site later grows a Boris metadata lab, without making Mediluna depend on Boris for the experiment.

## Public fields

- **`path`** — Repository-relative asset path.
- **`title`** — Human-readable archival title, not necessarily the filename.
- **`creator`** — Named creator only when the repository records one. Otherwise use an explicit unknown/not-recorded value.
- **`date_or_era`** — Exact date only when documented. Otherwise preserve uncertainty with an era such as “undated; initial 2026 repository asset set.”
- **`medium`** — Plain-language type such as digital illustration, portrait, sticker, logo, or wallpaper.
- **`dimensions`** — Pixel dimensions verified from the image file.
- **`color_profile`** — Public color-space/profile fact. Say when an embedded profile is absent rather than guessing one.
- **`source_provenance`** — Repository path plus a public prompt, brief, commit, or source note when one exists.
- **`license_usage_note`** — Honest usage guidance; do not imply an open license that has not been granted.
- **`related_project`** — The project or ecosystem context.
- **`related_character`** — The character, mascot, or subject represented.
- **`source_sha256`** — Lowercase SHA-256 of the tracked source asset, used to detect metadata drift.

## Privacy rules

1. Inspect originals read-only before writing a sidecar.
2. Never publish GPS coordinates, device serial numbers, camera make/model, private filesystem paths, or personal identifiers without explicit approval.
3. Preserve original binaries. Sidecars are the editable metadata layer.
4. Do not turn an absent field into a claim. Use “not recorded,” “undated,” or “not embedded.”
5. Keep provenance public and reproducible: repository paths and checked-in prompt/history notes are preferred.

## Enforcement

`scripts/validate-metadata.sh` is the executable contract for this sidecar. It
requires the exact published-field allowlist above (including `path` and
`source_sha256`), rejects unknown or sensitive fields, requires every source
asset to exist and match its declared SHA-256, and checks every declared
page-local copy with both `cmp` and a SHA-256 comparison. Absolute paths,
symlinks, traversal segments, and control characters are rejected.

`scripts/test-metadata.sh` exercises a valid record plus rejected sensitive-field
and page-local-drift fixtures. The normal build and CI check run both scripts;
ExifTool remains an inspection aid and is not required at build time.

## Sidecar convention

The canonical sidecar is `metadata/assets.json` (schema version `1.1`). New assets should append a record using exactly the fields above, keep JSON formatting deterministic, and include the inspection date and tool version when a metadata inspection materially informs the record. The `page_local_copies` list records temporary page-local mirrors and their source hashes so they cannot silently drift.

## Boris dogfood note

Boris currently requires Markdown image assets to live under a page-local `<page>.assets/` directory and rejects both root-relative paths and symlinks. The archive demo therefore keeps exact byte-for-byte copies of two canonical images in `content/art-archive.assets/` for compilation. The originals remain authoritative; the copies are a temporary, documented fixture for this experiment and should be replaced by Boris asset references or a metadata-aware asset mount when available.
