Hotfix v2.6.3 (Godot 4.4)
- 释放鼠标：按 ESC（或 F1 备用）。
- 修复 HUD 报错（不再用 String * int，而是构造星号字符串）。
- RootInit 采用 call_deferred 添加 HUD，避免“Parent node busy”错误。
使用：关闭 Godot → 解压覆盖工程 → 删“.godot/”缓存 → 打开 → ▶。
