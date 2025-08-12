extends Node3D
@export var move_speed:float = 20.0
@export var rotate_speed:float = 0.015
@export var zoom_speed:float = 4.0
@export var min_distance:float = 6.0
@export var max_distance:float = 60.0
@export var min_pitch:float = deg_to_rad(15.0)
@export var max_pitch:float = deg_to_rad(80.0)
var _cam: Camera3D
var _target: Vector3 = Vector3.ZERO
var _distance: float = 20.0
var _yaw: float = 0.0
var _pitch: float = deg_to_rad(45.0)
var _rotating := false
var _panning := false
func _ready() -> void:
	_cam = $Camera3D if has_node('Camera3D') else null
	if _cam == null:
		_cam = Camera3D.new()
		add_child(_cam)
	_cam.current = true
	_update_camera()
func _process(delta: float) -> void:
	var pan := Vector3.ZERO
	if Input.is_key_pressed(KEY_W): pan += Vector3.FORWARD
	if Input.is_key_pressed(KEY_S): pan += Vector3.BACK
	if Input.is_key_pressed(KEY_A): pan += Vector3.LEFT
	if Input.is_key_pressed(KEY_D): pan += Vector3.RIGHT
	if pan != Vector3.ZERO:
		pan = pan.normalized()
		var basis := Basis(Vector3.UP, _yaw)
		var dir := (basis * pan).normalized()
		_target += dir * move_speed * delta
	_update_camera()
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mb := event as InputEventMouseButton
		if mb.button_index == MOUSE_BUTTON_RIGHT:
			_rotating = mb.pressed
		elif mb.button_index == MOUSE_BUTTON_MIDDLE:
			_panning = mb.pressed
		elif mb.button_index == MOUSE_BUTTON_WHEEL_UP and mb.pressed:
			_distance = clamp(_distance - zoom_speed, min_distance, max_distance); _update_camera()
		elif mb.button_index == MOUSE_BUTTON_WHEEL_DOWN and mb.pressed:
			_distance = clamp(_distance + zoom_speed, min_distance, max_distance); _update_camera()
	elif event is InputEventMouseMotion:
		var mm := event as InputEventMouseMotion
		if _rotating:
			_yaw -= mm.relative.x * rotate_speed
			_pitch = clamp(_pitch - mm.relative.y * rotate_speed, min_pitch, max_pitch)
			_update_camera()
		elif _panning:
			var basis := Basis(Vector3.UP, _yaw)
			_target += (basis.x * -mm.relative.x + basis.z * mm.relative.y) * 0.03
			_update_camera()
func _update_camera() -> void:
	var offset := Vector3(
		_distance * sin(_yaw) * cos(_pitch),
		_distance * sin(_pitch),
		_distance * cos(_yaw) * cos(_pitch)
	)
	_cam.position = _target + offset
	_cam.look_at(_target, Vector3.UP)
	self.position = _target
