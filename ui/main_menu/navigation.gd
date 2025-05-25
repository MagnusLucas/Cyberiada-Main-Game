extends VBoxContainer


func _on_quit_pressed() -> void:
	$"../../../../AudioStreamPlayer".play()
	$"../../../../loading_screen".show()
	await $"../../../../AudioStreamPlayer".finished
	get_tree().quit()


func _on_load_pressed() -> void:
	$"../../../../AudioStreamPlayer".play()
	$"../../../../loading_screen".show()
	await $"../../../../AudioStreamPlayer".finished
	get_tree().change_scene_to_file("res://ui/saved_games/saved_games.tscn")


func _on_settings_pressed() -> void:
	$"../../../../AudioStreamPlayer".play()
	$"../../../../loading_screen".show()
	await $"../../../../AudioStreamPlayer".finished
	get_tree().change_scene_to_file("res://ui/settings/settings/settings.tscn")


func _on_new_game_pressed() -> void:
	$"../../../../AudioStreamPlayer".play()
	$"../../../../loading_screen".show()
	await $"../../../../AudioStreamPlayer".finished
	get_tree().change_scene_to_file("res://game.tscn")
