extends Control
class_name Notebook

static var data : Dictionary

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


func _on_inhabitants_pressed() -> void:
	add_sibling(load("res://ui/HUD/notebook/inhabitants.tscn").instantiate())
	queue_free()


func _on_items_pressed() -> void:
	add_sibling(load("res://ui/HUD/notebook/clues.tscn").instantiate())
	queue_free()


func _on_places_pressed() -> void:
	add_sibling(load("res://ui/HUD/notebook/places.tscn").instantiate())
	queue_free()
