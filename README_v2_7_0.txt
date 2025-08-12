RTS/Kenshi 视角补丁 v2.7.0（Godot 4.4）
- 去掉第一人称，新增 RTSCamera：右键拖拽旋转、滚轮缩放、中键（或 Shift+右键）平移；
- 左键点地面：小人 Pawn 会移动过去（临时角色，用于验证交互）；
- 相机加入组 "player_cameras"，NPC 感知依旧可取到相机；
- CityBlock.tscn 已切到 RTSCameraRig + Pawn 版本，无鼠标捕获。

使用：关闭 Godot → 把补丁解压覆盖工程 → 删“.godot/”缓存 → 打开 → 菜单 → City Block。
操作：右键旋转 / 中键平移 / 滚轮缩放 / 左键点地移动。
