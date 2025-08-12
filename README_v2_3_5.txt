Ultimate Hacker — v2.3.5 Consolidated (No Plugin, Clean Structure)

这版做了：
- 修正目录结构（不再有 project/ 里套 project/）
- 移除项目设置中的 GUI 自定义主题引用
- 补齐 CI/PerfProbeLite 类型（随 v2.3.3 小修一起集成）
- 提供干净的导出预设（Windows + Linux，含 [preset.X.options] 段）
- 保留 tools 下的一键 30GB 构建脚本

使用：
1) 解压本包到普通路径（避免中文和符号）。
2) 打开 Godot → 导入 project/project.godot；若项目管理器里有旧条目“Project is missing…”，删掉它们避免误点。
3) 运行 ▶ 测试。
4) 需要 30GB：
   - Windows：tools\Make_30GB_Windows.bat
   - Linux：tools/Make_30GB_Linux.sh
5) 若遇缓存导致的旧错误，关闭 Godot，删除工程根目录的“.godot/”后再开。

如果要编辑器内“一键 Finalize”面板，我可以在这个整包基础上再加（已修好的）插件版。
