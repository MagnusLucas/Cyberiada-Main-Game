extends VBoxContainer

func _ready() -> void:
	for button in get_children():
		if button is Button:
			button.connect("pressed", _on_date_pressed.bind(button))
	

func _on_date_pressed() -> void:
	pass
