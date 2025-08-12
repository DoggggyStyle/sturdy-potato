
extends Node
class_name LayeredMixer

# Simple layered music controller
@export var buses := ["music_base","music_drums","music_lead","music_fx"]

func set_profile(p:Dictionary):
    # p: {"base":"res://...", "drums":"...", ...}
    for k in p.keys():
        var pth = p[k]
        if pth=="":
            continue
        var pstream = load(pth)
        var pplayer = AudioStreamPlayer.new()
        pplayer.stream = pstream
        add_child(pplayer)
        pplayer.bus = k if buses.has(k) else "Master"
        pplayer.play()
