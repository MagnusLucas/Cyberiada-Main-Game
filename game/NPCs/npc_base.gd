extends Area3D

@export_dir
var folder_path : String = "res://game/NPCs/NPC-folders/babcia/"
const texture : String = "texture.png"
const dialog_data : String = "dialog.json"

var dialog_scene = preload("res://UI/in-game/HUD/npc_dialog.tscn")

@onready var mesh: MeshInstance3D = $MeshInstance3D

var dialog_state : int = 0

func _ready() -> void:
	initialize()

func initialize():
	name = folder_path.get_base_dir().get_slicec("/".unicode_at(0), folder_path.get_base_dir().get_slice_count("/")-1)
	var material : StandardMaterial3D = mesh.get_surface_override_material(0)
	print("initializing ", name)
	material.albedo_texture = load(folder_path + texture)
	

func start_dialog(from_state : String = "0"):
	if get_node_or_null("../npcDialog"):
		return
	$AudioStreamPlayer.play()
	var dialog = dialog_scene.instantiate()
	dialog.get_data_from_file(folder_path + dialog_data)
	add_sibling(dialog, true)
	dialog.initialize()
	dialog.next(from_state)
	dialog.character_name.text = name
	dialog.character_photo.texture = load(folder_path + texture)
	get_parent().move_child(dialog, 0)
	
