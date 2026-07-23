#!/bin/bash
# Mediluna Build Script - Compiles the site using the 🧸 Boris binary and replicates assets.
set -e

echo "🧸 Running Boris static content compiler..."
./bin/boris

echo "🔐 Validating archival metadata..."
./scripts/validate-metadata.sh "$(pwd)"

echo "📂 Replicating brand assets and static files to dist/..."
mkdir -p dist/art dist/stickers dist/wallpapers dist/avatars dist/logos dist/metadata

# Copy assets safely (handling empty directories gracefully)
if [ -d art ] && [ "$(ls -A art)" ]; then cp -R art/* dist/art/; fi
if [ -d stickers ] && [ "$(ls -A stickers)" ]; then cp -R stickers/* dist/stickers/; fi
if [ -d wallpapers ] && [ "$(ls -A wallpapers)" ]; then cp -R wallpapers/* dist/wallpapers/; fi
if [ -d avatars ] && [ "$(ls -A avatars)" ]; then cp -R avatars/* dist/avatars/; fi
if [ -d logos ] && [ "$(ls -A logos)" ]; then cp -R logos/* dist/logos/; fi
if [ -d metadata ] && [ "$(ls -A metadata)" ]; then cp -R metadata/* dist/metadata/; fi

# Copy primary stylesheets and scripts
cp index.css dist/
cp app.js dist/

echo "✨ Build succeeded! Output is ready in the 'dist/' folder."
