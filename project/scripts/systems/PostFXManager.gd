extends Node
class_name PostFXManager

# Safe no-op manager to avoid opening empty paths on boot.
# Replace later with full implementation once presets are configured.

func _ready():
    # Do nothing on boot; prevents FileAccess.open("") errors.
    pass

# Optional API placeholders so other code won't crash if they call into this.
func load_presets(path:String) -> void:
    if path == "": return

func apply_preset(name:String) -> void:
    pass
