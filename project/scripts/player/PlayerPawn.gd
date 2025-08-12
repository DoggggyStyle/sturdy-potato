extends Node3D
@export var move_speed:float = 6.0
var _move_target: Vector3
var _has_target := false
func _ready() -> void:
	add_to_group('player_pawn')
func set_move_target(p: Vector3) -> void:
	_move_target = Vector3(p.x, 0.0, p.z)
	_has_target = true
func _process(delta: float) -> void:
	if _has_target:
		var to := _move_target - global_position
		to.y = 0.0
		var d := to.length()
		if d < 0.1:
			_has_target = false
			return
		var dir := to.normalized()
		global_position += dir * move_speed * delta
