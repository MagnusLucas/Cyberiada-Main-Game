extends GraphNode
class_name AnswerNode

const answer_scene = preload("res://world/NPCs/dialog_maker/player_answer.tscn")

static var id : int = 0
var personal_id

static func new_custom() -> AnswerNode:
	var answer : AnswerNode = answer_scene.instantiate()
	answer.personal_id = id
	id += 1
	answer.title = "Player : " + str(id)
	return answer

func _ready() -> void:
	get_parent().player_nodes[personal_id] = self

func to_dict(next_possibilities : Array[int]) -> Dictionary:
	var dict : Dictionary = {}
	dict = {}
	dict["next_id"] = next_possibilities
	dict["text"] = $text.text
	dict["item"] = $required_item.text
	return dict
	
