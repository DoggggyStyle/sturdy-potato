extends Control

func _ready():
    var st = get_node("/root/Stealth")
    st.meter_changed.connect(_on_meter)
    _on_meter(st.meter)

func _on_meter(v):
    $HBox/Bar.value = int(v * 100.0)
    $HBox/Label.text = "STEALTH " + str(int(v*100)) + "%"
