Ultimate Hacker — v2.3 Godot Finalize

无需 .bat，直接在 Godot 里一键完成：静态检查 → 10次CI → 构建30GB → 导出Windows → 打开构建目录。

如何使用：
1) 打开 Godot 导入本项目。
2) Project > Project Settings > Plugins，启用 "Ultimate Finalize"。
3) 右侧会出现 Finalize 面板，按顺序点按钮执行。
   - Build 30GB：Windows 用 fsutil / Linux 用 fallocate；若不可用自动回退为慢速写入（会更久）。
   - Export Windows：用正在运行的 Godot 进程调用 headless 导出，避免路径问题。

如需 HD 材质运行：导出后确保 `hd_textures.pck` 与 EXE 同目录；或在游戏内用 HDManager 切换。
