extends StaticBody3D
#can_take - checks if item is still on the ground (and not alr picked up)
var can_take = true
# Called every frame. 'delta' is the elapsed time since the previous frame.

func taken():
	can_take = false
	if len($"../character".inv) <=5:
		$"../character".inv.append(get_name())
	#print(name)
	queue_free()
	get_node("../InLevelUi").update_inv($"../character".inv)
