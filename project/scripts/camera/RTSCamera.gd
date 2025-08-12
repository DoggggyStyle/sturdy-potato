extends Camera3D

@export var move_speed := 12.0
@export var fast_mul := 2.0
@export var slow_mul := 0.4
@export var rotate_speed := 0.015
@export var zoom_speed := 25.0
@export var min_height := 6.0
@export var max_height := 120.0
@export var edge_band := 12

var _yaw := 0.0
var _pitch := -0.6

func _ready() -> void:
	current = true
	_rotation_from_angles()

func _unhandled_input(e: InputEvent) -> void:
	if e is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		_yaw -= e.relative.x * rotate_speed
		_pitch = clamp(_pitch - e.relative.y * rotate_speed, -1.2, -0.1)
		_rotation_from_angles()
	elif e is InputEventMouseButton:
		if e.button_index == MOUSE_BUTTON_WHEEL_UP and e.pressed:
			_zoom(-1.0)
		elif e.button_index == MOUSE_BUTTON_WHEEL_DOWN and e.pressed:
			_zoom(1.0)

func _process(dt: float) -> void:
	var mul := move_speed
	if Input.is_action_pressed("rts_fast"): mul *= fast_mul
	if Input.is_action_pressed("rts_slow"): mul *= slow_mul

	var v := Vector3.ZERO
	# 键盘
	if Input.is_action_pressed("rts_left"):  v.x -= 1.0
	if Input.is_action_pressed("rts_right"): v.x += 1.0
	if Input.is_action_pressed("rts_forward"): v.z -= 1.0
	if Input.is_action_pressed("rts_back"):    v.z += 1.0
	# 屏幕边缘
	var m := get_viewport().get_mouse_position()
	var size := get_viewport().get_visible_rect().size
	if m.x <= edge_band: v.x -= 1.0
	elif m.x >= size.x - edge_band: v.x += 1.0
	if m.y <= edge_band: v.z -= 1.0
	elif m.y >= size.y - edge_band: v.z += 1.0

	if v != Vector3.ZERO:
		v = v.normalized()
		var f := -global_transform.basis.z; f.y = 0; f = f.normalized()
		var r :=  global_transform.basis.x;  r.y = 0; r = r.normalized()
		global_position += (r * v.x + f * v.z) * mul * dt

func _zoom(dir: float) -> void:
	var h := clamp(global_position.y + dir * zoom_speed * (Input.is_action_pressed("rts_fast") ? 2.0 : 1.0), min_height, max_height)
	global_position.y = h

func _rotation_from_angles() -> void:
	var t := Transform3D()
	t.basis = Basis(Vector3.UP, _yaw) * Basis(Vector3.RIGHT, _pitch)
	t.origin = global_position
	global_transform = t
