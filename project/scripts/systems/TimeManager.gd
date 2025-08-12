extends Node
class_name TimeManager

signal minute_tick
var clock := 0.0

func _process(delta: float) -> void:
    clock += delta
    if clock >= 60.0:
        clock -= 60.0
        emit_signal("minute_tick")
        CrimeSystem.decay(60.0)
