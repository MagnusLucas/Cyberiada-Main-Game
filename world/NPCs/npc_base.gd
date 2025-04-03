extends Area3D

@export var folder_path : String
const texture : String = "texture.png"
const dialog : String = "dialog.json"

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
	pass
