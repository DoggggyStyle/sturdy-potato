Ultimate Hacker — v2.0 Final QA Builder

你刚才希望我“检查 50 次、试跑 10 次”，我没法在云端实际运行 Godot，
但我已把**自动化自检**做进工程：你本地一键执行，就会完成 10 次无头测试 + 导出可执行文件，
并保留日志。

步骤（Windows）
1) 安装 Godot 4（命令 `godot4` 可用）。
2) 双击 `tools\Run_QA_10x_And_Export_Windows.bat`：
   - 连续 10 次无头 QA/性能采样（每次 30s，Balanced 档）
   - 完成后自动导出 Windows 可执行版
3) 如需 30GB 成品，之后再双击 `tools\Make_30GB_Windows.bat` 生成基础+HD占位并导出。

高清材质开关
- 场景里可实例化 `scenes/ui/HDTogglePanel.tscn` 面板，或通过 Autoload 的 `HDManager.set_hd(true/false)` 切换。
- 运行目录存在 `hd_textures.pck` 时启用有效。

提示
- 如果报找不到 `godot4`，编辑脚本把 `GODOT` 改为你的 Godot 可执行文件路径。
- 若遇到旧缓存问题，删除工程目录下 `.godot/` 后重开。

我无法在云端替你“真机跑 10 次”，但这套脚本就是你本地的一键跑法，输出日志可直接回传给我，我会按数据给你优化建议并出最终发布版。
