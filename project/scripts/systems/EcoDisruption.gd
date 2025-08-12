
extends Node
class_name EcoDisruption

signal route_broken(route_id)
signal route_restored(route_id)
signal price_shock(item, factor)

var routes := {} # id -> {"from":r1,"to":r2,"item":"med","active":true}
var econ # optional ref to EconomyController

func load_routes(path:String):
    var f = FileAccess.open(path, FileAccess.READ)
    if f: routes = JSON.parse_string(f.get_as_text())

func break_route(id:String):
    if not routes.has(id): return
    routes[id].active = false
    emit_signal("route_broken", id)
    _apply_price_shock(routes[id].item, 1.3)

func restore_route(id:String):
    if not routes.has(id): return
    routes[id].active = true
    emit_signal("route_restored", id)
    _apply_price_shock(routes[id].item, 0.9)

func _apply_price_shock(item:String, factor:float):
    emit_signal("price_shock", item, factor)
    # Caller can adjust EconomyController.demand/prices accordingly
