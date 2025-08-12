extends Node3D
class_name RTSCamera

@export var camera_path: NodePath
@export_group("Move/Rotate/Zoom")
@export var pan_speed := 18.0
@export var pan_speed_alt_factor := 0.6
@export var rotate_speed_deg := 120.0
@export var zoom_min := 6.0
@export var zoom_max := 80.0
@export var zoom_step := 3.0
@export var tilt_min_deg := 30.0
@export var tilt_max_deg := 60.0
@export var smooth := 10.0
@export_group("Edge / Drag")
@export var edge_pan := true
@export var edge_px := 14
@export var mmb_drag := true
@export var mmb_sensitivity := 1.0
@export_group("Bounds / Height")
@export var use_bounds := false
@export var bounds_min := Vector2(-200.0, -200.0)
@export var bounds_max := Vector2( 200.0,  200.0)
@export var min_ground_clearance := 2.0
@export var ground_mask := 1
@export var ray_length := 5000.0

signal centered_on(target)
signal follow_started(target)
signal follow_stopped()

var cam: Camera3D
var _target_pos: Vector3
var _target_yaw := 0.0
var _target_dist := 20.0
var _dragging := false
var _last_rclick_ms := -99999
@export var double_click_ms := 280
var _follow_target: Node3D
@export var follow_offset := Vector3(0,0,0)
@export var follow_smooth := 8.0
var _tilt_locked := false
var _tilt_lock_value_deg := 45.0

func _ready() -> void:
	cam = get_node_or_null(camera_path) as Camera3D
	if cam == null and has_node("Camera3D"):
		cam = $Camera3D
	assert(cam != null, "RTSCamera: Camera3D not found.")
	_target_pos = global_position
	_target_yaw = rotation.y
	_target_dist = clamp(20.0, zoom_min, zoom_max)
	_apply_immediate()

func _unhandled_input(e: InputEvent) -> void:
	if e is InputEventMouseButton:
		if e.button_index == MOUSE_BUTTON_WHEEL_UP and e.pressed:
			_target_dist = max(zoom_min, _target_dist - zoom_step)
			if Input.is_key_pressed(KEY_SHIFT): _lock_current_tilt()
		elif e.button_index == MOUSE_BUTTON_WHEEL_DOWN and e.pressed:
			_target_dist = min(zoom_max, _target_dist + zoom_step)
			if Input.is_key_pressed(KEY_SHIFT): _lock_current_tilt()
		elif e.button_index == MOUSE_BUTTON_MIDDLE:
			_dragging = e.pressed and mmb_drag
		elif e.button_index == MOUSE_BUTTON_RIGHT and e.pressed:
			var now := Time.get_ticks_msec()
			if now - _last_rclick_ms <= double_click_ms: _center_to_mouse_ground()
			_last_rclick_ms = now
	elif e is InputEventMouseMotion and _dragging:
		_pan_screen(-e.relative.x, -e.relative.y)

func _process(delta: float) -> void:
	_gather_keyboard_edge_input(delta)
	_handle_rotate(delta)
	_follow_update(delta)
	_clamp_to_bounds()
	_keep_over_ground()
	_apply_smooth(delta)

func _gather_keyboard_edge_input(delta: float) -> void:
	var v := Vector2.ZERO
	v.x += Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	v.y += Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if edge_pan:
		var m := get_viewport().get_mouse_position()
		var sz := get_viewport().get_visible_rect().size
		if m.x <= edge_px: v.x -= 1
		if m.x >= sz.x - edge_px: v.x += 1
		if m.y <= edge_px: v.y -= 1
		if m.y >= sz.y - edge_px: v.y += 1
	if v == Vector2.ZERO: return
	_stop_follow()
	v = v.normalized()
	var forward := -Basis.from_euler(Vector3(0, _target_yaw, 0)).z
	var right :=  Basis.from_euler(Vector3(0, _target_yaw, 0)).x
	var alt := 1.0 + (_target_dist / zoom_max) * pan_speed_alt_factor
	_target_pos += (right * v.x + forward * v.y) * pan_speed * alt * delta

func _handle_rotate(delta: float) -> void:
	var dir := 0.0
	if Input.is_key_pressed(KEY_Q): dir += 1.0
	if Input.is_key_pressed(KEY_E): dir -= 1.0
	if dir != 0.0:
		_stop_follow()
		_target_yaw += deg_to_rad(dir * rotate_speed_deg * delta)

