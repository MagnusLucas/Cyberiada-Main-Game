extends StaticBody3D
#can_take - checks if item is still on the ground (and not alr picked up)
var can_take = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
@onready var character = $"../../character"

func taken():
	can_take = false
	if len(character.inv) <=5:
		character.inv.append(get_name())
	visible = false
	$AudioStreamPlayer.play()
	get_node("../../character/HUD/InLevelUi").update_inv(character.inv)
	await $AudioStreamPlayer.finished
	#print(name)
	queue_free()
	
	
