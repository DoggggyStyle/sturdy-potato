Hotfix v2.7.4 — RTS 输入修复（Godot 4.4）
- RTSCamera.gd 改用 _input 处理：右键旋转、中键平移、滚轮缩放、左键点地移动、WASD 平移。
- PlayerPawn.gd 提供 set_move_target() 并自动加入 group: player_pawn。
- StealthHUD 设置 mouse_filter=IGNORE / focus_mode=NONE，避免拦截输入。
使用：关闭 Godot → 解压覆盖工程 → 删 .godot/ → 打开 → ▶ → City Block。
