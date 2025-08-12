# 《隐形骇客》PlayNow 一键导出包

这个包包含“**一键导出脚本**”，帮你把我给你的 Godot 工程导出成可直接运行的可执行文件。

## 你需要准备什么
1. 安装 **Godot 4.x**（官方稳定版）。
2. 把之前给你的三个包全部解压合并到同一个工程目录：
   - NeonNomads_Godot_Starter.zip
   - InvisibleHacker_OpenWorld_Plus.zip
   - InvisibleHacker_Beautify_Pack.zip

> 工程顶层应该有 `project/project.godot`。

## 一键导出（Windows）
1. 将 Godot 编辑器可执行文件（例如 `Godot_v4.x-stable_win64.exe`）
   复制或移动到本目录的 `tools/` 里，重命名为 **godot4.exe**。
2. 双击 `Export_Windows.bat`。
3. 成功后，会在 `Build/Windows/` 生成 `InvisibleHacker.exe`，双击即可游玩。

## 一键导出（Linux/macOS）
1. 将 Godot 4 可执行文件（例如 `godot4` 或 `Godot_v4.x-stable_linux.x86_64`）
   复制到 `tools/` 里，重命名为 **godot4** 并确保可执行（`chmod +x tools/godot4`）。
2. 在工程根目录执行：
   ```bash
   bash Export_Linux.sh
   ```
3. 成功后，会在 `Build/Linux/` 生成 `InvisibleHacker.x86_64`（Linux），可直接运行。

## 备注
- 如果导出时提示缺少模板，请在 Godot 中打开 `Project > Export`，按照提示安装 Export Templates（官方一键安装）。
- 脚本会默认使用工程目录下的 `project/export_presets.cfg`（我已为你准备）。
- 第一次运行后会生成 `Saves/`。我附带了 `Saves/demo_save.json`，你可以直接加载体验。

祝游玩愉快！
