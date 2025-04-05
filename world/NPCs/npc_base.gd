extends Area3D

@export var folder_path : String
const texture : String = "texture.png"
const dialog_data : String = "dialog.json"

var dialog_scene = preload("res://ui/HUD/npc_dialog/npc_dialog.tscn")

@onready var mesh: MeshInstance3D = $MeshInstance3D

var dialog_state : int = 0

func _ready() -> void:
	initialize(folder_path)

func initialize(folder_path_a : String):
	folder_path = folder_path_a
	name = folder_path.get_base_dir().get_slicec("/".unicode_at(0), folder_path.get_base_dir().get_slice_count("/")-1)
	var material : StandardMaterial3D = mesh.get_surface_override_material(0)
	material.albedo_texture = load(folder_path + texture)
	

func start_dialog():
	#wyhashtagowane bo nigzie nie działa
	#$AudioStreamPlayer.play()
	var dialog = dialog_scene.instantiate()
	dialog.get_data_from_file(folder_path + dialog_data)
	dialog.initialize()
	add_sibling(dialog)
	get_parent().move_child(dialog, 0)
	
