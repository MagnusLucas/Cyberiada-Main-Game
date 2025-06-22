extends GraphNode
class_name NpcTextMode

const npc_text_scene = preload("res://dialog_maker/npc_statement.tscn")

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
	if npc_id >= id:
		id = npc_id + 1
	npc_text.title = "NPC : " + str(npc_text.personal_id)
	npc_text.get_node("text").text = dict["text"]
	if dict.has("item"):
		npc_text.get_node("given_item").text = dict["item"]
	if dict.has("next_start"):
		npc_text.get_node("next_start_id").text = dict["next_start"]
	if dict.has("notebook"):
		npc_text.get_node("notebook_trigger").text = dict["notebook"]
	return npc_text

func _ready() -> void:
	get_parent().npc_nodes[personal_id] = self


func to_dict(possible_answers : Dictionary) -> Dictionary:
	var dict : Dictionary = {}
	if $next_start_id.text != "":
		dict["next_start"] = $next_start_id.text
	if $notebook_trigger.text != "":
		dict["notebook"] = $next_start_id.text
	dict["answers"] = possible_answers
	dict["text"] = $text.text
	dict["item"] = $given_item.text
	return dict
