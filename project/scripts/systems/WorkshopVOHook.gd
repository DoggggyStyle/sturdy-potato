
extends Node
class_name WorkshopVOHook

@export var enabled := false

func try_play_vo(_line_id:String) -> void:
    # Intentionally no-op unless enabled and VO pack present
    if not enabled:
        return
    # If someone installs a VO pack mod, they can override this script or set enabled=true
    # and implement playback here.
    return
