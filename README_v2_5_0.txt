Vertical Slice: City Block

覆盖本补丁后：
- 菜单新增 “Enter City Block (vertical slice)”
- CityBlock.tscn：天空、道路、随机楼群、可移动玩家、NPC 游走、通缉系统、警察追捕、HUD 显示星级
- F 键触发犯罪提升通缉；Shift 冲刺；WASD/QE 移动，鼠标转向。

建议启用 Autoload：
Project → Project Settings → Autoload → 添加：
  WantedSystem  路径: res://scripts/systems/WantedSystem.gd  勾选
（为了万无一失，你也可以不用 Autoload：把 CityBlock.tscn 根节点下新建一个脚本，在 _ready() 里 add_child(WantedSystem.new()) ）
