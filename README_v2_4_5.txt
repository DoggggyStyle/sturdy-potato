Ultimate Hacker — v2.4.5 FINAL (Godot 4.4 Release Lock)

已整合：
- Shader 修复（兼容 Godot 4）
- 场景修复（GraphicsMenu / Playground_3D）+ 可见地面/天空/当前相机
- 主场景锁定为 GraphicsMenu（菜单 → Start 3D）
- Autoload 启用：GraphicsManager、HDManager
- 默认图形配置：config/perf_profiles.json（Performance / Balanced / High）
- tools 一键 30GB 构建、导出预设（Win/Linux）

使用：
1) 解压 → Godot 导入 project/project.godot → ▶ 直接进菜单。
2) 菜单点击“Start 3D Playground”进入 3D；右键拖动视角，WASD/方向键移动，Q/E 上下。
3) 需要 30GB：工程根目录运行 tools\Make_30GB_Windows.bat（或 Linux 脚本）。
4) 如遇异常：先删除工程“.godot/”缓存，再打开；仍有问题把控制台前20行发我。

准备发布：Project → Export 按现有预设导出；可选择把 hd_textures.pck 放到同目录启用高清材质。
