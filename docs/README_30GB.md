# 《终极骇客》30GB 内容与打包方案

目标：**安装体积 ≤ 30GB**（基础包 <25GB；可选高清材质包安装后接近 30GB）。
- 文本对白基线（无内置配音）。
- 分区 `.pck`、文本多语言 `.pck`、可选 `hd_textures.pck`。
- 音乐与视频流式，纹理 BC7/ETC2，导出 PCK 分片 4GB。

## 推荐配比
- 美术贴图/立绘/时装周材质：6GB（基础）+ 5GB（可选HD）
- 地图与变体：5GB
- 音乐（多分层）：4GB
- SFX：1.6GB
- 过场：3.5GB
- UI/字体/本地化：1.2GB
- Mods示例：1.2GB
- 预留：0.7GB

## Steam Depot 建议
- `base_game`：玩家默认安装（<25GB）
- `optional_hd`：高清材质（玩家自选）
- `workshop_tools`：创意工坊作者工具与模板

构建后运行 `tools/check_size_*_30gb.*` 校验体积。
