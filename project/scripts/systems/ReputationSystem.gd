extends Node
class_name ReputationSystem
var rep := {} # {faction:String: int}
func add_rep(faction:String, delta:int)->void:
    rep[faction] = rep.get(faction,0) + delta
func get_rep(faction:String)->int:
    return rep.get(faction,0)
