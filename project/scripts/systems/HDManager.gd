
extends Node
class_name HDManager

const PCK_PATH := "hd_textures.pck"
var loaded := false

signal hd_toggled(on)

func _ready():
    var want_hd = ProjectSettings.get_setting("application/ultimate/hd_pack", false)
    if want_hd and FileAccess.file_exists(PCK_PATH):
        loaded = ProjectSettings.load_resource_pack(PCK_PATH, false)
        emit_signal("hd_toggled", loaded)

func set_hd(on:bool) -> bool:
    if on:
        if loaded: return true
        if FileAccess.file_exists(PCK_PATH):
            loaded = ProjectSettings.load_resource_pack(PCK_PATH, false)
        else:
            loaded = false
    else:
        # Godot 4 没有可靠的 unload API；标记为未启用，建议重启生效
        loaded = false
    emit_signal("hd_toggled", loaded)
    ProjectSettings.set_setting("application/ultimate/hd_pack", loaded)
    ProjectSettings.save()
    return loaded
