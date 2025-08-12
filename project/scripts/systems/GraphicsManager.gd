extends Node
class_name GraphicsManager
func apply_profile(p:Dictionary) -> void:
	var vp := get_viewport()
	if vp and p.has('taa'):
		vp.use_taa = bool(p.get('taa', false))
