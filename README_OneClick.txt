Ultimate Hacker — v2.1 One‑Click Final

双击：
- Windows：`tools/OneClick_Windows.bat`
- Linux：`tools/OneClick_Linux.sh`

它会自动完成：
1) 清理缓存 → 2) 10次无头CI（阈值：平均≥55 FPS、1% Low≥40）→ 3) 导出可执行 → 4) 构建30GB体积（基础24GB+HD5GB）→ 5) 放置高清包 → 6) 自动启动游戏。

CI 日志与总结：
- Windows：`C:\Users\你的用户名\AppData\Roaming\Godot\app_userdata\Ultimate Hacker*/ci/summary.json`
- Linux：`~/.local/share/godot/app_userdata/Ultimate Hacker*/ci/summary.json`

HD 包开关：
- 运行目录放置 `hd_textures.pck` 即可；
- 场景内可实例化 `scenes/ui/HDTogglePanel.tscn` 或通过 `HDManager.set_hd(true/false)` 实时切换。

若脚本找不到 `godot4`：
- 直接把 Godot 可执行文件拖进黑色命令窗口回车即可，脚本会记住一次。
