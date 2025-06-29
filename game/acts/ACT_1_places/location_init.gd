extends Node3D

var start_ch_pos = Vector3(0,2,0)

@export var camera_z_offset = 4

func _ready() -> void:
	for_act_load()
	
func for_act_load():
	var character = get_node("/root/world/character")
	character.position = $Marker3D.position
	character.reset_camera(camera_z_offset)
	
	if Globals.act == 1:
		if Notebook.data["inhabitants"]["marynarz"].has("czapka"):
			$czapka.queue_free()
	
