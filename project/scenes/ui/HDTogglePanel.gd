
extends HBoxContainer
class_name HDTogglePanel

@export var hd_manager_path: NodePath = NodePath("/root/HDManager")

func _ready():
    _build()

func _build():
    for c in get_children():
        remove_child(c)
        c.queue_free()
    var label = Label.new()
    label.text = "高清材质包："
    add_child(label)
    var btn_on = Button.new()
    btn_on.text = "启用"
    btn_on.pressed.connect(func(): _apply_hd(true))
    add_child(btn_on)
    var btn_off = Button.new()
    btn_off.text = "关闭"
    btn_off.pressed.connect(func(): _apply_hd(false))
    add_child(btn_off)

func _apply_hd(v:bool):
    var mgr = get_node_or_null(hd_manager_path)
    if mgr:
        var ok = mgr.set_hd(v)
        if ok:
            print("[HD] ON")
        else:
            print("[HD] OFF or missing hd_textures.pck")
