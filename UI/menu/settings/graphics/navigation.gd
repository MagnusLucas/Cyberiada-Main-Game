extends HBoxContainer


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/settings/settings/settings.tscn")


func _on_save_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/settings/settings/settings.tscn")
