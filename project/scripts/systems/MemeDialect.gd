
extends Node
class_name MemeDialect

# Picks lines based on culture, personality, mood, with cooldown & anti-repeat.
signal line_picked(npc_id, text)

var cooldown := {}
var last_lines := {}

func pick(npc:Dictionary, ctx:Dictionary, pool:Array) -> String:
    # npc: {id,culture,personality:[],style:[],mood}
    # ctx: {scene, weather, combat, notoriety}
    var cand := []
    for l in pool:
        if not _match(npc, ctx, l):
            continue
        if _on_cd(l.id):
            continue
        cand.append(l)
    if cand.size()==0:
        return ""
    cand.shuffle()
    var best = cand.front()
    _mark_cd(best.id, best.cooldown_s if "cooldown_s" in best else 240)
    last_lines[npc.id] = best.id
    emit_signal("line_picked", npc.id, best.text)
    return best.text

func _match(npc, ctx, l)->bool:
    if "culture" in l and npc.culture != l.culture: return false
    if "layer" in l and l.layer=="显梗" and randf() > 0.25: return false
    if "tags" in l and "context" in l.tags and ctx.scene not in l.tags.context: return false
    return true

func _on_cd(id:String)->bool:
    return id in cooldown and cooldown[id] > Time.get_unix_time_from_system()

func _mark_cd(id:String, seconds:int):
    cooldown[id] = Time.get_unix_time_from_system()+seconds
