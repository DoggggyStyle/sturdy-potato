
extends Control
class_name LUTQuickPanel

@export var manager_path: NodePath
var mgr

func _ready():
    mgr = get_node(manager_path)
    var names = ["RunwayGold","ChromeBlue","GritAmber","MonoSilver"]
    var hb = HBoxContainer.new()
    add_child(hb)
    for n in names:
        var b = Button.new()
        b.text = n
        b.pressed.connect(func():
            var p = load("res://assets/noai_beautify/postfx_presets.json")
            mgr.apply_preset(n)
            # load LUT from presets
            var f = FileAccess.open("res://assets/noai_beautify/postfx_presets.json", FileAccess.READ)
            if f:
                var data = JSON.parse_string(f.get_as_text())
                if data.has(n) and data[n].has("lut"):
                    mgr.set_lut(data[n]["lut"], 32.0)
                if data[n].has("dof"):
                    mgr.enable_dof(data[n]["dof"], data[n].get("dof_focus",0.5), data[n].get("dof_strength",1.2), 1.5)
        )
        hb.add_child(b)
