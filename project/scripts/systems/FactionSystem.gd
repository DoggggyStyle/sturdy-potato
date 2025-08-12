extends Node
class_name FactionSystem
@export var factions:= {
    "CityGuard":{"hostile_to":["Gangs"]},
    "Gangs":{"hostile_to":["CityGuard"]},
    "Merchants":{"hostile_to":[]}
}
func are_hostile(a:String,b:String)->bool:
    return b in (factions.get(a,{}).get("hostile_to",[]))
