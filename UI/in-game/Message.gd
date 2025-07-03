extends VBoxContainer
class_name Message

const MESSAGE_SCENE = "res://UI/in-game/message.tscn"

var text : String

static func new_message(message_text : String) -> Message:
	var scene = load(MESSAGE_SCENE).instantiate()
	scene.text = message_text
	return scene

func _ready() -> void:
	$MarginContainer/Label.text = text
	get_tree().paused = true

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == false:
			get_tree().paused = false
			queue_free()
