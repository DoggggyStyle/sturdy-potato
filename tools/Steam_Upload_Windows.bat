@echo off
SET STEAMCMD=steamcmd
SET APPID=YOUR_APP_ID
SET BUILD_VDF=steam_release_kit\app_build_windows.vdf
echo 请输入你的 Steam 登录名（不会保存密码，这里只做示例）：
set /p USER=Steam 用户名: 
%STEAMCMD% +login %USER% +run_app_build "%BUILD_VDF%" +quit
pause
