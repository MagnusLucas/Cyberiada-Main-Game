extends VBoxContainer

func _input(event: InputEvent) -> void:
	if visible and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		hide()
