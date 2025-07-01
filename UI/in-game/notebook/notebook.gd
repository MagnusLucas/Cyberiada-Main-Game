extends Control
class_name Notebook

static var data : Dictionary = {
	"diary" : {},
	"inhabitants" : {
		"anna" : {},
		"babcia" : {},
		"dorota" : {},
		"janek" : {},
		"kapral" : {},
		"marynarz" : {},
		"sierzant" : {},
		"sklepowa" : {}
	},
	"clues" : {},
	"places" : {
		"falowiec" : {},
		"gdansk" : {}
	}
}

func _ready() -> void:
	$AudioStreamPlayer.play()

func _on_close_pressed() -> void:
	get_tree().paused = false
	$AudioStreamPlayer.play()
	visible = false
	await $AudioStreamPlayer.finished
	queue_free()


func _on_notebook_pressed() -> void:
	$MarginContainer/MarginContainer2/pages/left.get_child(0).queue_free()
	$MarginContainer/MarginContainer2/pages/left.add_child(load("res://UI/in-game/notebook/navigation.tscn").instantiate())
	$MarginContainer/MarginContainer2/pages/right/info/HBoxContainer/back.hide()
	$MarginContainer/MarginContainer2/pages/right.update()
