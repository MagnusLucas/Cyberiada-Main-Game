extends GraphEdit

var add_menu = preload("res://dialog_maker/add_menu.tscn")

var player_nodes : Dictionary = {} 
var npc_nodes : Dictionary = {} 

var selected_nodes = {}

func _ready() -> void:
	OS.low_processor_usage_mode = true

func clicked(event: InputEvent, button_index: int = 0):
	var mouse_clicked = event is InputEventMouseButton and event.pressed == true
	if button_index:
		return mouse_clicked and event.button_index == button_index
	return mouse_clicked

func get_connections_from_node(node : GraphNode) -> Array[int]:
	var connections_from_this : Array[int] = []
	for connection in connections:
		if connection.from_node == node.name:
			var to_id = get_node(NodePath(connection.to_node)).personal_id
			connections_from_this.append(to_id)
	return connections_from_this


func _on_gui_input(event: InputEvent) -> void:
	if clicked(event):
		if has_node("AddMenu"):
			get_node("AddMenu").queue_free()
		elif has_node("AddMenu2"):
			get_node("AddMenu2").queue_free()
	
	if clicked(event, MOUSE_BUTTON_RIGHT):
		var menu_position = get_local_mouse_position()
		var menu = add_menu.instantiate()
		menu.position = menu_position
		add_child(menu, true)
	
	
	if event is InputEventKey and event.pressed == true and event.keycode == KEY_DELETE:
		for node in selected_nodes:
			node.queue_free()
		selected_nodes = {}


func _on_connection_request(from_node, from_port, to_node, to_port):
	connect_node(from_node, from_port, to_node, to_port)

func _on_disconnection_request(from_node, from_port, to_node, to_port):
	disconnect_node(from_node, from_port, to_node, to_port)

func _on_connection_to_empty(from_node: StringName, from_port: int, _release_position: Vector2) -> void:
	var instance
	if get_node(NodePath(from_node)) is AnswerNode:
		instance = NpcTextMode.new_custom()
	else:
		instance = AnswerNode.new_custom()
	add_child(instance, true)
	instance.position_offset = (get_local_mouse_position() + scroll_offset)/zoom
	connect_node(from_node, from_port, instance.name, 0)


func _to_dict() -> Dictionary:
	var dict = {}
	for key in npc_nodes:
		var node = npc_nodes[key]
		var answers : Dictionary = {}
		for id in get_connections_from_node(node):
			answers[id] = player_nodes[id].to_dict(get_connections_from_node(player_nodes[id]))
		dict[node.personal_id] = node.to_dict(answers)
	return dict

func _from_dict(dict : Dictionary) -> void:
	clear_connections()
	var children_to_clear = get_children()
	for child in children_to_clear:
		if child is GraphNode:
			child.queue_free()
	for id in dict:
		var npc_node = NpcTextMode.from_dict(int(id), dict[id])
		npc_nodes[id] = npc_node
		add_child(npc_node, true)
		var node_size : Vector2 = npc_node.size
		npc_node.position_offset = node_size + Vector2(node_size.x, 0) * int(id) * 3
		for answer_id in dict[id]["answers"]:
			if !player_nodes.has(answer_id):
				var answer = AnswerNode.from_dict(int(answer_id), dict[id]["answers"][answer_id])
				add_child(answer, true)
				answer.position_offset.x = npc_node.position_offset.x + node_size.x * 1.5
				answer.position_offset.y = (npc_node.position_offset.y + 
						node_size.x * (int(answer_id) - int(dict[id]["answers"].keys()[0])) * 1.5)
				player_nodes[answer_id] = answer
			connect_node(npc_node.name, 0, player_nodes[answer_id].name, 0)
	for npc_id in dict:
		for answer_id in dict[npc_id]["answers"]:
			var my_name = player_nodes[answer_id].name
			if !dict[npc_id]["answers"][answer_id]["next_id"].is_empty():
				var next_id = int(dict[npc_id]["answers"][answer_id]["next_id"][0])
				var next_name = npc_nodes[str(next_id)].name
				connect_node(my_name, 0, next_name, 0)

func _on_load_pressed() -> void:
	var loading_dialog = FileDialog.new()
	loading_dialog.current_dir = "res://world/NPCs/NPC-folders/"
	loading_dialog.current_file = "dialog.json"
	loading_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	add_child(loading_dialog)
	loading_dialog.show()
	loading_dialog.connect("file_selected", _on_load_confirmed)

func _on_load_confirmed(path : String) -> void:
	var file = FileAccess.open(path, FileAccess.READ)
	var json_string = file.get_as_text()
	if !JSON.parse_string(json_string):
		print_debug("ERROR! The file with this characters conversation info is broken or non existent")
		return
	var convo_data = JSON.parse_string(json_string)
	file.close()
	_from_dict(convo_data)

func _on_save_pressed() -> void:
	var saving_dialog = FileDialog.new()
	saving_dialog.current_dir = "res://world/NPCs/NPC-folders/"
	saving_dialog.current_file = "dialog.json"
	add_child(saving_dialog)
	saving_dialog.show()
	saving_dialog.connect("file_selected", _on_save_confirmed)

func _on_save_confirmed(path : String):
	var file = FileAccess.open(path, FileAccess.WRITE)
	var string = JSON.stringify(_to_dict(), "\t")
	file.store_string(string)
	file.close()

func _on_node_selected(node: Node) -> void:
	selected_nodes[node] = true

func _on_node_deselected(node: Node) -> void:
	selected_nodes.erase(node)
