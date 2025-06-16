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

static func from_dict(ans_id : int, dict : Dictionary) -> AnswerNode:
	var answer : AnswerNode = answer_scene.instantiate()
	answer.personal_id = ans_id
	id += 1
	answer.title = "Player : " + str(answer.personal_id)
	answer.get_node("text").text = dict["text"]
	if dict.has("item"):
		if dict["item"] is Dictionary:
			answer.get_node("required_item").text = dict["item"]["name"]
			answer.get_node("disappears").button_pressed = dict["item"]["disappears"]
		else:
			answer.get_node("required_item").text = dict["item"]
	if dict.has("next_start"):
		answer.get_node("next_start_id").text = dict["next_start"]
	return answer

func _ready() -> void:
	get_parent().player_nodes[personal_id] = self

func to_dict(next_possibilities : Array[int]) -> Dictionary:
	var dict : Dictionary = {}
	dict = {}
	dict["next_id"] = next_possibilities
	if $next_start_id.text != "":
		dict["next_start"] = $next_start_id.text
	dict["text"] = $text.text
	dict["item"] = {}
	dict["item"]["name"] = $required_item.text
	dict["item"]["disappears"] = $disappears.button_pressed
	return dict
