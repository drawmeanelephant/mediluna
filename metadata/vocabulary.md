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

## Privacy rules

1. Inspect originals read-only before writing a sidecar.
2. Never publish GPS coordinates, device serial numbers, camera make/model, private filesystem paths, or personal identifiers without explicit approval.
3. Preserve original binaries. Sidecars are the editable metadata layer.
4. Do not turn an absent field into a claim. Use “not recorded,” “undated,” or “not embedded.”
5. Keep provenance public and reproducible: repository paths and checked-in prompt/history notes are preferred.

## Sidecar convention

The canonical sidecar is `metadata/assets.json`. New assets should append a record using the fields above, keep JSON formatting deterministic, and include the inspection date and tool version when a metadata inspection materially informs the record.

## Boris dogfood note

Boris currently requires Markdown image assets to live under a page-local `<page>.assets/` directory and rejects both root-relative paths and symlinks. The archive demo therefore keeps exact byte-for-byte copies of two canonical images in `content/art-archive.assets/` for compilation. The originals remain authoritative; the copies are a temporary, documented fixture for this experiment and should be replaced by Boris asset references or a metadata-aware asset mount when available.
