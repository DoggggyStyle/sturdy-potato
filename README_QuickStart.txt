Ultimate Hacker — v2.3.6 Full Consolidated Final

你要的“全部整合版”，已包含：
- 干净目录结构（无 project/ 套 project/）
- 去除自定义主题引用
- 强类型 CI 采样脚本（PerfProbeLite.gd）
- 安全的 PostFX 管理桩（避免空路径报错）
- 最小自动加载（仅 GraphicsManager、HDManager）
- 完整 tools 脚本（Make_30GB、Export_*）
- 干净导出预设（Windows + Linux）

使用：
1) 解压本包到普通路径（尽量避免中文符号）。
2) 打开 Godot → 导入 project/project.godot → ▶ 运行。
3) 生成 ≈30GB 版本：
   - Windows：双击 tools\Make_30GB_Windows.bat
   - Linux：   运行 tools/Make_30GB_Linux.sh
4) 如遇旧缓存导致异常：关闭 Godot，删除工程目录下“.godot/”后重开。

导出：Project → Export（已内置 Windows/Linux 预设）。
