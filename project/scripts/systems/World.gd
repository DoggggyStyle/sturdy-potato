extends Node
class_name World

var world_state := {
    "year": 2025, "month": 8, "day": 12
}

func get_world_state() -> Dictionary:
    return world_state
