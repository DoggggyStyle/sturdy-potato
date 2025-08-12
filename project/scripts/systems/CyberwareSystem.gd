extends Node
class_name CyberwareSystem

func install(unit: Node, slot: String, id: String, stats: Dictionary) -> void:
    var gear := unit.get("cyberware") if unit.has_method("get") else {}
    gear[slot] = {"id": id, "stats": stats}
    unit.set("cyberware", gear)
