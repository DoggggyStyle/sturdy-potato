extends Node3D

@export var move_speed: float = 10.0
var yaw := 0.0
var pitch := 0.0

func _unhandled_input(event):
    if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
        yaw -= event.relative.x * 0.002
        pitch -= event.relative.y * 0.002
        pitch = clamp(pitch, -1.2, 1.2)

func _process(delta):
    var cam: Camera3D = $Camera3D
    cam.rotation = Vector3(pitch, yaw, 0.0)

    var dir := Vector3.ZERO
    # Arrow keys (ui_*)
    if Input.is_action_pressed("ui_up"): dir += -cam.transform.basis.z
    if Input.is_action_pressed("ui_down"): dir += cam.transform.basis.z
    if Input.is_action_pressed("ui_left"): dir += -cam.transform.basis.x
    if Input.is_action_pressed("ui_right"): dir += cam.transform.basis.x
    # WASD fallback
    if Input.is_key_pressed(KEY_W): dir += -cam.transform.basis.z
    if Input.is_key_pressed(KEY_S): dir += cam.transform.basis.z
    if Input.is_key_pressed(KEY_A): dir += -cam.transform.basis.x
    if Input.is_key_pressed(KEY_D): dir += cam.transform.basis.x
    # Up/Down (QE)
    if Input.is_key_pressed(KEY_Q): dir += Vector3.UP
    if Input.is_key_pressed(KEY_E): dir += Vector3.DOWN

    if dir != Vector3.ZERO:
        cam.translation += dir.normalized() * move_speed * delta
