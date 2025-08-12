# 《终极骇客》Omni 扩展（全部缺口整合）

包含模块：
- **DynamicMapControl.gd**：区域易主→自动切换风格与标识（对接 WorldState / VisualStateController）
- **FestivalSystem.gd**：城市节日/活动，按日历触发 Buff/灯光/音乐（见 data/festival_calendar.json）
- **SocialGraph.gd**：NPC↔NPC 关系网 & 玩家居中调解，驱动八卦与任务变化
- **PlayerBase.gd**：玩家据点获取/升级/装饰（对接创意工坊装饰包）
- **LoreFragments.gd**：碎片化叙事收集，集齐解锁奖励/任务（见 data/lore_sets.json）
- **EcoDisruption.gd**：物流线路可破坏/修复→价格震荡（见 data/eco_routes.json）

## 快速接线
1. 合并 `project/` 到工程。
2. 在主场景新增节点并连接信号：
   - `WorldState.region_owner_changed -> DynamicMapControl.set_owner`
   - `DynamicMapControl.signage_updated -> 你的场景脚本（替换旗帜/广告/灯光主题）`
   - `FestivalSystem.festival_started/finished -> 切音乐Profile、切灯光、开放节日任务`
   - `SocialGraph.relation_changed -> QuestGenerator`（刷新可接任务）
   - `EcoDisruption.price_shock -> EconomyController`（调价/需求）
3. 运行时：
   - `FestivalSystem.load_calendar("res://project/data/festival_calendar.json")`
   - `LoreFragments.load_sets("res://project/data/lore_sets.json")`
   - `EcoDisruption.load_routes("res://project/data/eco_routes.json")`

## 建议
- 节日与巴黎时装周风格联动：`neon_fashion_week` 开启秀场灯光与奢华曲风。
- 据点装饰支持创意工坊：装饰项以 `decor_id` 注入 PlayerBase。
