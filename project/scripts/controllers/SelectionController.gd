extends Node

@export var rts_camera_path: NodePath
@export var ground_mask := 1
@export var unit_mask := 1

var cam: Camera3D
var rts: RTSCamera
var selected: Array[Node3D] = []

func _ready() -> void:
	# 自动创建输入映射（避免你手动设置）
	_ensure_action("order_move", MOUSE_BUTTON_RIGHT)
	_ensure_action("select_primary", MOUSE_BUTTON_LEFT)
	_ensure_key_action("toggle_follow", KEY_F)
	_ensure_key_action("toggle_follow_alt", KEY_SPACE)

	# 获取相机引用
	var node := get_node(rts_camera_path)
	if node is RTSCamera:
		rts = node
		cam = rts.get_node("Camera3D") as Camera3D
	else:
		push_error("SelectionController: rts_camera_path 未指向 RTSCamera")
		set_process_unhandled_input(false)

func _unhandled_input(e: InputEvent) -> void:
	if e is InputEventMouseButton and e.pressed:
		if e.button_index == MOUSE_BUTTON_LEFT:
			_select_under_mouse()
		elif e.button_index == MOUSE_BUTTON_RIGHT:
			_order_move_to_mouse()
	if e is InputEventKey and e.pressed:
		if e.keycode == KEY_F or e.keycode == KEY_SPACE:
			_toggle_follow()

func _select_under_mouse() -> void:
	var hit: Dictionary := _ray_to_unit()
	if hit == null:
		selected.clear()
		return
	selected = [hit]

func _order_move_to_mouse() -> void:
	if selected.is_empty(): return
	var p := _ray_to_ground()
	if p == null: return
	for u in selected:
		if u.has_method("set_goal"):
			u.set_goal(p)

func _toggle_follow() -> void:
	if rts == null: return
	if selected.is_empty():
		rts.start_follow(null)
		return
	var u := selected[0]
	# 再按一次取消
	if rts._follow_target == u:
		rts._stop_follow()
	else:
		rts.start_follow(u, Vector3(0,0,0))

func _ray_to_ground() -> Vector3:
	var m := get_viewport().get_mouse_position()
	var from := cam.project_ray_origin(m)
	var dir := cam.project_ray_normal(m)
	var to := from + dir * 5000.0
	var q := PhysicsRayQueryParameters3D.create(from, to, ground_mask)
	var hit: Dictionary := get_world().direct_space_state.intersect_ray(q)
	if hit.has("position"):
		return hit.position
	return null

func _ray_to_unit() -> Node3D:
	var m := get_viewport().get_mouse_position()
	var from := cam.project_ray_origin(m)
	var dir := cam.project_ray_normal(m)
	var to := from + dir * 5000.0
	var q := PhysicsRayQueryParameters3D.create(from, to, unit_mask)
	var hit: Dictionary := get_world().direct_space_state.intersect_ray(q)
	if hit.has("collider") and hit.collider is Node3D and hit.collider.is_in_group("unit"):
		return hit.collider
	return null

func _ensure_action(name: String, mouse_button: int) -> void:
	if not InputMap.has_action(name):
		InputMap.add_action(name)
	var ev := InputEventMouseButton.new()
	ev.button_index = mouse_button
	InputMap.action_add_event(name, ev)

func _ensure_key_action(name: String, keycode: int) -> void:
	if not InputMap.has_action(name):
		InputMap.add_action(name)
	var ev := InputEventKey.new()
	ev.keycode = keycode
	InputMap.action_add_event(name, ev)
