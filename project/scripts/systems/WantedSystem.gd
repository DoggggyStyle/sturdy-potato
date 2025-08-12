extends Node

signal changed(level: float)

var level: float = 0.0
@export var max_level: float = 5.0
@export var decay_per_sec: float = 0.25

func _process(delta):
    if level > 0.0:
        level = max(0.0, level - decay_per_sec * delta)
        changed.emit(level)

func add_crime(amount: float) -> void:
    level = clamp(level + amount, 0.0, max_level)
    changed.emit(level)
