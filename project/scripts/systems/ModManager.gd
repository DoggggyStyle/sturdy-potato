
extends Node
class_name ModManager

signal mod_loaded(id)
signal mod_failed(id, reason)

var mods_dir := "res://mods/"
var loaded := []

func scan_and_load():
    var dir = DirAccess.open(mods_dir)
    if dir == null: return
    dir.list_dir_begin()
    var name = dir.get_next()
    while name != "":
        if name.ends_with(".pck") or name.ends_with(".zip"):
            var full = mods_dir + name
            if ProjectSettings.load_resource_pack(full):
                loaded.append(full)
                emit_signal("mod_loaded", full)
            else:
                emit_signal("mod_failed", full, "load_failed")
        name = dir.get_next()
