extends MarginContainer

var inputingKey : bool = false

@onready var keyBinds : Dictionary = {
	"go_up" = $VBoxContainer/HBoxContainer/go_up,
	"go_down" = $VBoxContainer/HBoxContainer2/go_down,
	"go_left" = $VBoxContainer/HBoxContainer3/go_left,
	"go_right" = $VBoxContainer/HBoxContainer4/go_right,
	"interact" = $VBoxContainer/HBoxContainer5/interact
}

@export_file var back = "res://UI/shared/settings/settings.tscn"

func get_key(actionName : String) -> String:
	var events = InputMap.action_get_events(actionName)
	for event in events:
		if event is InputEventKey:
			return OS.get_keycode_string(event.physical_keycode)
	return ""

func change_key(actionName : String, keyEvent : InputEventKey):
	var events = InputMap.action_get_events(actionName)
	for event in events:
		if event is InputEventKey:
			InputMap.action_erase_event(actionName, event)
			InputMap.action_add_event(actionName, keyEvent)
			keyBinds[actionName].text = OS.get_keycode_string(keyEvent.physical_keycode)
	inputingKey = false

func start_changing_key(action : String):
	keyBinds[action].text = " "
	inputingKey = true

func _ready() -> void:
	for keyBind in keyBinds:
		keyBinds[keyBind].text = get_key(keyBind)
		keyBinds[keyBind].connect("pressed", start_changing_key.bind(keyBinds[keyBind].name))

func _input(event: InputEvent) -> void:
	if inputingKey and event is InputEventKey:
		for keyBind in keyBinds:
			if keyBinds[keyBind].text == " ":
				change_key(keyBind, event)


func _on_back_pressed() -> void:
	add_sibling(load(back).instantiate())
	queue_free()
