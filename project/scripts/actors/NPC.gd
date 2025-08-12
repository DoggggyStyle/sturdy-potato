extends CharacterBody3D

var speed := 3.0
var roam_radius := 20.0
var target := Vector3.ZERO
var wallet := 10

func _ready():
    target = global_transform.origin

func _physics_process(delta):
    if (global_transform.origin.distance_to(target) < 0.5) or randi()%200==0:
        var rand = Vector3(randf()*2.0-1.0, 0, randf()*2.0-1.0).normalized()
        target = Vector3(0,0,0) + rand * roam_radius
    var dir = (target - global_transform.origin).normalized()
    velocity = dir * speed
    move_and_slide()
    _perceive()

func _perceive():
    # RTS 视角：追踪玩家单位（PlayerPawn），而不是摄像机
    var player := get_tree().get_first_node_in_group("player_pawn")
    if player == null:
        player = get_tree().get_root().find_child("PlayerPawn", true, false)
    if player == null:
        return

    var to_player: Vector3 = (player.global_transform.origin - global_transform.origin)
    var dist: float = to_player.length()

    var st = get_node("/root/Stealth")

    var noise := 0.5
    if player.has_method("get_noise_level"):
        noise = player.get_noise_level()

    # 视野判定（半锥）
    var forward = global_transform.basis.z * -1.0
    var angle_ok = forward.normalized().dot(to_player.normalized()) > 0.6
    var vision = angle_ok and dist < (14.0 * (1.3 if st.disguise else 1.0))

    # 听觉判定（半径×噪音）
    var hearing = dist < (6.0 * noise)

    var detected = vision or hearing
    st.set_meter( max(st.meter, clamp( (1.0 - dist/14.0) if detected else st.meter*0.95, 0.0, 1.0) ) )
    if detected and dist < 3.0:
        var ws = get_node("/root/WantedSystem")
        ws.add_crime(0.1)

func steal_wallet():
    if wallet > 0:
        wallet = 0
