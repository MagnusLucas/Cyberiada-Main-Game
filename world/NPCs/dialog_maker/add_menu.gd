extends PanelContainer

var npc_scene = preload("res://world/NPCs/dialog_maker/npc_statement.tscn")

func _on_npc_pressed() -> void:
	var instance = NpcTextMode.new_custom()
	add_sibling(instance, true)
	instance.position_offset = position + get_parent().scroll_offset/get_parent().zoom
	queue_free()


func _on_player_pressed() -> void:
	var instance = AnswerNode.new_custom()
	add_sibling(instance, true)
	instance.position_offset = position + get_parent().scroll_offset/get_parent().zoom
	queue_free()
