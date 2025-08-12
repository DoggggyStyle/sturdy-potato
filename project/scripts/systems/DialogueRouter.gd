
extends Node
class_name DialogueRouter

@export var meme_path: NodePath
@export var paraphraser_path: NodePath

var meme: MemeDialect
var para: CyberParaphraser
var pool := []

func _ready():
    meme = get_node(meme_path)
    para = get_node(paraphraser_path)

func speak(npc:Dictionary, ctx:Dictionary) -> String:
    var raw = meme.pick(npc, ctx, pool)
    if raw == "": return ""
    return para.stylize(raw)
