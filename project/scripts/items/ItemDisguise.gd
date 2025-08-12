extends Area3D

func _ready():
    monitoring = true
    connect("body_entered", Callable(self, "_on_enter"))

func _on_enter(body):
    if body == null: return
    var st = get_node("/root/Stealth")
    st.disguise = true
    queue_free()
