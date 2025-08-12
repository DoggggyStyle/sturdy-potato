#!/usr/bin/env bash
set -e

GODOT=${GODOT:-godot4}

echo "[1/6] 清理 .godot 缓存..."
rm -rf project/.godot || true

echo "[2/6] CI 10次（30s each, Balanced, strict）..."
for i in {1..10}; do
  echo "  Loop $i / 10"
  $GODOT --headless --path project -- --ci --loop 1 --seconds 30 --profile Balanced --out "user://ci" --strict true
done

echo "[3/6] 导出 Linux 可执行版..."
./tools/Export_Linux.sh

echo "[4/6] 生成 30GB 体积并导出 HD 包..."
./tools/Make_30GB_Linux.sh

echo "[5/6] 将 hd_textures.pck 放到可执行目录..."
cp -f Build/Linux/hd_textures.pck Build/Linux/ || true
chmod +x Build/Linux/UltimateHacker.x86_64 || true

echo "[6/6] 启动游戏..."
./Build/Linux/UltimateHacker.x86_64 &

echo "完成。"
