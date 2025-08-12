@echo off
title Ultimate Hacker — Release Candidate (Windows) One‑Click
setlocal enabledelayedexpansion

REM ===== 0) Locate Godot =====
set GODOT=godot4
where %GODOT% >nul 2>nul
if errorlevel 1 (
  echo 未找到 "godot4"。请将 Godot 可执行文件拖入此窗口：
  set /p GODOT=Godot 路径： 
)

echo 使用 Godot: %GODOT%

REM ===== 1) Clean cache =====
echo [1/8] 清理缓存 .godot ...
rmdir /s /q project\.godot 2>nul

REM ===== 2) Static checks (50+ items) =====
echo [2/8] 静态检查（50+项）...
%GODOT% --headless --path project -- --static-checks
if errorlevel 1 (
  echo [失败] 静态检查未通过。详见 app_userdata\\Ultimate Hacker*\\ci\\static_checks.json
  pause
  exit /b 1
)

REM ===== 3) CI 10x perf (strict) =====
echo [3/8] 性能自检 10 次（阈值：AVG>=55, 1%%Low>=40）...
for /L %%i in (1,1,10) do (
  echo   CI Loop %%i / 10
  %GODOT% --headless --path project -- --ci --loop 1 --seconds 30 --profile Balanced --out "user://ci" --strict true
  if errorlevel 1 (
    echo [失败] 第 %%i 次未达标。
    pause
    exit /b 1
  )
)

REM ===== 4) Export Windows build =====
echo [4/8] 导出 Windows 构建...
tools\\Export_Windows.bat || ( echo 导出失败 & pause & exit /b 1 )

REM ===== 5) Build 30GB (base+HD) =====
echo [5/8] 构建 30GB 体积（基础24GB+HD5GB）...
tools\\Make_30GB_Windows.bat || ( echo 30GB 构建失败 & pause & exit /b 1 )

REM ===== 6) Size gate: ensure >=29GB total =====
echo [6/8] 体积校验（目标 >= 29GB）...
powershell -NoProfile -Command "$s=(Get-ChildItem -Recurse 'Build\\Windows' | Measure-Object -Sum Length).Sum; if($s -lt 31138512896){ exit 1 } else { exit 0 }"
if errorlevel 1 (
  echo [失败] 体积不足 29GB。请检查磁盘空间或占位文件生成。
  pause
  exit /b 1
)

REM ===== 7) Copy hd pack to exe dir =====
copy /Y Build\\Windows\\hd_textures.pck Build\\Windows\\ >nul

REM ===== 8) Launch =====
echo [8/8] 启动游戏...
start "" Build\\Windows\\UltimateHacker.exe
echo 完成。
pause
