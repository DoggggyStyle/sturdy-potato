extends Node3D

var move_speed := 16.0
var sprint_mult := 2.0
var mouse_sens := 0.12
var mouse_captured := true

var yaw := 0.0
var pitch := 0.0
var crouched := false

func _ready():
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
    mouse_captured = true

func _unhandled_input(event):
    if event is InputEventMouseMotion and mouse_captured:
        yaw -= event.relative.x * mouse_sens * 0.01
        pitch -= event.relative.y * mouse_sens * 0.01
        pitch = clamp(pitch, -1.3, 1.3)

func _process(delta):
    var cam: Camera3D = $Camera3D
    cam.rotation = Vector3(pitch, yaw, 0.0)

    if Input.is_action_just_pressed("ui_cancel") or Input.is_key_pressed(KEY_F1):
        mouse_captured = not mouse_captured
        Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if mouse_captured else Input.MOUSE_MODE_VISIBLE

    crouched = Input.is_key_pressed(KEY_CTRL)

    var speed := move_speed * (sprint_mult if Input.is_key_pressed(KEY_SHIFT) else 1.0)
    if crouched:
        speed *= 0.5

    var dir := Vector3.ZERO
    if Input.is_key_pressed(KEY_W): dir += -cam.transform.basis.z
    if Input.is_key_pressed(KEY_S): dir += cam.transform.basis.z
    if Input.is_key_pressed(KEY_A): dir += -cam.transform.basis.x
    if Input.is_key_pressed(KEY_D): dir += cam.transform.basis.x
    if Input.is_key_pressed(KEY_Q): dir += Vector3.DOWN
    if Input.is_key_pressed(KEY_E): dir += Vector3.UP
    if dir != Vector3.ZERO:
        cam.position += dir.normalized() * speed * delta

    if Input.is_key_pressed(KEY_F):
        var ws = get_node("/root/WantedSystem")
        ws.add_crime(0.2)

    if Input.is_key_pressed(KEY_E):
        _try_pickpocket()

func _try_pickpocket():
    var cam: Camera3D = $Camera3D
    var npcs = get_tree().get_nodes_in_group("npcs")
    for n in npcs:
        if not (n is Node3D): continue
        var to_player = (cam.global_transform.origin - n.global_transform.origin)
        if to_player.length() > 2.0: continue
        var forward = n.global_transform.basis.z * -1.0
        var dotv = forward.normalized().dot(to_player.normalized())
        if dotv < 0.4:
            continue
        if n.has_method("steal_wallet"):
            n.steal_wallet()
        var ws = get_node("/root/WantedSystem")
        ws.add_crime(0.5)
        break

func get_noise_level() -> float:
    if crouched:
        return 0.2
    if Input.is_key_pressed(KEY_SHIFT):
        return 1.0
    return 0.5
