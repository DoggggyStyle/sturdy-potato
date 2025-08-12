extends Node
class_name LimbSystem

const LIMBS := ["head", "torso", "arm_l", "arm_r", "leg_l", "leg_r"]

func apply_hit(unit: Node, limb: String, dmg: float) -> Dictionary:
    var state := unit.get("limb_state")
    if not state: state = {}
    var hp := float(state.get(limb, 100.0)) - dmg
    state[limb] = hp
    unit.set("limb_state", state)
    var lost := (hp <= -50.0) # 过量伤害触发断肢
    return {"limb": limb, "hp": hp, "dismembered": lost}
