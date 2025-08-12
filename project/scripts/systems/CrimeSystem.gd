extends Node
class_name CrimeSystem
signal wanted_level_changed(new_level:int)
@export var max_wanted:int = 5
var wanted_level:int = 0
func add_crime(points:int)->void:
    wanted_level = clampi(wanted_level + points, 0, max_wanted)
    emit_signal("wanted_level_changed", wanted_level)
func decay(delta:float)->void:
    if wanted_level>0:
        wanted_level = max(wanted_level - int(delta), 0)
