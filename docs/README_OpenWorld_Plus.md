# 《隐形骇客》OpenWorld_Plus 更新包（Godot 4）

本包为你的现有工程添加以下系统：
- 动态世界演化（WorldState、FactionEvolution）
- 身份与传闻（IdentityRumor）
- 生存深度（SurvivalSystem）
- 黑客/潜入/经济（HackingGame、InfiltrationSystem、EconomyController）
- 难度导演（DifficultyDirector：越打越乱的逆增长）
- 传说任务与世界事件（legendary_quests.json、world_events.json）
- 区域与势力占领（regions.json）

## 接入步骤（10分钟）
1. 将 `project/` 覆盖到你的 Godot 工程下的 `project/`。
2. 在 `Bootstrap` 或你的主场景中，添加以下节点并按需连线：
   - WorldState（组：world_state）
   - FactionEvolution（引用 WorldState）
   - IdentityRumor、SurvivalSystem、EconomyController、DifficultyDirector
   - HackingGame、InfiltrationSystem
3. 在 Boss 死亡时调用：`FactionEvolution.apply_kill_boss_effect(boss_id)` 和 `DifficultyDirector.on_boss_killed(boss_id, current_notoriety)`。
4. 每个区域进入/离开时，调用：`IdentityRumor.witness_event(region_id, severity)` 来驱动传闻与通缉扩散。
5. 周期调用 `EconomyController.tick()`（每游戏小时一次），实现价格动态。
6. 游戏开始时加载：`regions.json`，填充 WorldState.regions。

## 数据文件
- `data/regions.json`：区域/归属/稳定度/热度
- `data/world_events.json`：世界事件与效果（可扩展）
- `data/legendary_quests.json`：传说任务（多步+副作用）

## 范例：信号与调用
- Boss 死亡：
  ```gdscript
  $FactionEvolution.apply_kill_boss_effect("dog_king")
  $DifficultyDirector.on_boss_killed("dog_king", $IdentityRumor.notoriety_by_region.get(current_region,0))
  ```
- 法警盘查：
  ```gdscript
  var passed = $InfiltrationSystem.check_inspection(current_region, inspector_level)
  ```
- 黑客：
  ```gdscript
  $HackingGame.start_hack("camera_A12", 2)
  ```

## 备注
以上为可运行的脚本骨架与数据示例，能立即在工程里挂载与调试。
完善阶段你只需把 UI/AI/关卡与这些系统信号连接即可。
