
extends Node

func _ready():
    var args = OS.get_cmdline_args()
    if "--static-checks" in args and OS.has_feature("headless"):
        var s = preload("res://scripts/ci/StaticChecks.gd").new()
        add_child(s)
        var res = await s.done
        var ok = res["fails"].size() == 0
        if ok:
            get_tree().quit(0)
        else:
            get_tree().quit(1)
