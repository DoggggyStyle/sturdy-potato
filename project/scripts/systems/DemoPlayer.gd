
extends CharacterBody3D
class_name DemoPlayer

@export var move_speed := 6.0
@export var sprint_mult := 1.7
@export var turn_speed_deg := 120.0

var cam: Camera3D

func _ready():
    cam = $Camera3D

func _physics_process(delta: float) -> void:
    var input_vec = Vector2.ZERO
    input_vec.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    input_vec.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    if input_vec.length() > 1.0:
        input_vec = input_vec.normalized()
    var speed = move_speed * (sprint_mult if Input.is_action_pressed("ui_accept") else 1.0)
    var dir = (transform.basis * Vector3(input_vec.x, 0, input_vec.y)).normalized()
    velocity.x = dir.x * speed
    velocity.z = dir.z * speed
    # simple damping on slopes
    if not is_on_floor():
        velocity.y -= 9.8 * delta
    else:
        velocity.y = 0.0
    move_and_slide()

    # Q/E rotate
    var rot = 0.0
    if Input.is_key_pressed(KEY_Q): rot += 1.0
    if Input.is_key_pressed(KEY_E): rot -= 1.0
    if rot != 0.0:
        rotate_y(deg_to_rad(rot * turn_speed_deg * delta))
