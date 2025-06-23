extends MarginContainer

var notebook = preload("res://UI/in-game/notebook/notebook.tscn")

func _on_notebook_pressed() -> void:
	get_tree().paused = true
	add_sibling(notebook.instantiate())


func update_inv(inventory):
	var item_belt = $MarginContainer/Container
	for i in range(len(inventory)):
		item_belt.get_child(i).get_child(0).texture =load("res://game/items/2d/"+inventory[int(i)]+".png")
