
extends Node
class_name LoreFragments

signal fragment_collected(id)
signal set_completed(set_id)

var sets := {} # set_id -> {"ids":[...],"owned":{},"reward":{}}

func load_sets(path:String):
    var f = FileAccess.open(path, FileAccess.READ)
    if f: sets = JSON.parse_string(f.get_as_text())

func collect(set_id:String, frag_id:String):
    if not sets.has(set_id): return
    sets[set_id].owned[frag_id] = true
    emit_signal("fragment_collected", frag_id)
    if _complete(set_id):
        emit_signal("set_completed", set_id)

func _complete(set_id:String)->bool:
    var s = sets[set_id]
    for fid in s.ids:
        if not s.owned.has(fid): return false
    return true
