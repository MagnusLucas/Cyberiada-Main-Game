extends StaticBody3D
@export_file("*.tscn") var next_scene : String
@export var item_name : String

var audio_path = "res://audio/otwieranie_zamka_kluczem_"+str(randi_range(1,3))+".wav"

var can_take : bool
func _ready() -> void:
	can_take = true

func taken():
	if item_name:
		var items_player_has : Array[String] = get_node("../../character").inv
		if !items_player_has.has(item_name):
			return
	
	randomize()
	$AudioStreamPlayer.stream = load(audio_path)
	$AudioStreamPlayer.play()
	var nexter = load(next_scene)
	await $AudioStreamPlayer.finished
	
	var scene_node = get_parent()
	scene_node.queue_free()
	var roott = get_tree().get_root().get_node('world')
	roott.add_child(nexter.instantiate())
