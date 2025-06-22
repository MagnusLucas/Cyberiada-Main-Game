extends Control


func update_inv(inventory):
	#var position_in_inv : int = len(inventory)
	#get_node('PanelContainer/MarginContainer/Container/TextureRect'+str(position_in_inv+1)).texture =load("res://world/items/2d/"+inventory[position_in_inv]+".png")
	for i in range(len(inventory)):
		get_node('PanelContainer/MarginContainer/Container/TextureRect'+str(i+1)).texture =load("res://world/items/2d/"+inventory[int(i)]+".png")
		
