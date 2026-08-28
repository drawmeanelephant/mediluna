# Mascot Neighborhood

This directory is the shared archive for all project mascots under the drawmeanelephant umbrella. Each project gets its own subdirectory; shared scenes and crossover artwork live in `shared/`.

---

## Project → Mascot Map

| Project | Mascot(s) | Species | Directory |
| --- | --- | --- | --- |
| **Boris** | Mediluna | Sea otter | `../art/`, `../avatars/`, `../stickers/`, `../wallpapers/`, `../logos/` |
| **Oliver** | Oliver | Weimaraner dog | `oliver/` |
| **Rotkeeper** | Patch · Shikabane | Panda · Zombie | `rotkeeper/` |

---

## Character Profiles

### 🦦 Mediluna — *the journey companion*
**Project:** Boris static site compiler
**Role:** Traveling companion. If Boris is the builder, Mediluna is the journey.
**Traits:** Endlessly optimistic, snack-oriented, happiest outside, always prepared for adventure.
**Visual signature:** Red bandana, small hiking backpack, warm smile.
**Canon:** Wears a red bandana. Carries a little backpack. Likes hiking. Likes fish. Accidentally consumes AI credits. Believes every journey deserves a snack.
**Archive:** Main Mediluna artwork lives in `../art/`, `../avatars/`, `../stickers/`, `../wallpapers/`, and `../logos/`. Imported Build Week imagery is at `../art/buildweek-2026/`.

### 🐕 Oliver — *the good boy*
**Project:** Oliver
**Role:** Friendly, action-oriented mascot. A Weimaraner with an orange tag and a confident wag.
**Traits:** Warm, direct, confident, never noisy. Best friend energy. Likes backpacks, bandanas, baseball caps, superhero capes, and laptops.
**Visual signature:** Orange collar tag (`#E44D26`), warm grey coat, rounded soft forms, tail-swish ribbon motif.
**Brand system:** Full colour palette (Oliver Orange, Charcoal, Warm Grey, Medium Taupe, Off-White), typography (Poppins + Inter), graphical equity system (portrait crop, orange tag, tail-swish ribbon, soft biomorphic shapes, warm porthole).
**Archive:** `oliver/` — named expression/pose illustrations, turnaround sheets, accessory variants, social templates, concept board, website hero graphic, colour palette guide, and graphical equity guide.

### 🐼 Patch — *the panda*
**Project:** Rotkeeper
**Role:** One of two Rotkeeper mascots. Appears alongside Oliver in shared camping/crossover scenes.
**Traits:** TBD — character profile to be fleshed out.
**Archive:** Appears in `shared/Panda_and_dog_camping_*.jpeg` crossover scenes.

### 🧟 Shikabane — *the zombie*
**Project:** Rotkeeper
**Role:** The primary Rotkeeper mascot. Scene illustrations show Shikabane in atmospheric, story-driven settings.
**Traits:** TBD — character profile to be fleshed out.
**Archive:** `rotkeeper/` — four scene illustrations (moonlit library, garden caretaker, potion workshop, campfire story) plus a splash portrait.

---

## Shared & Crossover Artwork

The `shared/` directory holds illustrations that feature multiple characters or don't yet belong to a single project:

- `Panda_and_dog_camping_202608281122.jpeg` — Patch and Oliver camping (1376 × 768)
- `Panda_and_dog_camping_2K_202608281131.jpeg` — Patch and Oliver camping, higher res (1792 × 2390)
- `Character_sitting_on_vintage_com…_202608251150.jpeg` — Character study (1792 × 2400)
- `Character_standing_in_3D_world_202608251150.jpeg` — Character study (1792 × 2400)
- `canonical-base.png` — Canonical character base reference (1199 × 1312)
- `871AEC3E-D81C-47C5-85B2-AE1804412AF2.png` — UUID asset, context TBD (1536 × 1024)
- `e8029cc1-478b-4098-9bbd-5da87965394d.png` — UUID asset, context TBD (1254 × 1254)

---

## Poster Artwork

The `posters/` directory holds scientific figure poster illustrations:

- `poster_anscombe.png` — Elizabeth Anscombe (896 × 1200)
- `poster_curie.png` — Marie Curie (896 × 1200)
- `poster_galileo.png` — Galileo Galilei (896 × 1200)
- `poster_tesla.png` — Nikola Tesla (896 × 1200)
- `poster_turing.png` — Alan Turing (896 × 1200)
- `poster_variation_[1-4]_*.jpg` — Poster layout variations (848 × 1264 each)

---

## Oliver Asset Inventory

The `oliver/` directory contains a production-ready mascot asset library:

**Expressions & Poses:**
`oliver_happy.png`, `oliver_sitting.png`, `oliver_standing.png`, `oliver_running.png`, `oliver_walking.png`, `oliver_looking_up.png`, `oliver_play_bow.png`, `oliver_expression_winking.png`

**Turnaround Sheets:**
`oliver_turnaround_front.png`, `oliver_turnaround_back.png`, `oliver_turnaround_side.png`, `oliver_turnaround_three_quarter.png`

**Accessory Variants:**
`oliver_backpack.png`, `oliver_bandana.png`, `oliver_baseball_cap.png`, `oliver_superhero_cape.png`, `oliver_laptop.png`

**Templates & Brand:**
`oliver_social_feed_template.png` (1632 × 2176), `oliver_social_story_template.png` (1440 × 2560), `oliver_digital_equity_concept_board.png` (2560 × 1440), `oliver_website_hero_graphic.png` (2560 × 1440)

**Exploration Drafts:**
16 UUID-named PNGs from early generation passes

**Guides:**
`Oliver the Good Boy — Colour Palette & Typography Guide.md`, `Oliver_Graphical_Equity_Guide.md`

---

## Rotkeeper Asset Inventory

The `rotkeeper/` directory contains Shikabane scene illustrations:

- `01_moonlit_library_rotkeeper.png` — Moonlit library scene (1632 × 2176, RGBA)
- `02_garden_caretaker_rotkeeper.png` — Garden caretaker scene (1632 × 2176, RGBA)
- `03_potion_workshop_rotkeeper.png` — Potion workshop scene (1632 × 2176, RGBA)
- `04_campfire_story_rotkeeper.png` — Campfire story scene (1632 × 2176, RGBA)
- `rotkeeper-splash.png` — Splash portrait (1024 × 1536)

---

## Adding New Mascots

When a new project gets a mascot:

1. Create a subdirectory under `mascots/` named for the project.
2. Drop the artwork in, with clear filenames (not UUIDs when avoidable).
3. Add a profile to this README.
4. Add a character section to `CVI.md`.
5. Add asset records to `metadata/assets.json` with source provenance and SHA-256.
6. If the mascot appears in shared/crossover scenes, add those to `shared/`.

---

## Provenance & Licensing

All artwork is © its respective creators unless otherwise noted. Repository license is still evolving; request permission before treating any asset as open-licensed. Imported and inbox assets retain their original context; source URLs and SHA-256 hashes are recorded in `metadata/assets.json`.
