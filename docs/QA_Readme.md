# Ultimate Hacker — QA / Smoke Test Kit

本套件帮你**本地自测**我们承诺的功能是否存在，并验证性能是否流畅。

## 包含
- `project/FeatureMatrix.json`：应包含的功能清单（可逐项打勾）
- `scripts/qa/TestRunner.gd`：自动化冒烟测试（需接入你的单例/场景API）
- `scripts/qa/PerfProbe.gd`：采集 FPS/帧时间，输出 CSV

## 如何运行
### 方式 A：编辑器内自测
1. 把 `QATestRunner` 作为 Autoload（Project Settings -> Autoload）。
2. 运行游戏 30 秒内会生成 `user://qa_report.json`。

### 方式 B：命令行（建议用于性能采样）
- 以**PerfProbe**为 Autoload，命令行启动 Godot（示例）：
```
godot4 --headless --path project --main-pack project.pck
```
或直接运行项目：
```
godot4 --path project
```
30 秒后自动退出并生成 `user://perf_probe.csv`。

## 通过标准（建议）
- **功能**：`qa_report.json` 中所有条目 `"pass": true`；若有 `false`，根据 `details` 修复对接。
- **性能**：1080p 下
  - Performance 档：**60 FPS 稳定**
  - Balanced 档：**50–60 FPS**
  - Quality 档：**45–60 FPS**（HD 包可稍降）
  - Ultra 档：**30–45 FPS**（高端显卡）

## 注意
- 此套件不会替你“自动完成游戏逻辑”，需要在 `_test_*` 标记处调用你项目内的实际函数（如 `WorldState`, `EconomyController` 等）。
- 生成的 `user://` 文件在系统用户数据目录，可在 Godot Editor 的 `Open User Data Folder` 查看。
