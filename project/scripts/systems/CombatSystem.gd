extends Node
class_name CombatSystem

enum DamageKind { CUT=0, BLUNT=1, PIERCE=2, ENERGY=3, FIRE=4 }

func compute_damage(base: float, kind: int, armor: Dictionary) -> float:
    var resist := float(armor.get(str(kind), 0.0))
    return max(0.0, base * (1.0 - clamp(resist, 0.0, 0.9)))
