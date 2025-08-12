extends CharacterBody3D

var speed := 6.0
var target := Vector3.ZERO

func _ready() -> void:
    add_to_group("player_pawn")
    target = global_position

func set_move_target(p: Vector3) -> void:
    target = p

func _physics_process(delta: float) -> void:
    var dir := (target - global_position)
    dir.y = 0.0
    if dir.length() > 0.2:
        velocity = dir.normalized() * speed
        look_at(global_position + dir.normalized(), Vector3.UP)
    else:
        velocity = Vector3.ZERO
    move_and_slide()
