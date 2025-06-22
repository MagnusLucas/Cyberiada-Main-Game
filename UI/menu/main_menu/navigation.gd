extends VBoxContainer

func _ready() -> void:
	Sound.play_music()

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_load_pressed() -> void:
	Sound.play_sfx()
	get_tree().change_scene_to_file("res://ui/saved_games/saved_games.tscn")


func _on_settings_pressed() -> void:
	Sound.play_sfx()
	get_tree().change_scene_to_file("res://UI/menu/settings/settings/settings.tscn")


func _on_new_game_pressed() -> void:
	Sound.play_sfx()
	get_tree().change_scene_to_file("res://UI/in-game/prolog/prolog.tscn")
