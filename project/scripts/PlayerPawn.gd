extends CharacterBody3D

var speed := 6.0
var target := Vector3.ZERO

func _ready():
    add_to_group("player_pawn")
    target = global_transform.origin

func set_move_target(p: Vector3) -> void:
    target = p

func _physics_process(delta):
    var vec := (target - global_transform.origin)
    vec.y = 0.0
    if vec.length() > 0.2:
        velocity = vec.normalized() * speed
        move_and_slide()
    else:
        velocity = Vector3.ZERO

func get_noise_level() -> float:
    return 0.6
