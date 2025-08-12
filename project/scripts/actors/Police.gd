extends CharacterBody3D

@export var speed: float = 4.0
@export var leash: float = 80.0

var player: Node3D
var active := false

func _ready():
    var ws = get_node("/root/WantedSystem")
    ws.changed.connect(_on_wanted_changed)
    player = get_node_or_null("../FreecamPlayer")
    set_physics_process(false)

func _on_wanted_changed(lv: float) -> void:
    active = lv >= 1.0
    set_physics_process(active)

func _physics_process(delta):
    if not active or not player: return
    var to = (player.global_transform.origin - global_transform.origin)
    if to.length() > leash: return
    velocity = to.normalized() * speed
    move_and_slide()
