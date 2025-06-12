extends MarginContainer

@onready var fade_out: TextureRect = $FadeOut
@onready var fade_in: TextureRect = $FadeIn

const frame_data : Dictionary = {
	"1" = {
		"image" = "res://ui/prolog/frames/prolog-1.png",
		"sounds" = {
			"1.0" = "res://ui/prolog/sounds/body_thud.wav"
		}
	},
	"2" = {
		"image" = "res://ui/prolog/frames/prolog-2.png",
		"sounds" = {
			"1.0" = "res://ui/prolog/sounds/body_thud.wav"
		}
	},
	"3" = {
		"image" = "res://ui/prolog/frames/prolog-3.png",
		"sounds" = {
			"1.0" = "res://ui/prolog/sounds/body_thud.wav"
		}
	},
	"4" = {
		"image" = "res://ui/prolog/frames/prolog-4.png",
		"sounds" = {
			"1.0" = "res://ui/prolog/sounds/body_thud.wav"
		}
	},
	"5" = {
		"image" = "res://ui/prolog/frames/prolog-5.png",
		"sounds" = {
			"1.0" = "res://ui/prolog/sounds/body_thud.wav"
		}
	},
	"6" = {
		"image" = "res://ui/prolog/frames/prolog-6.png",
		"sounds" = {
			"1.0" = "res://ui/prolog/sounds/body_thud.wav"
		}
	},
	"7" = {
		"image" = "res://ui/prolog/frames/prolog-7.png",
		"sounds" = {
			"1.0" = "res://ui/prolog/sounds/body_thud.wav"
		}
	},
	"8" = {
		"image" = "res://ui/prolog/frames/prolog-8.png",
		"sounds" = {
			"1.0" = "res://ui/prolog/sounds/body_thud.wav"
		}
	},
	"9" = {
		"image" = "res://ui/prolog/frames/prolog-9.png",
		"sounds" = {
			"1.0" = "res://ui/prolog/sounds/body_thud.wav"
		}
	},
}

var current_frame : String

func _ready() -> void:
	current_frame = str(1)
	fade_out.texture = load(frame_data[current_frame]["image"])

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed == true and event.button_index == MOUSE_BUTTON_LEFT:
		_switch_frame()

func _switch_frame():
	current_frame = str(int(current_frame) + 1)
	if !frame_data.has(current_frame):
		get_tree().change_scene_to_file("res://game.tscn")
		print_debug("prolog_finished")
		return
	fade_in.texture = load(frame_data[current_frame]["image"])
	
	for sound_offset in frame_data[current_frame]["sounds"]:
		var timer = Timer.new()
		$AudioStreamPlayer.add_child(timer)
		timer.connect("timeout", _play_sound.bind(timer, frame_data[current_frame]["sounds"][sound_offset]))
		timer.start(float(sound_offset))
	
	var out_tween = fade_out.create_tween()
	var in_tween = fade_in.create_tween()
	const TWEEN_TIME = 1.0
	out_tween.tween_property(fade_out, "modulate", Color("ffffff00"), TWEEN_TIME)
	in_tween.tween_property(fade_in, "modulate", Color("ffffffff"), TWEEN_TIME)
	await get_tree().create_timer(TWEEN_TIME).timeout
	out_tween.kill()
	in_tween.kill()
	
	if !frame_data.has(current_frame):
		print_debug("!!prolog finished")
		return
	fade_out.texture = load(frame_data[current_frame]["image"])
	fade_out.modulate = Color("ffffffff")
	fade_in.modulate = Color("ffffff00")

func _play_sound(timer : Timer, stream : String):
	timer.queue_free()
	$AudioStreamPlayer.stream = load(stream)
	$AudioStreamPlayer.play()
