extends VBoxContainer

@export_file var settings = "res://UI/shared/settings/settings.tscn"

func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")

func _on_back_pressed() -> void:
	get_tree().paused = false
	$"../../..".queue_free()

func _on_settings_pressed() -> void:
	var settings_scene = load(settings).instantiate()
	add_sibling(settings_scene)
	queue_free()
	settings_scene.back = "res://UI/in-game/pause_base.tscn"
