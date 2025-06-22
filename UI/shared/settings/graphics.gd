extends MarginContainer

@export_file var back = "res://UI/shared/settings/settings.tscn"

func _ready() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		$VBoxContainer/HBoxContainer/fullscreen.button_pressed = true

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_back_pressed() -> void:
	add_sibling(load(back).instantiate())
	queue_free()
