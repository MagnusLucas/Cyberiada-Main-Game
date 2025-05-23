extends Node3D
var start_ch_pos = Vector3(0,2,0)
#func _ready() -> void:
	#$"character".global_position = $"kuchnia-dorota/Marker3D".global_position
	#$"character/Camera_control".global_position = $"kuchnia-dorota/Marker3D".global_position + Vector3(0 ,0 ,0.25*$"character".global_position.z)
