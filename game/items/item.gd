extends Area3D
class_name Item
@onready var character = get_node(Globals.CHARACTER_NODE_POSITION)

@export_file(".png") var texture = "res://game/items/2d/example_item.png"
@export_file(".wav") var pickup_sound = "res://game/audio/SFX/pstryczek.wav"
@export var pickable : bool = true
@export var message_on_interaction : String = ""

@export_group("Notebook info on interaction")
@export_enum("diary", "inhabitants", "clues") var notebook_category : String = "clues"
@export var category_value : String = "example_item"
@export var info : String = "This is an example of speech"



func _ready() -> void:
	if Notebook.data['inhabitants']['marynarz'].has('info'):
		if Notebook.data['inhabitants']['marynarz']['info'].has('Znalazłem jego czapkę'):
			queue_free()
	var material : StandardMaterial3D = $MeshInstance3D.get_surface_override_material(0)
	material.albedo_texture = load(texture)

func take():
	if message_on_interaction:
		get_node("/root/world").add_child(Message.new_message(message_on_interaction))
	if info:
		if !Notebook.data[notebook_category][category_value].has("info"):
			Notebook.data[notebook_category][category_value]["info"] = []
		Notebook.data[notebook_category][category_value]["info"].append(info)
	if pickable and len(character.inv) <=5:
		character.inv.append(name)
		Sound.play_sfx(pickup_sound)
		character.get_node("HUD").update_inv(character.inv)
		queue_free()
