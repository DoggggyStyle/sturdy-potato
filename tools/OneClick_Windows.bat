@echo off
title Ultimate Hacker — One‑Click Builder (Windows)
setlocal enabledelayedexpansion

REM ----- Step 0: Find Godot -----
set GODOT=godot4
where %GODOT% >nul 2>nul
if errorlevel 1 (
  echo [Info] 未在 PATH 找到 godot4，尝试使用 "godot"...
  set GODOT=godot
  where %GODOT% >nul 2>nul
)
if errorlevel 1 (
  echo [提示] 没找到 Godot 命令。你可以：
  echo  1) 安装 Godot 4，并把 godot.exe 加到 PATH；或
  echo  2) 将 Godot 可执行文件拖到此窗口后回车：
  set /p GODOT=Godot 路径： 
)

echo 使用 Godot: %GODOT%

REM ----- Step 1: 清理缓存，确保干净启动 -----
echo [1/6] 清理 .godot 缓存...
rmdir /s /q project\.godot 2>nul

REM ----- Step 2: 运行 10 次无头 CI（Balanced 档），严格阈值 -----
echo [2/6] 运行 10 次 CI（每次30s，Balanced，阈值 AVG>=55 / 1%%Low>=40）...
for /L %%i in (1,1,10) do (
  echo   Loop %%i / 10
  %GODOT% --headless --path project -- --ci --loop 1 --seconds 30 --profile Balanced --out "user://ci" --strict true
  if errorlevel 1 (
    echo [失败] 第 %%i 次不达标（或外部错误）。为保证稳定性，流程已停止。
    echo 详见：C:\Users\%%USERNAME%%\AppData\Roaming\Godot\app_userdata\Ultimate Hacker*\ci\summary.json
    pause
    exit /b 1
  )
)

REM ----- Step 3: 导出 Windows 可执行版 -----
echo [3/6] 导出 Windows 可执行版...
tools\Export_Windows.bat
if errorlevel 1 (
  echo [失败] 导出可执行文件失败。
  pause
  exit /b 1
)

REM ----- Step 4: 生成 30GB 占位内容并导出 HD 包 -----
echo [4/6] 生成 30GB 体积（基础24GB + HD 5GB）并导出 HD 包...
tools\Make_30GB_Windows.bat
if errorlevel 1 (
  echo [失败] 30GB 构建失败。
  pause
  exit /b 1
)

REM ----- Step 5: 确保高清包在可执行目录，便于启用 -----
echo [5/6] 放置 hd_textures.pck 到可执行目录...
copy /Y Build\Windows\hd_textures.pck Build\Windows\  >nul

REM ----- Step 6: 启动游戏（基础包，若同目录有 hd_textures.pck 则会自动挂载） -----
echo [6/6] 启动游戏...
start "" Build\Windows\UltimateHacker.exe

echo 完成。若要再次运行，请直接双击 Build\Windows\UltimateHacker.exe
pause
