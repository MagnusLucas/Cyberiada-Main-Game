extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_inv(inventory):
	print_debug('updateinv')
	
	for i in range(len(inventory)):
		print_debug(inventory[int(i)])
		get_node('PanelContainer/MarginContainer/Container/TextureRect'+str(i+1)).texture =load("res://world/items/2d/"+inventory[int(i)]+".png")
		
