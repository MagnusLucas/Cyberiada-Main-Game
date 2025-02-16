extends VBoxContainer


func _on_menu_pressed() -> void:
	_on_save_pressed()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")


func _on_save_pressed() -> void:
	pass # Replace with function body.


func _on_back_pressed() -> void:
	get_tree().paused = false
	$"../../..".queue_free()
