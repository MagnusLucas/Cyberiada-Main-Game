extends HBoxContainer



func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
