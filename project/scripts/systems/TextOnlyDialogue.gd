
extends Node
class_name TextOnlyDialogue

@export var dialogue_router_path: NodePath
@export var music_cue_path: NodePath

var router
var cue

func _ready():
    router = get_node(dialogue_router_path)
    cue = get_node_or_null(music_cue_path)

func speak(npc:Dictionary, ctx:Dictionary) -> String:
    # Force text-only: do not trigger any VO playback even if present
    var line = router.speak(npc, ctx)
    if cue:
        cue.on_line(npc, ctx, line)
    return line
