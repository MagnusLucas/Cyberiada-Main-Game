extends Control
func _ready() -> void:
	$AudioStreamPlayer.play()

func _on_close_pressed() -> void:
	get_tree().paused = false
	$AudioStreamPlayer.play()
	visible = false
	await $AudioStreamPlayer.finished
	queue_free()


func _on_notebook_pressed() -> void:
	add_sibling(load("res://ui/HUD/notebook.tscn").instantiate())
	queue_free()


func _on_diary_pressed() -> void:
	add_sibling(load("res://ui/HUD/notebook/diary.tscn").instantiate())
	queue_free()