func _pan_screen(dx: float, dy: float) -> void:
	_stop_follow()
	var f := -Basis.from_euler(Vector3(0, _target_yaw, 0)).z
	var r :=  Basis.from_euler(Vector3(0, _target_yaw, 0)).x
	var s := 0.02 * (_target_dist / 20.0)
	_target_pos += r * dx * s + f * dy * s

func _center_to_mouse_ground() -> void:
	var hit := _raycast_mouse_to_ground()
	if hit.has("position"):
		_stop_follow()
		_target_pos = hit.position
		emit_signal("centered_on", self)

func start_follow(target: Node3D, offset := Vector3.ZERO) -> void:
	_follow_target = target
	follow_offset = offset
	if _follow_target: emit_signal("follow_started", _follow_target)

func _stop_follow() -> void:
	if _follow_target:
		_follow_target = null
		emit_signal("follow_stopped")

func _follow_update(delta: float) -> void:
	if _follow_target == null: return
	var dst := _follow_target.global_position + follow_offset
	_target_pos = _target_pos.lerp(dst, 1.0 - exp(-follow_smooth * delta))

func _apply_smooth(delta: float) -> void:
	var tilt_deg := _compute_tilt_deg()
	rotation.y = lerp_angle(rotation.y, _target_yaw, 1.0 - exp(-smooth * delta))
	global_position = global_position.lerp(_target_pos, 1.0 - exp(-smooth * delta))
	var off := _orbit_offset(_target_dist, deg_to_rad(tilt_deg))
	cam.global_transform = global_transform * Transform3D(Basis.IDENTITY, off)
	cam.look_at(global_position)

func _apply_immediate() -> void:
	var tilt_deg := _compute_tilt_deg()
	rotation.y = _target_yaw
	global_position = _target_pos
	var off := _orbit_offset(_target_dist, deg_to_rad(tilt_deg))
	cam.global_transform = global_transform * Transform3D(Basis.IDENTITY, off)
	cam.look_at(global_position)

func _compute_tilt_deg() -> float:
	if _tilt_locked: return _tilt_lock_value_deg
	var t := clamp((_target_dist - zoom_min) / max(0.001, (zoom_max - zoom_min)), 0.0, 1.0)
	return lerp(tilt_min_deg, tilt_max_deg, t)

func _lock_current_tilt() -> void:
	_tilt_locked = true
	var t := clamp((_target_dist - zoom_min) / max(0.001, (zoom_max - zoom_min)), 0.0, 1.0)
	_tilt_lock_value_deg = lerp(tilt_min_deg, tilt_max_deg, t)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and not event.pressed and event.keycode == KEY_SHIFT:
		_tilt_locked = false

func _clamp_to_bounds() -> void:
	if not use_bounds: return
	_target_pos.x = clamp(_target_pos.x, bounds_min.x, bounds_max.x)
	_target_pos.z = clamp(_target_pos.z, bounds_min.y, bounds_max.y)

func _keep_over_ground() -> void:
	var hit := _raycast_at_position(Vector3(_target_pos.x, 1000.0, _target_pos.z), Vector3.DOWN)
	if hit.has("position"):
		var g := hit.position
		if _target_pos.y < g.y + min_ground_clearance:
			_target_pos.y = g.y + min_ground_clearance

func _orbit_offset(dist: float, tilt_rad: float) -> Vector3:
	var back := -Basis.from_euler(Vector3(0, _target_yaw, 0)).z
	var up := Vector3.UP
	return (back.normalized() * cos(tilt_rad) + up * sin(tilt_rad)) * dist

func _raycast_mouse_to_ground() -> Dictionary:
	var vp := get_viewport()
	if vp == null or cam == null: return {}
	var m := vp.get_mouse_position()
	var from := cam.project_ray_origin(m)
	var dir := cam.project_ray_normal(m)
	return _intersect_ray(from, from + dir * ray_length)

func _raycast_at_position(from: Vector3, dir: Vector3) -> Dictionary:
	return _intersect_ray(from, from + dir * ray_length)

func _intersect_ray(from: Vector3, to: Vector3) -> Dictionary:
	var q := PhysicsRayQueryParameters3D.create(from, to, ground_mask)
	return get_world_3d().direct_space_state.intersect_ray(q)
