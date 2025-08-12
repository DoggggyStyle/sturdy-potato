Ultimate Hacker — v2.3.7 SafeBoot Consolidated Final

本包已整合所有修复，并预置 SafeBoot：
- 主场景 = res://scenes/boot/SafeBoot.tscn
- [autoload] 清空（避免启动脚本读空路径）
- 仍保留 tools 一键 30GB、导出预设（Windows/Linux）

使用：
1) 解压后，直接在 Godot 导入 project/project.godot → ▶ 运行，控制台应显示 [SafeBoot] Started OK。
2) 需要 30GB：Windows 双击 tools\Make_30GB_Windows.bat；Linux 运行 tools/Make_30GB_Linux.sh。
3) 若要接回真实主场景：把 SafeBoot.gd 中的注释改为
   get_tree().change_scene_to_file("res://scenes/demo/Playground_3D.tscn")
   并在 Project Settings → Autoload 里逐个启用需要的单例，排查无误后再全开。
