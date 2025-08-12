#!/usr/bin/env bash
set -e
echo "=== UltimateHacker quick check ==="

if [ ! -f project/project.godot ]; then
  echo "X 缺少 project/project.godot"; exit 1
fi

need=(
  project/scenes/CityBlock.tscn
  project/scripts/camera/RTSCamera.gd
  project/scripts/player/PlayerPawn.gd
  project/scripts/systems/GraphicsManager.gd
)

miss=0
for f in "${need[@]}"; do
  if [ ! -f "$f" ]; then echo "X 缺少 $f"; miss=1; else echo "√ $f"; fi
done

echo "-- 统计"
find project -type f | wc -l | awk '{print "文件总数:",$1}'

echo "-- 简要校验"
HASHSUM=$(command -v shasum || command -v sha1sum)
$HASHSUM project/project.godot | awk '{print "project.godot:",substr($1,1,8)}' || true
for f in "${need[@]}"; do
  [ -f "$f" ] && $HASHSUM "$f" | awk -v n="$f" '{print n":",substr($1,1,8)}' || true
done

[ $miss -eq 0 ] && echo "=== 自检通过 ===" || (echo "=== 自检未通过 ==="; exit 2)
