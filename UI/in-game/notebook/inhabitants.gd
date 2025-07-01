extends VBoxContainer

func _ready() -> void:
	for npc in $VBoxContainer/HBoxContainer.get_children():
		npc.get_child(0).connect("pressed", _on_button_pressed.bind(npc.name))
	for npc in $VBoxContainer/HBoxContainer2.get_children():
		npc.get_child(0).connect("pressed", _on_button_pressed.bind(npc.name))

func _on_button_pressed(npc_name : String):
	var info_page = get_node_or_null("../../right")
	if info_page:
		if Notebook.data["inhabitants"][npc_name].has("info"):
			info_page.update({"name" : "[b]" + npc_name, "info" : Notebook.data["inhabitants"][npc_name]["info"]})
		else:
			info_page.update({"name" : "[b]" + npc_name, "info" : ""})
