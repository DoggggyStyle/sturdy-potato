Ultimate Hacker — v2.2 SteamReady + ReleaseCandidate Gate

一键 RC（推荐）：
- Windows：tools/OneClick_RC_Windows.bat
- Linux：tools/OneClick_RC_Linux.sh

流程：清缓存 → 50+静态检查 → 10次无头性能测试（AVG≥55, 1%Low≥40 不达标即停止）→ 导出可执行 → 构建30GB（基础24GB+HD5GB）→ 体积校验（≥29GB）→ 启动游戏。

Steam 发布：
- 编辑 steam_release_kit/*.vdf 替换你的 AppID/DepotID
- Windows 可用 tools/Steam_Upload_Windows.bat（需安装 steamcmd）

CI/日志：
- 结果保存于 Godot app_userdata 的 /ci/ 目录（summary.json、static_checks.json）
- 若静态检查失败或性能不达标，脚本会停止并提示文件位置。

这就是“无脑化”的发布门槛：所有步骤自动化、可重复、可追踪。
