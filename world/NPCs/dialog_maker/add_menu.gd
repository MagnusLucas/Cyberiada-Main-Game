extends PanelContainer

var npc_scene = preload("res://world/NPCs/dialog_maker/npc_statement.tscn")
var player_answer = preload("res://world/NPCs/dialog_maker/player_answer.tscn")


func _on_npc_pressed() -> void:
	var instance = npc_scene.instantiate()
	add_sibling(instance)
	instance.position_offset = position
	queue_free()


func _on_player_pressed() -> void:
	var instance = player_answer.instantiate()
	add_sibling(instance)
	instance.position_offset = position
	queue_free()
