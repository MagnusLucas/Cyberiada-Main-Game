extends GraphEdit

var add_menu = preload("res://world/NPCs/dialog_maker/add_menu.tscn")

func _ready() -> void:
	OS.low_processor_usage_mode = true

func clicked(event: InputEvent, button_index: int):
	return event is InputEventMouseButton and event.pressed == true and event.button_index == button_index

func _on_gui_input(event: InputEvent) -> void:
	if clicked(event, MOUSE_BUTTON_RIGHT):
		if has_node("AddMenu"):
			get_node("AddMenu").queue_free()
		elif has_node("AddMenu2"):
			get_node("AddMenu2").queue_free()
		var menu_position = get_local_mouse_position()
		var menu = add_menu.instantiate()
		menu.position = menu_position
		add_child(menu, true)
