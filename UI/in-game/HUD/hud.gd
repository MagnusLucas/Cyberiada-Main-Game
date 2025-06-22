extends MarginContainer

var notebook = preload("res://UI/in-game/HUD/notebook.tscn")

func _on_notebook_pressed() -> void:
	get_tree().paused = true
	add_sibling(notebook.instantiate())


func update_inv(inventory):
	var item_belt = $items/PanelContainer/MarginContainer/Container
	for i in range(len(inventory)):
		item_belt.get_child(i).texture =load("res://world/items/2d/"+inventory[int(i)]+".png")
