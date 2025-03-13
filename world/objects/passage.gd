extends Node3D
@export var next_scene : PackedScene
#CLASA NEXT SCENE JESZCZE NIE DZIAŁA i chuj wie czemu nie

var can_take = true
func taken():
	#evar next_scene := preload("res://world/places/test_level.tscn")
	var nexter = load("res://world/places/test_level.tscn")
	print('chuj')
	can_take = false
	$AudioStreamPlayer3D.play()
	print(self.next_scene)
	get_tree().change_scene_to_packed(nexter)
