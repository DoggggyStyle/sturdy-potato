extends Node
class_name EconomySystem
@export var base_prices := {"food":10,"med":50,"chip":200}
func get_price(item:String, scarcity:float=1.0)->int:
    return int( round( (base_prices.get(item,10)) * max(0.2,scarcity) ) )
