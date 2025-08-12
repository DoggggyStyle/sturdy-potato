extends Node
class_name PerfProbeLite

signal completed(stats: Dictionary)

@export var sample_seconds: float = 30.0
var t: float = 0.0
var frames: Array[float] = []

func _process(delta:float) -> void:
    t += delta
    var fps: float = float(Engine.get_frames_per_second())
    if fps < 1.0:
        fps = 1.0
    frames.push_back(fps)
    if t >= sample_seconds:
        var stats := _compute_stats(frames)
        emit_signal("completed", stats)
        queue_free()

func _compute_stats(arr: Array[float]) -> Dictionary:
    var n: int = arr.size()
    if n == 0:
        return {"avg":0.0,"min":0.0,"p1":0.0}
    var sumv: float = 0.0
    var minv: float = 1e9
    for v in arr:
        sumv += v
        if v < minv:
            minv = v
    var avg: float = sumv / float(n)
    var sorted: Array[float] = arr.duplicate()
    sorted.sort()
    var k: int = int(max(1.0, floor(float(n) * 0.01))) - 1
    if k < 0:
        k = 0
    var p1: float = sorted[k]
    return {"avg":avg,"min":minv,"p1":p1}
