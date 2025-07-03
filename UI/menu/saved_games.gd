extends VBoxContainer



#load zapisu próba
func _on_button_pressed() -> void:
	var path = 'save_file_' + str(Globals.save_slot) + '.plik'
	var file = FileAccess.open(path, FileAccess.READ)
	
	
	var json_string = file.get_as_text()
	if !JSON.parse_string(json_string):
		print_debug("ERROR! This save file data is corrupt!")
		return
	Globals.game_data = JSON.parse_string(json_string)
	print_debug(Globals.game_data)
	file.close()



	
