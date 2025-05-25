extends GraphEdit

var add_menu = preload("res://world/NPCs/dialog_maker/add_menu.tscn")

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
	
	#if clicked(event, MOUSE_BUTTON_LEFT):
		#for node in selected_nodes:
			#if node is AnswerNode:
				#print(node.to_dict(get_connections_from_node(node)))
			#else:
				#var answers : Array[Dictionary]= []
				#for id in get_connections_from_node(node):
					#answers.append(player_nodes[id].to_dict(get_connections_from_node(player_nodes[id])))
				#print(node.to_dict(answers))
	
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
	instance.position_offset = get_local_mouse_position() + scroll_offset/zoom
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
