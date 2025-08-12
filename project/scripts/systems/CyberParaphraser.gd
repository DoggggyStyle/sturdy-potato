
extends Node
class_name CyberParaphraser

# Light-weight stylistic paraphraser for 'cyber fashion' tone.
var map = {
    "自由":"脱管", "雨":"酸雾", "风":"电流", "夜":"断电时段",
    "爱":"权限", "心":"核心", "梦":"缓存", "路":"数据流"
}

func stylize(text:String)->String:
    var t = text
    for k in map.keys():
        t = t.replace(k, map[k])
    return t
