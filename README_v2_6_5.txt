UltimateHacker Hotfix v2.6.5 (Godot 4.4)
- 修正 3D 节点移动：统一用 `position`（不再用 translation）
- 全部生成/初始化阶段的 `add_child()` 统一改为 `call_deferred("add_child", node)`
- RootInit/CityBlockGen 已延迟构建，避免 “Parent node is busy setting up children”
- 仍支持 Esc 或 F1 切换鼠标捕获

使用：关闭 Godot → 解压到工程根目录（覆盖）→ 删除 `.godot/` → 打开项目 → ▶ → 菜单 → City Block
