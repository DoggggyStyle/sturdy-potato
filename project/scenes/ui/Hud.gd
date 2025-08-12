extends Control

func _ready():
    var ws := get_node_or_null("/root/WantedSystem")
    if ws:
        ws.changed.connect(_on_wanted_changed)
        _on_wanted_changed(ws.level)

func _on_wanted_changed(lv: float) -> void:
    var stars: int = int(ceil(lv))
    var s := ""
    for i in stars:
        s += "*"
    $Label.text = "Wanted: " + s
