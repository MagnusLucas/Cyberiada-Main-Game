extends Control
func _ready() -> void:
	$AudioStreamPlayer.play()

func _on_close_pressed() -> void:
	get_tree().paused = false
	$AudioStreamPlayer.play()
	visible = false
	await $AudioStreamPlayer.finished
	$".".queue_free()
