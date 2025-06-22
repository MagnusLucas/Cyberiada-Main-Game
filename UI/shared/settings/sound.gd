extends VBoxContainer

@export_file var back = "res://UI/shared/settings/settings.tscn"

func _on_master_drag_ended(_value_changed: bool) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), $MarginContainer2/VBoxContainer/master.value/100)

func _on_music_drag_ended(_value_changed: bool) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), $MarginContainer3/VBoxContainer/music.value/100)
	
func _on_sfx_drag_ended(_value_changed: bool) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), $MarginContainer4/VBoxContainer/sfx.value/100)


func _on_back_pressed() -> void:
	add_sibling(load(back).instantiate())
	queue_free()
