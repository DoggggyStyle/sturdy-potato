extends CharacterBody3D
class_name Unit

@export var move_speed := 6.0
var goto_point: Vector3
var has_goal := false

func _ready() -> void:
	add_to_group("unit")
	goto_point = global_position

func set_goal(p: Vector3) -> void:
	goto_point = p
	has_goal = true

func _physics_process(delta: float) -> void:
	if has_goal:
		var dir := (goto_point - global_position)
		dir.y = 0.0
		if dir.length() < 0.2:
			has_goal = false
			velocity = Vector3.ZERO
			return
		dir = dir.normalized()
		velocity.x = dir.x * move_speed
		velocity.z = dir.z * move_speed
		move_and_slide()
