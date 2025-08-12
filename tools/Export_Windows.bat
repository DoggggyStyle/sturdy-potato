@echo off
SET GODOT=godot4
SET PROJ=project
echo Exporting Windows Desktop...
%GODOT% --headless --path "%PROJ%" --export-release "Windows Desktop" "../Build/Windows/UltimateHacker.exe"
if %ERRORLEVEL% NEQ 0 ( echo Export failed & exit /b 1 )
echo Done. Output at Build\Windows\UltimateHacker.exe
pause
