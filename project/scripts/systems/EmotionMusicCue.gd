
extends Node
class_name EmotionMusicCue

signal profile_requested(profile_id)
signal layer_boost(layer_id, amount)

@export var enable_layer_boost := true

func on_line(npc:Dictionary, ctx:Dictionary, text:String) -> void:
    if text == null or text.strip_edges() == "":
        return
    var mood := "neutral"
    if npc.has("mood"):
        mood = str(npc["mood"])
    var scene := "idle"
    if ctx.has("scene"):
        scene = str(ctx["scene"])

    match mood:
        "angry":
            emit_signal("layer_boost", "drums", 0.35)
        "afraid":
            emit_signal("layer_boost", "fx", 0.25)
        "happy":
            emit_signal("layer_boost", "lead", 0.3)
        _:
            pass

    if scene == "boss_intro":
        emit_signal("profile_requested", "haute")
    elif scene == "wasteland":
        emit_signal("profile_requested", "neo_folk")
    elif scene == "night_talk":
        emit_signal("profile_requested", "noir_jazz")
