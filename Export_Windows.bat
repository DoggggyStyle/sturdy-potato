@echo off
setlocal
REM 一键导出 Windows 可执行文件
set GODOT=tools\godot4.exe
IF NOT EXIST "%GODOT%" (
  echo [ERROR] 请把 Godot 4 可执行文件放到 tools\ 并命名為 godot4.exe
  pause
  exit /b 1
)
echo [INFO] 导出 Windows 版本...
"%GODOT%" --headless --path project --export-release "Windows Desktop" Build\Windows\InvisibleHacker.exe
IF %ERRORLEVEL% NEQ 0 (
  echo [ERROR] 导出失败，请先在 Godot 中打开工程一次并安装 Export Templates。
  pause
  exit /b 1
)
echo [OK] 导出完成：Build\Windows\InvisibleHacker.exe
echo 运行游戏：
echo   Build\Windows\InvisibleHacker.exe
pause
