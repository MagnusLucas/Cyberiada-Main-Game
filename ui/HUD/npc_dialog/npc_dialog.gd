extends MarginContainer

var convo_data : Dictionary
var current_state : String = "0"
var answers : Dictionary

func _ready() -> void:
	if convo_data.is_empty():
		var file = FileAccess.open("res://ui/HUD/npc_dialog/example_dialog.json", FileAccess.READ)
		var json_string = file.get_as_text()
		convo_data = JSON.parse_string(json_string)
		next(current_state)
	#var dict : Dictionary
	#dict[0] = {}
	#dict[0]["text"] = "hello"
	#dict[0]["answers"] = {}
	#dict[0]["answers"][0] = {}
	#dict[0]["answers"][0]["text"] = "hello"
	#dict[0]["answers"][0]["next_id"] = 1
	#dict[0]["answers"][1] = {}
	#dict[0]["answers"][1]["text"] = "fuck u"
	#dict[0]["answers"][1]["next_id"] = 2
	#dict[1] = {}
	#dict[1]["text"] = "bye bye"
	#dict[1]["answers"] = {}
	#dict[1]["answers"][0] = {}
	#dict[1]["answers"][0]["text"] = "ok, bye..."
	#dict[1]["answers"][0]["next_id"] = -1
	#dict[2] = {}
	#dict[2]["text"] = "well fuck u too!"
	#dict[2]["answers"] = {}
	#dict[2]["answers"][0] = {}
	#dict[2]["answers"][0]["text"] = "..."
	#dict[2]["answers"][0]["next_id"] = -1
	#initialize(dict)
	#var file = FileAccess.open("res://ui/HUD/npc_dialog/example_dialog.json", FileAccess.WRITE)
	#file.store_string(JSON.stringify(dict, "\t"))

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
		answer.connect("gui_input", _on_answer_gui_input.bind(answers[key]["next_id"]))
		answer.fit_content = true
		$VBoxContainer/answers.add_child(answer)


func _on_answer_gui_input(event: InputEvent, next_id : int = 0) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
		next(str(next_id))
