extends Node
func apply_profile(p: Dictionary) -> void:
	if p.has("resolution"):
		DisplayServer.window_set_size(p.resolution)
	if p.has("vsync"):
		DisplayServer.window_set_vsync_mode(p.vsync : DisplayServer.VSYNC_ENABLED : DisplayServer.VSYNC_DISABLED)
