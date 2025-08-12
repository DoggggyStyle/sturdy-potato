#!/usr/bin/env bash
set -e
GODOT=${GODOT:-godot4}
PROJ="project"
echo "Exporting Linux/X11..."
$GODOT --headless --path "$PROJ" --export-release "Linux/X11" "../Build/Linux/UltimateHacker.x86_64"
echo "Done. Output at Build/Linux/UltimateHacker.x86_64"
chmod +x ../Build/Linux/UltimateHacker.x86_64 || true
