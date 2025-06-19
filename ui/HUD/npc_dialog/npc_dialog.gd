extends MarginContainer

var convo_data : Dictionary
var current_state : String = "0"
var answers : Dictionary
@onready var character_name: Label = $VBoxContainer2/VBoxContainer/CharacterName
@onready var character_photo: TextureRect = $VBoxContainer2/CharacterPhoto

func _ready() -> void:
	if convo_data.is_empty():
		get_data_from_file("res://ui/HUD/npc_dialog/example_dialog.json")
		$VBoxContainer2/VBoxContainer/answers.focus_mode = FOCUS_ALL
		initialize()
		

func get_data_from_file(filepath : String) -> bool:
	var file = FileAccess.open(filepath, FileAccess.READ)
	var json_string = file.get_as_text()
	if !JSON.parse_string(json_string):
		print_debug("ERROR! The file with this characters conversation info is broken or non existent")
		return false
	convo_data = JSON.parse_string(json_string)
	return true

# it should modify the convo data to be correct according to owned items
func initialize():
	var character = get_node_or_null("../character")
	if !character:
		next(current_state)
		return
	var owned_items : Array[String] = character.inv
	
	for state in convo_data:
		for answer_key in convo_data[state]["answers"]:
			var answer : Dictionary = convo_data[state]["answers"][answer_key]
			if answer.has("item"):
				if answer["item"] is String and answer["item"] != "":
					if !owned_items.has(answer["item"]):
						convo_data[state]["answers"].erase(answer_key)
				elif answer["item"]["name"] != "":
					if !owned_items.has(answer["item"]["name"]):
						convo_data[state]["answers"].erase(answer_key)
	next(current_state)

func receive_item(item_name : String):
	var character = get_node("../character")
	if item_name in character.inv:
		return
	character.inv.append(item_name)
	get_node("../character/HUD/InLevelUi").update_inv(character.inv)

func next(id : String):
	var answers_node = $VBoxContainer2/VBoxContainer/answers
	current_state = id
	if !convo_data.has(current_state):
		queue_free()
		return
	$VBoxContainer2/VBoxContainer/PreviousStatement.text = convo_data[current_state]["text"]
	if convo_data[current_state].has("item") and convo_data[current_state]["item"] != "":
		receive_item(convo_data[current_state]["item"])
	answers = convo_data[current_state]["answers"]
	
	for child in answers_node.get_children():
		answers_node.remove_child(child)
	for key in answers:
		var answer : RichTextLabel = RichTextLabel.new()
		answer.theme = load("res://ui/shared/graphics/themes/default_rtl.tres")
		answer.text = answers[key]["text"]
		answer.focus_mode = Control.FOCUS_ALL
		var possible_answer_reactions : Array = answers[key]["next_id"]
		var number_of_possibilities = possible_answer_reactions.size()
		var response_data : Dictionary = {}
		response_data = answers[key]
		if number_of_possibilities > 0:
			answer.connect("gui_input", _on_answer_gui_input.bind(
				answers[key]["next_id"][randi() % number_of_possibilities],
				response_data))
		else:
			answer.connect("gui_input", _on_answer_gui_input.bind(-1, response_data))
		answer.fit_content = true
		answers_node.add_child(answer)
	
	answers_node.focus_next = NodePath(answers_node.get_child(0).name)
	
	for index in answers_node.get_child_count() - 2:
		answers_node.get_child(index + 1).focus_next = NodePath("../" + answers_node.get_child(index + 2).name)
		answers_node.get_child(index + 1).focus_neighbor_bottom = NodePath("../" + answers_node.get_child(index + 2).name)
		answers_node.get_child(index - 1).focus_previous = NodePath("../" + answers_node.get_child(index).name)
		answers_node.get_child(index - 1).focus_neighbor_top = NodePath("../" + answers_node.get_child(index).name)
	if answers_node.get_child_count() > 1:
		answers_node.get_child(0).focus_next = NodePath("../" + answers_node.get_child(1).name)
		answers_node.get_child(0).focus_neighbor_bottom = NodePath("../" + answers_node.get_child(1).name)
		answers_node.get_child(answers_node.get_child_count() - 1).focus_previous = NodePath(
			"../" + answers_node.get_child(answers_node.get_child_count() - 2).name)
		answers_node.get_child(answers_node.get_child_count() - 1).focus_neighbor_top = NodePath(
			"../" + answers_node.get_child(answers_node.get_child_count() - 2).name)
	answers_node.get_child(answers_node.get_child_count() - 1).focus_next = NodePath("../" + answers_node.get_child(0).name)
	answers_node.get_child(answers_node.get_child_count() - 1).focus_neighbor_bottom = NodePath(
		"../" + answers_node.get_child(0).name)

	answers_node.get_child(0).grab_focus()

func _handle_response(response : Dictionary):
	if response.has("item"):
		if response["item"] is Dictionary:
			var item = response["item"]
			if item.has("disappears"):
				if item["disappears"]:
					var character = get_node_or_null("../character")
					if !character:
						return
					var owned_items : Array[String] = character.inv
					if owned_items.has(item["name"]):
						character.inv.erase(item["name"])
						get_node("../character/HUD/InLevelUi").update_inv(character.inv)
	if response.has("next_start"):
		var character = get_node_or_null("../character")
		if !character:
			return
		character.dialogues_state[character_name.text] = response["next_start"]

func _on_answer_gui_input(event: InputEvent, next_id : int = 0, response_data : Dictionary = {}) -> void:
	if ((event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true) 
			or event.is_action_pressed("ui_accept")):
		_handle_response(response_data)
		next(str(next_id))
