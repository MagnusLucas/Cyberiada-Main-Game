extends VBoxContainer

var sound = preload("res://ui/settings/sound/in_game.tscn")
var graphics = preload("res://ui/settings/graphics/in_game.tscn")
var controls = preload("res://ui/settings/controls/in_game.tscn")

func _on_sound_pressed() -> void:
	$"../../../..".add_child(sound.instantiate())


func _on_back_pressed() -> void:
	$"../../..".queue_free()


func _on_graphics_pressed() -> void:
	$"../../../..".add_child(graphics.instantiate())


func _on_controls_pressed() -> void:
	$"../../../..".add_child(controls.instantiate())
