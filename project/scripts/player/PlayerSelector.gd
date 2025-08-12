extends Node
@export var selection_color := Color(0.2, 0.8, 1.0, 0.25)
var dragging := false
var drag_from := Vector2.ZERO
var drag_to := Vector2.ZERO
var _overlay : ColorRect

func _ready():
	_overlay = ColorRect.new()
	_overlay.color = Color(0,0,0,0)
	_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	get_tree().root.add_child(_overlay)

func _unhandled_input(e):
	if e is InputEventMouseButton and e.button_index == MOUSE_BUTTON_LEFT:
		if e.pressed:
			dragging = true
			drag_from = e.position
			drag_to = e.position
		else:
			dragging = false
			_overlay.color = Color(0,0,0,0)
			# TODO: 命中测试 -> 选择单位
	if e is InputEventMouseMotion and dragging:
		drag_to = e.position
		var rect := Rect2(drag_from, drag_to - drag_from).abs()
		_overlay.position = rect.position
		_overlay.size = rect.size
		_overlay.color = selection_color
