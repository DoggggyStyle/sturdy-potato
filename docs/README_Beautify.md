# 《隐形骇客》美化包（Beautify_Pack）

包含：
- 霓虹像素调色板 `palette_neondust.json`
- UI 九宫格面板与按钮纹理（panel_9, button_n/h/p）
- 图标 12 枚（inventory/gear/stealth/hack/map/quest/warning/skull/money/water/food/med）
- 2D 着色器（描边、扫描线、色差）
- 粒子纹理（柔光、火花）
- 示例 HUD 场景 `scenes/ui/HUDStyled.tscn`
- `export_presets.cfg`（Windows/Linux 导出预设）

## 接入
1. 将 `project/` 内容拷贝到你的工程同名目录下（不覆盖已有文件则合并即可）。
2. 在需要描边的 `Sprite2D` 上使用 `shaders/outline.gdshader`。
3. 将 `scenes/ui/HUDStyled.tscn` 作为例子把图标/面板替换到你的 UI 上。
4. 导出：在 Godot 中打开 `Project > Export`，确认 `export_presets.cfg` 预设，点击导出。
