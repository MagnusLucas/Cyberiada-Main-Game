extends Node3D
var start_ch_pos = Vector3(0,2,0)
func _ready() -> void:
	for_act_load()
	
func for_act_load():
	var character = get_node("../act_"+str($"..".current_act)+"/character")
	character.position = $Marker3D.position
	print($Marker3D.position)
	character.do_kam_diff = 0
	character.kamz = 0
	
	#character.get_node("Camera_control").global_position = $MarkerCamera3D.global_position + Vector3(0 ,0 ,0.25*character.global_position.z)
	#character.get_node("Camera_control").global_position = Vector3(1000,1000,1000)
