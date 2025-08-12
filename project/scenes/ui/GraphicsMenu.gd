extends Control

func _ready() -> void:
    if get_child_count() == 0:
        var v = VBoxContainer.new()
        v.anchor_right = 1.0
        v.anchor_bottom = 1.0
        v.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        v.size_flags_vertical = Control.SIZE_EXPAND_FILL
        add_child(v)
        var title := Label.new()
        title.text = "Ultimate Hacker — Menu"
        title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
        v.add_child(title)
        var btn_city := Button.new()
        btn_city.text = "Enter City Block (vertical slice)"
        btn_city.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/city/CityBlock.tscn"))
        v.add_child(btn_city)
        var btn_quit := Button.new()
        btn_quit.text = "Quit"
        btn_quit.pressed.connect(func(): get_tree().quit())
        v.add_child(btn_quit)
