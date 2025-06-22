extends VBoxContainer

@export_file var settings = "res://UI/menu/settings/settings/settings_base.tscn"

func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")

func _on_back_pressed() -> void:
	get_tree().paused = false
	$"../../..".queue_free()

func _on_settings_pressed() -> void:
	var settings = load(settings).instantiate()
	add_sibling(settings)
	settings.back = "res://UI/in-game/pause_base.tscn"
