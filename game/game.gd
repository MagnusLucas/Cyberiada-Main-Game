extends Control

var pause = preload("res://UI/in-game/pause.tscn")
var current_act = 1

func _ready() -> void:
	if Globals.game_data:
		var inventory : Array[String]
		inventory.assign(Globals.game_data["inventory"])
		get_node(Globals.CHARACTER_NODE_POSITION).inv = inventory
		get_node(Globals.CHARACTER_NODE_POSITION).dialogues_state = Globals.game_data["dialogues_state"]
		
		Globals.act = int(Globals.game_data["act"])

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_ESCAPE and event.is_pressed():
		add_child(pause.instantiate())
		get_tree().paused = true
	if event is InputEventKey and event.keycode == KEY_J and event.is_pressed():
		act_load(2)
		
func act_load(akt):
	current_act = akt
	#var inv = $act_1/character.inv
	#inv = []
	#get_node("act_1/character/HUD/InLevelUi").update_inv(inv)
	if akt-1 != 0:
		get_node("act_"+str(akt-1)).queue_free()
	add_child(load("res://act/act_"+str(akt)+".tscn").instantiate())
	$test_level.for_act_load()
	

	
	
