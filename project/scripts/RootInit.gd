extends Node

func _ready():
    call_deferred("_ensure_singletons_and_hud")

func _ensure_singletons_and_hud():
    if not has_node("/root/WantedSystem"):
        var ws = preload("res://scripts/systems/WantedSystem.gd").new()
        ws.name = "WantedSystem"
        get_tree().root.add_child(ws)
    if not has_node("/root/Stealth"):
        var st = preload("res://scripts/systems/Stealth.gd").new()
        st.name = "Stealth"
        get_tree().root.add_child(st)
    if get_tree().root.find_child("StealthHUD", true, false) == null:
        var hud = preload("res://scenes/ui/StealthHUD.tscn").instantiate()
        get_tree().root.call_deferred("add_child", hud)
