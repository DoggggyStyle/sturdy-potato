#!/usr/bin/env bash
set -e

GODOT=${GODOT:-godot4}

echo "[1/8] 清理缓存 .godot ..."
rm -rf project/.godot || true

echo "[2/8] 静态检查（50+项）..."
$GODOT --headless --path project -- --static-checks

echo "[3/8] 性能自检 10 次（AVG>=55, 1%%Low>=40）..."
for i in {1..10}; do
  echo "  CI Loop $i / 10"
  $GODOT --headless --path project -- --ci --loop 1 --seconds 30 --profile Balanced --out "user://ci" --strict true
done

echo "[4/8] 导出 Linux 构建..."
./tools/Export_Linux.sh

echo "[5/8] 构建 30GB 体积..."
./tools/Make_30GB_Linux.sh

echo "[6/8] 体积校验（>=29GB）..."
SIZE=$(du -sb Build/Linux | awk '{print $1}')
if [ "$SIZE" -lt "31138512896" ]; then
  echo "[失败] 体积不足 29GB。"
  exit 1
fi

echo "[7/8] 放置 hd_textures.pck"
cp -f Build/Linux/hd_textures.pck Build/Linux/ || true
chmod +x Build/Linux/UltimateHacker.x86_64 || true

echo "[8/8] 启动游戏..."
./Build/Linux/UltimateHacker.x86_64 &
echo "完成。"
