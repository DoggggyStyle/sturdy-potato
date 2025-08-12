extends Node

func _ready() -> void:
	var root := get_tree().current_scene
	if root == null: return

	if root.get_node_or_null("RTSCamera") == null:
		var cam := Camera3D.new()
		cam.name = "RTSCamera"
		cam.position = Vector3(0, 25, 25)
		cam.look_at(Vector3(0,0,0), Vector3.UP)
		cam.set_script(load("res://scripts/camera/RTSCamera.gd"))
		root.add_child(cam)

	if root.get_node_or_null("PlayerSelector") == null:
		var sel := Node.new()
		sel.name = "PlayerSelector"
		sel.set_script(load("res://scripts/player/PlayerSelector.gd"))
		root.add_child(sel)
