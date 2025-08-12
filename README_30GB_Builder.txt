Ultimate Hacker — v1.9 30GB Final Builder

这套工具会在你的本地快速生成 24GB（基础包）+ 5GB（可选高清包）的填充内容，并一键导出可执行文件。
原理：使用系统自带工具（Windows: fsutil / Linux: fallocate）创建大文件，占位到目标体积；然后用 Godot 导出。
你之后可以逐步把这些占位文件替换为真正的高清贴图、音频、模型。

步骤（Windows）
1) 安装 Godot 4（命令可用 `godot4`）。
2) 双击 tools/Make_30GB_Windows.bat
   - 会生成 Base EXE（Build/Windows/UltimateHacker.exe）
   - 会生成 HD pack（Build/Windows/hd_textures.pck）
3) 运行 EXE；如需 HD 包，放在同一目录并在游戏内启用 HD（或自动挂载）。

步骤（Linux）
1) 确保有 `fallocate` 与 godot4 命令。
2) `chmod +x tools/Make_30GB_Linux.sh && ./tools/Make_30GB_Linux.sh`

说明
- 这会得到接近 29GB 的安装体积（加上其它资源约到 30GB）。
- 这些大文件初始只是占位；不会被游戏逻辑实际读取。
- 将来替换为真实艺术资源后，导出体积保持接近 30GB 的区间。
