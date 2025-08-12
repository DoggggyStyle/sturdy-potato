extends CharacterBody3D

@export var move_speed := 6.0
var target: Vector3
var have_target := false

func _ready():
    target = global_position

func set_move_target(p: Vector3) -> void:
    target = p
    have_target = true

func _physics_process(delta):
    if have_target:
        var to = target - global_position
        to.y = 0.0
        var d = to.length()
        if d < 0.2:
            have_target = false
            velocity = Vector3.ZERO
        else:
            var dir = to.normalized()
            velocity.x = dir.x * move_speed
            velocity.z = dir.z * move_speed
            velocity.y = 0.0
        move_and_slide()
