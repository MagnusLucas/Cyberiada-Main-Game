extends VBoxContainer


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")



func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/settings/controls/controls.tscn")


func _on_graphics_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/settings/graphics/graphics.tscn")


func _on_sound_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/settings/sound/sound.tscn")
