@echo off
SET GODOT=godot4
SET PROJ=project
SET LOGDIR=Build\logs
mkdir "%LOGDIR%" 2>nul

echo Running 10x headless QA/perf loops (30s each) on Balanced...
for /L %%i in (1,1,10) do (
  echo Loop %%i...
  %GODOT% --headless --path "%PROJ%" -- --ci --loop 1 --seconds 30 --profile Balanced --out "user://ci"
)

echo Now export Windows build...
tools\Export_Windows.bat
echo Done. Check Build\Windows and Build\logs
pause
