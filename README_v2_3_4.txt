Ultimate Hacker — v2.3.4 Clean-NoPlugin

这个版本移除了会报错的编辑器插件，彻底禁用了自定义主题引用。
用途：直接导入 Godot，运行场景、导出构建，或用 tools 下脚本生成≈30GB版本。

用法：
1) 打开 Godot → 导入 project/project.godot
2) 直接运行 ▶ 验证
3) Windows 一键：tools\Make_30GB_Windows.bat（先生成24GB+5GB占位，再导出）
   Linux 一键：tools/Make_30GB_Linux.sh
4) 若需 Godot 内导出：Project → Export（已带 Windows/Linux 预设）

如果你仍想用“Finalize”面板，我可以再给你一个只含修好插件的补丁；
但为了稳定，这个版本默认不带插件，避免任何脚本解析报错。
