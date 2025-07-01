extends VBoxContainer

@onready var back_button = $"../../right/info/HBoxContainer/back"

func _on_diary_pressed() -> void:
	add_sibling(load("res://UI/in-game/notebook/diary.tscn").instantiate())
	back_button.show()
	queue_free()


func _on_inhabitants_pressed() -> void:
	add_sibling(load("res://UI/in-game/notebook/inhabitants.tscn").instantiate())
	back_button.show()
	queue_free()


func _on_items_pressed() -> void:
	add_sibling(load("res://UI/in-game/notebook/clues.tscn").instantiate())
	back_button.show()
	queue_free()


func _on_places_pressed() -> void:
	add_sibling(load("res://UI/in-game/notebook/places.tscn").instantiate())
	back_button.show()
	queue_free()
