extends Node3D

#var pause = preload("res://ui/settings/in_game/pause.tscn")


#func _input(event: InputEvent) -> void:
	#if event is InputEventKey and event.keycode == KEY_ESCAPE and event.is_pressed():
		#add_child(pause.instantiate())
		#get_tree().paused = true
