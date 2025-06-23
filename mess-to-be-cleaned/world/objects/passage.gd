extends StaticBody3D
@export_file("*.tscn") var next_scene : String
@export var item_name : String

var audio_path = "res://game/audio/SFX/unlocking/otwieranie_zamka_kluczem_"+str(randi_range(1,3))+".wav"


func taken():
	if item_name:
		var items_player_has : Array[String] = get_node("../../character").inv
		if !items_player_has.has(item_name):
			return
	
	Sound.play_sfx(audio_path)
	var nexter = load(next_scene)
	
	var scene_node = get_parent()
	scene_node.queue_free()
	var roott = get_node('/root/world')
	roott.add_child(nexter.instantiate())
