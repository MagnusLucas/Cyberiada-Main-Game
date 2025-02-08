extends VBoxContainer


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_load_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/saved_games/saved_games.tscn")
