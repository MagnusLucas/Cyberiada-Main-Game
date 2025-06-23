extends Area3D
class_name Item
@onready var character = $"../character"

@export_file(".png") var texture = "res://game/items/2d/example_item.png"
@export_file(".wav") var pickup_sound = "res://game/audio/SFX/pstryczek.wav"

func _ready() -> void:
	var material : StandardMaterial3D = $MeshInstance3D.get_surface_override_material(0)
	material.albedo_texture = load(texture)

func taken():
	if len(character.inv) <=5:
		character.inv.append(name)
		Sound.play_sfx(pickup_sound)
		character.get_node("HUD").update_inv(character.inv)
		queue_free()
