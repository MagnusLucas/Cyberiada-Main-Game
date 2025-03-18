extends MarginContainer

var convo_data : Dictionary
var current_state : String = "0"
var answers : Dictionary

func _ready() -> void:
	if convo_data.is_empty():
		var file = FileAccess.open("res://ui/HUD/npc_dialog/example_dialog1.json", FileAccess.READ)
		var json_string = file.get_as_text()
		convo_data = JSON.parse_string(json_string)
		next(current_state)

# it should modify the convo data to be correct according to owned items
func initialize(all_convo_data : Dictionary):#, owned_items : Array[Item]):
	convo_data = all_convo_data
	next(current_state)

func next(id : String):
	current_state = id
	if !convo_data.has(current_state):
		print("convo finished")
		queue_free()
		return
	$VBoxContainer/PreviousStatement.text = convo_data[current_state]["text"]
	answers = convo_data[current_state]["answers"]
	
	for child in $VBoxContainer/answers.get_children():
		child.queue_free()
	for key in answers:
		var answer = RichTextLabel.new()
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
