extends Node
class_name CrimeSystem

signal crime_committed(actor, crime_type, value)
signal wanted_level_changed(level)

var wanted_level := 0
var crimes := {
    "theft": 5, "assault": 15, "murder": 50, "cyber_intrusion": 10
}

func report_crime(actor: Node, kind: String) -> void:
    if not crimes.has(kind): return
    wanted_level += crimes[kind]
    emit_signal("crime_committed", actor, kind, crimes[kind])
    emit_signal("wanted_level_changed", wanted_level)
