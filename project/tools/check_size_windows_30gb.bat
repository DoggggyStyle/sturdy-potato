@echo off
set TARGET_GB=30
set BUILD_DIR=Build\Windows
for /f "tokens=3" %%a in ('dir /s /-c "%BUILD_DIR%" ^| find "File(s)"') do set BYTES=%%a
set /a MB=%BYTES%/1024/1024
echo Build size: %MB% MB
if %MB% GTR %TARGET_GB%000 (
  echo [WARN] Build exceeds %TARGET_GB%GB target!
) else (
  echo [OK] Within target.
)
pause
