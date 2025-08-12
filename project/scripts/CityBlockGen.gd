extends Node3D

@export var block_size:int = 5
@export var spacing:float = 12.0
@export var height_min:float = 4.0
@export var height_max:float = 24.0
@export var citizens:int = 12
@export var cops:int = 2
@export var disguises:int = 3

var NPCScene := preload("res://scripts/actors/NPC.gd")
var PoliceScene := preload("res://scripts/actors/Police.gd")
var DisguiseScene := preload("res://scripts/items/ItemDisguise.gd")

func _ready():
    call_deferred("_build_world")

func _build_world():
    randomize()
    _spawn_buildings()
    _spawn_people()
    _spawn_disguises()

func _spawn_buildings():
    var root = $"../Buildings"
    var road = get_parent().get_node("Road")
    var mat = road.material_override
    for x in range(-block_size, block_size+1):
        for z in range(-block_size, block_size+1):
            if (x+z) % 2 == 0: continue
            var h = randf() * (height_max - height_min) + height_min
            var m := MeshInstance3D.new()
            var box := BoxMesh.new()
            box.size = Vector3(6, h, 6)
            m.mesh = box
            m.material_override = mat
            m.position = Vector3(x*spacing, h*0.5, z*spacing)
            root.call_deferred("add_child", m)

func _spawn_people():
    var citizens_root = $"../Citizens"
    var cops_root = $"../Cops"
    for i in range(citizens):
        var n = NPCScene.new()
        n.name = "NPC_%d" % i
        n.position = Vector3(randf()*40-20, 0, randf()*40-20)
        n.add_to_group("npcs")
        citizens_root.call_deferred("add_child", n)
    for i in range(cops):
        var p = PoliceScene.new()
        p.name = "Police_%d" % i
        p.position = Vector3(randf()*40-20, 0, randf()*40-20)
        cops_root.call_deferred("add_child", p)

func _spawn_disguises():
    var root = get_parent()
    for i in range(disguises):
        var d = DisguiseScene.new()
        var mesh := MeshInstance3D.new()
        var box := BoxMesh.new(); box.size = Vector3(1,0.2,1)
        mesh.mesh = box
        d.call_deferred("add_child", mesh)
        d.position = Vector3(randf()*40-20, 0.1, randf()*40-20)
        root.call_deferred("add_child", d)
