extends HBoxContainer


func _on_back_pressed() -> void:
	$"../../../..".queue_free()
