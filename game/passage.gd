extends Area3D
class_name Passage
@export_file("*.tscn") var next_scene : String
@export var item_name : String

var audio_path = "res://game/audio/SFX/unlocking/otwieranie_zamka_kluczem_"+str(randi_range(1,3))+".wav"


func use(item_tab : Array[String]):
	if item_name:
		if !item_tab.has(item_name):
			return
	
	Sound.play_sfx(audio_path)
	var next = load(next_scene)
	
	var scene_node = get_parent()
	scene_node.queue_free()
	var act = get_node('/root/world').get_child(0)
	act.add_child(next.instantiate())
