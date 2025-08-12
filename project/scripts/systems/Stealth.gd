extends Node

signal meter_changed(value)

var meter := 0.0 # 0..1
var disguise := false # if true, slower detection

func set_meter(v):
    meter = clamp(v, 0.0, 1.0)
    meter_changed.emit(meter)
