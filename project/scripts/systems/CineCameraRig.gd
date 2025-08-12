extends Node
class_name CineCameraRig

@export var camera_path: NodePath
@export var enable_breathing := true
@export var breathing_speed := 0.35
@export var breathing_amount_fov := 0.6 # degrees
@export var enable_jitter := true
@export var jitter_pos := 0.002
@export var jitter_rot_deg := 0.05
@export var jitter_speed := 22.0

var cam

func _ready():
    cam = get_node_or_null(camera_path)

func _process(delta):
    if cam == null: return
    if enable_breathing:
        var t = Time.get_ticks_msec() / 1000.0
        var fov0 = cam.fov if cam.has_method("fov") else 70.0
        var offset = sin(t * breathing_speed) * breathing_amount_fov
        if "fov" in cam:
            cam.fov = fov0 + offset
    if enable_jitter:
        var tt = Time.get_ticks_msec() / 1000.0 * jitter_speed
        var jx = (randf() - 0.5) * jitter_pos
        var jy = (randf() - 0.5) * jitter_pos
        cam.translate_object_local(Vector3(jx, jy, 0))
        cam.rotate_z(deg_to_rad((randf()-0.5) * jitter_rot_deg))