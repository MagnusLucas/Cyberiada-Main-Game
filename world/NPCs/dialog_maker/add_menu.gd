extends PanelContainer

var npc_scene = preload("res://world/NPCs/dialog_maker/npc_statement.tscn")


func _on_npc_pressed() -> void:
	var instance = NpcTextMode.new()
	add_sibling(instance, true)
	instance.position_offset = position
	queue_free()


func _on_player_pressed() -> void:
	var instance = AnswerNode.new()
	add_sibling(instance, true)
	instance.position_offset = position
	queue_free()
