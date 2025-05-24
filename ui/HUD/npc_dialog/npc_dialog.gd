extends MarginContainer

var convo_data : Dictionary
var current_state : String = "0"
var answers : Dictionary

func _ready() -> void:
	if convo_data.is_empty():
		get_data_from_file("res://ui/HUD/npc_dialog/example_dialog.json")
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
func initialize():#, owned_items : Array[Item]):
	var owned_items : Array[String] = get_node("../character").inv
	for state in convo_data:
		for answer_key in convo_data[state]["answers"]:
			var answer : Dictionary = convo_data[state]["answers"][answer_key]
			if answer.has("item") and answer["item"] != "":
				if !owned_items.has(answer["item"]):
					convo_data[state]["answers"].erase(answer_key)
	next(current_state)

func receive_item(item_name : String):
	var character = get_node("../character")
	character.inv.append(item_name)
	get_node("../character/HUD/InLevelUi").update_inv(character.inv)

func next(id : String):
	current_state = id
	if !convo_data.has(current_state):
		queue_free()
		return
	$VBoxContainer/PreviousStatement.text = convo_data[current_state]["text"]
	if convo_data[current_state].has("item") and convo_data[current_state]["item"] != "":
		receive_item(convo_data[current_state]["item"])
	answers = convo_data[current_state]["answers"]
	
	for child in $VBoxContainer/answers.get_children():
		child.queue_free()
	for key in answers:
		var answer : RichTextLabel = RichTextLabel.new()
		answer.theme = load("res://ui/shared/graphics/themes/default_rtl.tres")
		answer.text = answers[key]["text"]
		var possible_answer_reactions : Array = answers[key]["next_id"]
		var number_of_possibilities = possible_answer_reactions.size()
		if number_of_possibilities > 0:
			answer.connect("gui_input", _on_answer_gui_input.bind(answers[key]["next_id"][randi() % number_of_possibilities]))
		else:
			answer.connect("gui_input", _on_answer_gui_input.bind(-1))
		answer.fit_content = true
		$VBoxContainer/answers.add_child(answer)


func _on_answer_gui_input(event: InputEvent, next_id : int = 0) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
		next(str(next_id))
