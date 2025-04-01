extends Node3D
@export_file("*.tscn") var next_scene : String
#@export var next_scene : String
#CLASA NEXT SCENE JESZCZE NIE DZIAŁA i chuj wie czemu nie
var can_take : bool
func _ready() -> void:
	can_take = true

func taken():
	#evar next_scene := preload("res://world/places/test_level.tscn")
	var nexter = load(next_scene)
	#print(stara,next_scene.resource_path)
	#print(self.next_scene.path)
	#print(self.next_scene.resource_path)
	#nexter = self.next_scene
	#print('chuj')
	#nagle zaczełø magicznie działa¢, czemu hahahaha nie wiem
	print(next_scene,' hohoho ', nexter)
	#can_take = false
	$AudioStreamPlayer3D.play()
	#print(self.next_scene)
	get_tree().change_scene_to_packed(nexter)
