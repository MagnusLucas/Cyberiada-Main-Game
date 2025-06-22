extends VBoxContainer

@export_file var controls = "res://UI/shared/settings/controls.tscn"
@export_file var graphics = "res://UI/shared/settings/graphics.tscn"
@export_file var sound = "res://UI/shared/settings/sound.tscn"
@export_file var back = ""

func _on_back_pressed() -> void:
	if back == "":
		get_tree().change_scene_to_file("res://UI/menu/main_menu.tscn")
	else:
		add_sibling(load(back).instantiate())
		queue_free()


func _on_controls_pressed() -> void:
	add_sibling(load(controls).instantiate())
	queue_free()

func _on_graphics_pressed() -> void:
	add_sibling(load(graphics).instantiate())
	queue_free()

func _on_sound_pressed() -> void:
	add_sibling(load(sound).instantiate())
	queue_free()
