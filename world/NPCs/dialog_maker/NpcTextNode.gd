extends GraphNode
class_name NpcTextMode

static var id : int = 0
var personal_id

func _init() -> void:
	name = "NpcTextNode"
	title = "NPC : " + str(id)
	personal_id = id
	id += 1
	var text = TextEdit.new()
	text.placeholder_text = "example text"
	text.name = "text"
	text.scroll_fit_content_height = true
	text.scroll_fit_content_width = true
	add_child(text)
	
	set_slot_enabled_left(0, true)
	set_slot_type_left(0, 1)
	set_slot_enabled_right(0, true)
	set_slot_type_right(0, 0)


func _ready() -> void:
	get_parent().npc_nodes[personal_id] = self


func to_dict(possible_answers : Dictionary) -> Dictionary:
	var dict : Dictionary = {}
	dict["answers"] = possible_answers
	dict["text"] = $text.text
	return dict
