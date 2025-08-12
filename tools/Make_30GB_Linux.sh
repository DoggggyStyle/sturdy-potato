#!/usr/bin/env bash
set -euo pipefail

TARGET_BASE_GB=${TARGET_BASE_GB:-24}
TARGET_HD_GB=${TARGET_HD_GB:-5}
GODOT=${GODOT:-godot4}
PROJ="project"

BASE_DIR="$PROJ/content_fill/base"
HD_DIR="$PROJ/content_fill/hd"
mkdir -p "$BASE_DIR" "$HD_DIR"

echo "[1/4] Creating base filler (~${TARGET_BASE_GB}GB)"
for ((i=1;i<=TARGET_BASE_GB;i++)); do
  fallocate -l 1G "$BASE_DIR/chunk_${i}.bin"
  echo "  Created base chunk $i / $TARGET_BASE_GB"
done

echo "[2/4] Creating HD pack filler (~${TARGET_HD_GB}GB)"
for ((i=1;i<=TARGET_HD_GB;i++)); do
  fallocate -l 1G "$HD_DIR/hd_chunk_${i}.bin"
  echo "  Created HD chunk $i / $TARGET_HD_GB"
done

echo "[3/4] Exporting Linux/X11 build"
$GODOT --headless --path "$PROJ" --export-release "Linux/X11" "../Build/Linux/UltimateHacker.x86_64"

echo "[4/4] Exporting HD pack .pck"
$GODOT --headless --path "$PROJ" --export-pack "Windows PCK" "../Build/Linux/hd_textures.pck"
chmod +x ../Build/Linux/UltimateHacker.x86_64 || true
echo "Done. Outputs in Build/Linux"
