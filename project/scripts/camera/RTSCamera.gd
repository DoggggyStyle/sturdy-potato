extends Node3D

@export var pan_speed := 24.0
@export var rot_speed := 0.02
@export var zoom_speed := 2.0
@export var min_height := 6.0
@export var max_height := 40.0
@export var yaw := 0.0
@export var pitch := -0.6

var dragging_rotate := false
var dragging_pan := false
var last_mouse := Vector2.ZERO

func _ready():
    set_process_unhandled_input(true)

func _unhandled_input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
            _zoom(-1.0)
        elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
            _zoom(1.0)
        elif event.button_index == MOUSE_BUTTON_RIGHT:
            dragging_rotate = event.pressed
            last_mouse = event.position
        elif event.button_index == MOUSE_BUTTON_MIDDLE:
            dragging_pan = event.pressed
            last_mouse = event.position
        elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            _try_move_player_to_mouse()

    elif event is InputEventMouseMotion:
        if dragging_rotate:
            var delta := event.relative
            yaw -= delta.x * rot_speed * 0.01
            pitch -= delta.y * rot_speed * 0.01
            pitch = clamp(pitch, -1.2, -0.1)
        elif dragging_pan:
            var d := event.relative
            var right := global_transform.basis.x
            var forward := -global_transform.basis.z
            translation += (-right * d.x + -forward * d.y) * 0.02

func _process(delta):
    var v := Vector3.ZERO
    if Input.is_key_pressed(KEY_W): v += -global_transform.basis.z
    if Input.is_key_pressed(KEY_S): v += global_transform.basis.z
    if Input.is_key_pressed(KEY_A): v += -global_transform.basis.x
    if Input.is_key_pressed(KEY_D): v += global_transform.basis.x
    if v != Vector3.ZERO:
        translation += v.normalized() * pan_speed * delta

    var t := Transform3D.BasisXform(Basis(), Vector3.ZERO)
    var rot := Basis()
    rot = Basis.from_euler(Vector3(pitch, yaw, 0.0))
    rotation = rot.get_euler()

    var h := clamp(translation.y, min_height, max_height)
    translation.y = h

func _zoom(dir: float):
    translation.y = clamp(translation.y + dir * zoom_speed, min_height, max_height)

func _try_move_player_to_mouse():
    var vp := get_viewport()
    var cam := get_node_or_null("Camera3D")
    if cam == null:
        cam = find_child("Camera3D", true, false)
    if cam == null:
        return
    var mpos := vp.get_mouse_position()
    var from := cam.project_ray_origin(mpos)
    var to := from + cam.project_ray_normal(mpos) * 200.0
    var space := get_world_3d().direct_space_state
    var res := space.intersect_ray(PhysicsRayQueryParameters3D.create(from, to))
    if res and res.has("position"):
        var dest := res["position"]
        var player := get_tree().get_first_node_in_group("player_pawn")
        if player and player.has_method("set_move_target"):
            player.set_move_target(dest)
