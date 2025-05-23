extends StaticBody3D
@export_file("*.tscn") var next_scene : String
#@export var next_scene : String
#CLASA NEXT SCENE JESZCZE NIE DZIAŁA i chuj wie czemu nie

#dźwiękowe wariable
#var options = ["otwieranie_zamka_kluczem_1.wav","otwieranie_zamka_kluczem_2.wav","otwieranie_zamka_kluczem_3.wav"]
#var chosen = options[randi() % options.size()]
var audio_path = "res://audio/otwieranie_zamka_kluczem_"+str(randi_range(1,3))+".wav"



var can_take : bool
func _ready() -> void:
	can_take = true

func taken():
	#evar next_scene := preload("res://world/places/test_level.tscn")
	
	#print(stara,next_scene.resource_path)
	#print(self.next_scene.path)set_stream
	#print(self.next_scene.resource_path)
	#nexter = self.next_scene
	#print('chuj')
	#nagle zaczełø magicznie działa¢, czemu hahahaha nie wiem
	#print(next_scene,' hohoho ', nexter)
	#can_take = false
	randomize()
	$AudioStreamPlayer.stream = load(audio_path)
	$AudioStreamPlayer.play()
	var nexter = load(next_scene)
	await $AudioStreamPlayer.finished
	#print(self.next_scene)
	#poprawiona zmiana poziomu
	var scene_node = get_parent()
	print(scene_node)
	scene_node.queue_free()
	var roott = get_tree().get_root().get_node('world')
	roott.add_child(nexter.instantiate())
