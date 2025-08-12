@echo off
setlocal enabledelayedexpansion
REM === Settings ===
set TARGET_BASE_GB=24
set TARGET_HD_GB=5
set GODOT=godot4
set PROJ=project

echo [1/4] Creating filler files to reach ~%TARGET_BASE_GB%GB base content...
set BASE_DIR=%PROJ%\content_fill\base
set HD_DIR=%PROJ%\content_fill\hd
mkdir "%BASE_DIR%" 2>nul
mkdir "%HD_DIR%" 2>nul

REM Create ~1GB chunks quickly (zero-filled). Uses fsutil (Windows).
for /L %%i in (1,1,%TARGET_BASE_GB%) do (
  fsutil file createnew "%BASE_DIR%\chunk_%%i.bin" 1073741824 >nul
  echo  Created base chunk %%i/ %TARGET_BASE_GB% (1GB)
)

echo [2/4] Creating ~%TARGET_HD_GB%GB optional HD pack...
for /L %%i in (1,1,%TARGET_HD_GB%) do (
  fsutil file createnew "%HD_DIR%\hd_chunk_%%i.bin" 1073741824 >nul
  echo  Created HD chunk %%i/ %TARGET_HD_GB% (1GB)
)

echo [3/4] Exporting Base executables...
%GODOT% --headless --path "%PROJ%" --export-release "Windows Desktop" "../Build/Windows/UltimateHacker.exe"
if %ERRORLEVEL% NEQ 0 ( echo Export failed & exit /b 1 )

echo [4/4] Exporting HD pack as .pck...
%GODOT% --headless --path "%PROJ%" --export-pack "Windows PCK" "../Build/Windows/hd_textures.pck"
echo Done. Outputs in Build\Windows\
echo (Base EXE embeds PCK; HD optional pack is hd_textures.pck)
pause
