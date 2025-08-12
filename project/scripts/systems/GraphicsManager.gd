# Runtime graphics settings manager (Godot 4.4 compatible)
extends Node
class_name GraphicsManager

# Apply a simple profile dictionary, e.g. {"taa": true}
func apply_profile(p: Dictionary) -> void:
    var vp := get_viewport()
    if vp and p is Dictionary:
        if p.has("taa"):
            vp.use_taa = bool(p.get("taa", false))
    # FXAA/MSAA 项目级开关后续通过 ProjectSettings 或渲染器设置统一处理，这里不直接改。

