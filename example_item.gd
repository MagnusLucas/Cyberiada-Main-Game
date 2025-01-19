extends StaticBody3D
#can_take - checks if item is still on the ground (and not alr picked up)
var can_take = true
# Called every frame. 'delta' is the elapsed time since the previous frame.

func taken():
	can_take = false
	print('example_item')
	queue_free()
