Ultimate Hacker — v1.9.2 CleanBoot

这个热修版做了：
1) 修正 GDScript 语法（去掉 ? : 三元等），兼容 Godot 4.4.1。
2) 固定主场景为 `scenes/demo/Playground_3D.tscn`，打开即运行。
3) 仅保留两个稳定的自动加载：GraphicsManager、PostFXManager（其它系统先不自动加载，避免启动报错）。
4) 保留图形档位与后期系统，便于你先验证能跑。

使用：
- 直接导入 CleanBoot 工程或把 `project/` 覆盖到你的工程。
- 如果仍提示脚本旧缓存，请删除 `.godot/` 目录（Godot 的缓存）后重开项目再运行。
