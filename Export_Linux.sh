#!/usr/bin/env bash
set -e
GODOT=tools/godot4
if [ ! -x "$GODOT" ]; then
  echo "[ERROR] 请将 Godot 4 可执行文件放在 tools/ 并命名为 godot4（chmod +x）。"
  exit 1
fi
echo "[INFO] 导出 Linux 版本..."
"$GODOT" --headless --path project --export-release "Linux/X11" Build/Linux/InvisibleHacker.x86_64
echo "[OK] 导出完成：Build/Linux/InvisibleHacker.x86_64"
echo "运行：./Build/Linux/InvisibleHacker.x86_64"
