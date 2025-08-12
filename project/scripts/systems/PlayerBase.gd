
extends Node
class_name PlayerBase

signal base_acquired(id)
signal upgrade_applied(id, tier)
signal decor_changed(slot, decor_id)

var owned := false
var id := "default_hideout"
var tier := 0
var decor := {} # "slot"-> decor_id

func acquire(base_id:String="default_hideout"):
    owned = true; id = base_id; tier = 1
    emit_signal("base_acquired", id)

func upgrade():
    if not owned: return
    tier = clamp(tier+1, 1, 5)
    emit_signal("upgrade_applied", id, tier)

func set_decor(slot:String, decor_id:String):
    decor[slot] = decor_id
    emit_signal("decor_changed", slot, decor_id)
