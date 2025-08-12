
extends Control
class_name PostFXStudio

@export var manager_path: NodePath
var mgr: PostFXManager

func _ready():
    mgr = get_node(manager_path)
    _build_ui()

func _build_ui():
    var presets = ["Performance","Balanced","Haute","Noir","Wasteland","StealthNight","BossIntro"]
    var hb = HBoxContainer.new()
    add_child(hb)
    for p in presets:
        var b = Button.new()
        b.text = p
        b.pressed.connect(func(): mgr.apply_preset(p))
        hb.add_child(b)
