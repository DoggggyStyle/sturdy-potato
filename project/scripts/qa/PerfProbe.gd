
extends Node
class_name PerfProbe

# Collects frametime & FPS for N seconds. Writes CSV: user://perf_probe.csv

@export var sample_seconds := 30.0
var t := 0.0
var frames := []

func _process(delta:float) -> void:
    t += delta
    var fps = Engine.get_frames_per_second()
    frames.append({"t":t, "fps":fps, "dt_ms":delta*1000.0})
    if t >= sample_seconds:
        _save_and_quit()

func _save_and_quit():
    var f = FileAccess.open("user://perf_probe.csv", FileAccess.WRITE)
    if f:
        f.store_line("t_seconds,fps,dt_ms")
        for row in frames:
            f.store_line("%s,%s,%s" % [str(row.t), str(row.fps), str(row.dt_ms)])
    print("[PerfProbe] Saved user://perf_probe.csv")
    get_tree().quit()
