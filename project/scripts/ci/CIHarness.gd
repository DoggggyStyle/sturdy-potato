
extends Node
class_name CIHarness

@export var enable := true

func _ready():
    if not enable: return
    var args = OS.get_cmdline_args()
    if OS.has_feature("headless") and "--ci" in args:
        _run_ci(args)

func _arg_val(args:Array, key:String, def):
    for i in range(args.size()):
        if args[i] == key and i+1 < args.size():
            return args[i+1]
    return def

func _run_ci(args:Array) -> void:
    print("[CI] Starting CI harness")
    var loops = int(_arg_val(args,"--loop","10"))
    var seconds = float(_arg_val(args,"--seconds","30"))
    var profile = str(_arg_val(args,"--profile","Balanced"))
    var outdir = str(_arg_val(args,"--out","user://ci"))
    var strict = bool(_arg_val(args,"--strict","true") == "true")
    DirAccess.make_dir_recursive_absolute(outdir)

    var results := []
    var pass_all := true
    for i in range(loops):
        # Apply graphics profile via autoload instance to avoid class/static mixup
        if has_node("/root/GraphicsManager"):
            var gm = get_node("/root/GraphicsManager")
            if gm and gm.has_method("apply_profile"):
                gm.apply_profile(profile)
        var p := preload("res://scripts/ci/PerfProbeLite.gd").new()
        p.sample_seconds = seconds
        add_child(p)
        var stats = await p.completed
        results.append(stats)
        print("[CI] Loop %s: avg=%.2f fps, 1%%low=%.2f, min=%.2f" % [str(i+1), stats["avg"], stats["p1"], stats["min"]])
        if stats["avg"] < 55.0 or stats["p1"] < 40.0:
            pass_all = false

    var summary := {
        "profile": profile,
        "loops": loops,
        "seconds_each": seconds,
        "thresholds": {"avg>=55": true, "p1>=40": true},
        "pass": pass_all,
        "runs": results
    }
    var f = FileAccess.open(outdir + "/summary.json", FileAccess.WRITE)
    if f: f.store_string(JSON.stringify(summary, "\t"))

    if strict and not pass_all:
        print("[CI] FAIL: thresholds not met.")
        get_tree().quit(1)
    else:
        print("[CI] PASS")
        get_tree().quit(0)
