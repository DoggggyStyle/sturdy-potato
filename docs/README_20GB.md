# 《终极骇客》20GB 内容与压缩方案（新增内容已纳入管线）

你要求“安装体积控制在 ~20GB 且尽可能丰富内容”。本包新增：
- **音乐与语音双语方案（可选语音包）**
- **更丰富的 SFX 库**
- **高密度像素立绘/精灵/地块集**
- **过场动画（webm vp9）**
- **分区资源包 + 流式加载**（按城区/荒野拆分）
- **导出压缩与打包策略**（OPUS/OGG、BC7/ETC2、PCK split）
- **构建后体积检查脚本**

## Godot 建议设置（关键）
- 音乐/VO：OPUS（160/128 kbps），Streaming 播放
- SFX：OGG q4，短音效常驻
- 纹理：Desktop=BC7，最大 2048px，开启 Mipmaps 与 Atlas
- 视频：webm(vp9) 1080p30 @ 5Mbps
- 导出：`resource_compression=lossless`，`split_pck=4096MB`，`export only used resources`

## 目录与打包
- 语音按语言生成独立 `.pck`（玩家只下载一种语言即可）
- 城区/荒野/地下为独立 `.pck`，降低首次安装体积
- 过场动画与音乐流式加载，减少 RAM 与峰值 IO

## 体积预算（见 config/content_budget_20gb.json）
- 目标 20GB，内容桶分配详见 JSON；构建后用 tools/check_size_* 脚本校验。

导入方式：把 `project/` 合并到你的工程根目录，参考 JSON 接线。
