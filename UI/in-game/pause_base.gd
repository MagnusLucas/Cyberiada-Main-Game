extends VBoxContainer

@export_file var settings = "res://UI/shared/settings/settings.tscn"

func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/menu/main_menu.tscn")

func _on_back_pressed() -> void:
	get_tree().paused = false
	$"../../..".queue_free()

func _on_settings_pressed() -> void:
	var settings_scene = load(settings).instantiate()
	add_sibling(settings_scene)
	queue_free()
	settings_scene.back = "res://UI/in-game/pause_base.tscn"


func _on_save_pressed() -> void:
	var path = 'save_file_' + str(Globals.save_slot) + '.plik'
	var file = FileAccess.open(path, FileAccess.WRITE)
	
	Globals.game_data["inventory"] = get_node(Globals.CHARACTER_NODE_POSITION).inv
	Globals.game_data["dialogues_state"] = get_node(Globals.CHARACTER_NODE_POSITION).dialogues_state
	
	Globals.game_data["act"] = Globals.act
	
	var string = JSON.stringify(Globals.game_data, "\t")
	file.store_string(string)
	file.close()
