extends Node3D

var cam: Camera3D
var distance := 18.0
var min_distance := 6.0
var max_distance := 60.0
var yaw := -0.6
var pitch := -0.6
var rot_speed := 0.015
var pan_speed := 0.08

var dragging_right := false
var dragging_middle := false
var last_mouse := Vector2.ZERO

func _ready() -> void:
    cam = $Camera3D
    set_process_input(true)
    _apply_camera()

func _input(event):
    # mouse buttons
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_RIGHT:
            dragging_right = event.pressed
            last_mouse = event.position
        elif event.button_index == MOUSE_BUTTON_MIDDLE:
            dragging_middle = event.pressed
            last_mouse = event.position
        elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            _on_left_click(event.position)
        elif event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
            distance = clamp(distance - 2.0, min_distance, max_distance)
            _apply_camera()
        elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
            distance = clamp(distance + 2.0, min_distance, max_distance)
            _apply_camera()

    # mouse motion
    if event is InputEventMouseMotion:
        var delta := event.relative
        if dragging_right:
            yaw -= delta.x * rot_speed
            pitch = clamp(pitch - delta.y * rot_speed, -1.2, -0.1)
            _apply_camera()
        elif dragging_middle:
            # pan on ground plane
            var right := cam.global_transform.basis.x
            var fwd := -cam.global_transform.basis.z
            global_position += (-right * delta.x + -fwd * delta.y) * pan_speed

    # keyboard pan
    if event is InputEventKey and event.pressed:
        var move := Vector3.ZERO
        var fwd := -cam.global_transform.basis.z; fwd.y = 0; fwd = fwd.normalized()
        var right := cam.global_transform.basis.x; right.y = 0; right = right.normalized()
        if event.keycode == KEY_W: move += fwd
        if event.keycode == KEY_S: move -= fwd
        if event.keycode == KEY_A: move -= right
        if event.keycode == KEY_D: move += right
        if move != Vector3.ZERO:
            global_position += move.normalized() * 1.8

func _apply_camera() -> void:
    var dir := Vector3(
        cos(pitch) * cos(yaw),
        sin(pitch),
        cos(pitch) * sin(yaw)
    )
    cam.global_position = global_position + -dir * distance
    cam.look_at(global_position, Vector3.UP)

func _on_left_click(screen_pos: Vector2) -> void:
    # raycast to ground (y=0)
    var from := cam.project_ray_origin(screen_pos)
    var to := from + cam.project_ray_normal(screen_pos) * 1000.0
    var t := -from.y / (to.y - from.y + 0.00001)
    if t < 0.0 or t > 1.0: return
    var hit := from + (to - from) * t
    hit.y = 0.0
    var pawn = get_tree().get_first_node_in_group("player_pawn")
    if pawn and pawn.has_method("set_move_target"):
        pawn.set_move_target(hit)
