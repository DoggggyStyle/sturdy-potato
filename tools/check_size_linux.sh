#!/usr/bin/env bash
TARGET_GB=20
BUILD_DIR="Build/Linux"
BYTES=$(du -sb "$BUILD_DIR" | awk '{print $1}')
MB=$(( BYTES / 1024 / 1024 ))
echo "Build size: ${MB} MB"
if [ $MB -gt $((TARGET_GB*1000)) ]; then
  echo "[WARN] Build exceeds ${TARGET_GB}GB target!"
else
  echo "[OK] Within target."
fi
