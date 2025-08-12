#!/usr/bin/env bash
set -e
GODOT=${GODOT:-godot4}
PROJ="project"
LOGDIR="Build/logs"
mkdir -p "$LOGDIR"

echo "Running 10x headless QA/perf loops (30s each) on Balanced..."
for i in {1..10}; do
  echo "Loop $i..."
  $GODOT --headless --path "$PROJ" -- --ci --loop 1 --seconds 30 --profile Balanced --out "user://ci"
done

echo "Exporting Linux build..."
./tools/Export_Linux.sh
echo "Done. See Build/Linux and Build/logs"
