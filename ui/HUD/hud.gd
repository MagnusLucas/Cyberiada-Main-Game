extends MarginContainer

var notebook = preload("res://ui/HUD/notebook.tscn")

func _on_notebook_pressed() -> void:
	get_tree().paused = true
	add_sibling(notebook.instantiate())
	
