extends Node
class_name ModLoader

var mod_paths: Array = []

func _ready() -> void:
    _scan("res://Workshop_Templates")
    _scan("user://mods")

func _scan(root: String) -> void:
    var dir := DirAccess.open(root)
    if dir == null: return
    for f in dir.get_files():
        if f.ends_with(".pck"):
            ProjectSettings.load_resource_pack(root + "/" + f)
