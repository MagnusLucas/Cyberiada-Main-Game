extends VBoxContainer

func _ready() -> void:
	for npc in $VBoxContainer/HBoxContainer.get_children():
		npc.get_child(0).connect("pressed", _on_button_pressed.bind(npc.name))
	for npc in $VBoxContainer/HBoxContainer2.get_children():
		npc.get_child(0).connect("pressed", _on_button_pressed.bind(npc.name))

func _on_button_pressed(npc_name : String):
	print_debug(Notebook.data["inhabitants"][npc_name])
