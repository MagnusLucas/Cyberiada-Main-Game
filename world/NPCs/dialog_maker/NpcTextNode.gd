extends GraphNode
class_name NpcTextMode

const npc_text_scene = preload("res://world/NPCs/dialog_maker/npc_statement.tscn")

static var id : int = 0
var personal_id

static func new_custom() -> NpcTextMode:
	var npc_text : NpcTextMode = npc_text_scene.instantiate()
	npc_text.personal_id = id
	id += 1
	npc_text.title = "NPC : " + str(npc_text.personal_id)
	return npc_text

static func from_dict(npc_id : int, dict : Dictionary) -> NpcTextMode:
	var npc_text : NpcTextMode = npc_text_scene.instantiate()
	npc_text.personal_id = npc_id
	id += 1
	npc_text.title = "NPC : " + str(npc_text.personal_id)
	npc_text.get_node("text").text = dict["text"]
	if dict.has("item"):
		npc_text.get_node("given_item").text = dict["item"]
	return npc_text

func _ready() -> void:
	get_parent().npc_nodes[personal_id] = self


func to_dict(possible_answers : Dictionary) -> Dictionary:
	var dict : Dictionary = {}
	dict["answers"] = possible_answers
	dict["text"] = $text.text
	dict["item"] = $given_item.text
	return dict
