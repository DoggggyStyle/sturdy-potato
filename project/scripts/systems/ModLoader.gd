extends Node
class_name ModLoader
@export var mods_dir := "res://mods"
func _ready()->void:
    var da := DirAccess.open(mods_dir)
    if da==null: return
    da.list_dir_begin()
    while true:
        var n := da.get_next()
        if n=="": break
        if n.begins_with("."): continue
        var p := mods_dir + "/" + n + "/mod.gd"
        if FileAccess.file_exists(p):
            var s = load(p)
            if s:
                var inst = s.new()
                add_child(inst)
    da.list_dir_end()
