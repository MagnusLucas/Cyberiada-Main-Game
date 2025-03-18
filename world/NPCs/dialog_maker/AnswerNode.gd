extends GraphNode
class_name AnswerNode

static var id : int = 0

var personal_id

func _init() -> void:
	name = "AnswerNode"
	title = "Player : " + str(id)
	personal_id = id
	id += 1
	var text = TextEdit.new()
	text.placeholder_text = "example text"
	text.name = "text"
	text.scroll_fit_content_height = true
	text.scroll_fit_content_width = true
	add_child(text)
	
	var required_item = LineEdit.new()
	required_item.placeholder_text = "required item"
	required_item.name = "required_item"
	add_child(required_item)
	
	set_slot_enabled_left(0, true)
	set_slot_type_left(0, 0)
	set_slot_enabled_right(0, true)
	set_slot_type_right(0, 1)


func _ready() -> void:
	get_parent().player_nodes[personal_id] = self

func to_dict(next_possibilities : Array[int]) -> Dictionary:
	var dict : Dictionary = {}
	dict = {}
	dict["next_id"] = next_possibilities
	dict["text"] = $text.text
	return dict
	
