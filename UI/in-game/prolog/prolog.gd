extends MarginContainer

@onready var fade_out: TextureRect = $FadeOut
@onready var fade_in: TextureRect = $FadeIn

const FRAME_PATH = "res://UI/in-game/prolog/frames/"
const FRAME_NAME = "prolog-"
const FRAME_EXTENSION = ".png"
const SOUND_PATH = "res://UI/in-game/prolog/sounds/"

const frame_data : Dictionary = {
	"1" = {
		"text" = "Kolejna noc, która wygląda jak milion poprzednich. Nic się nie zmienia. Wszystko jest statyczne. Pieprzona stagnacja, w której gniję. Nie, przegniłem już do szpiku kości…",
		"sounds" = {
			"1.0" = "body_thud.wav"
		}
	},
	"2" = {
		"text" = "Ta melodia… Wierci dziurę w mojej głowie. Głębiej, jeszcze głębiej… Osiągając punkt zapalny - więcej już nie zdzierżę!",
		"sounds" = {
			"1.0" = "body_thud.wav"
		}
	},
	"3" = {
		"text" = "Zrywam się więc, ale to, co zobaczyłem… Skazało mnie jedynie na koszmary jeszcze straszniejsze, niż te, które nawiedzały mój sen dotychczas.",
		"sounds" = {
			"1.0" = "body_thud.wav"
		}
	},
	"4" = {
		"text" = "Postać ciemna, jak gdyby cień przemknęła prędko. Niewyraźnie, jakby nierealna zjawa. Wystarczyło mrugnięcie, a zniknęła. Czy to sen? Czy halucynacja alkoholowa?",
		"sounds" = {
			"1.0" = "body_thud.wav"
		}
	},
	"5" = {
		"text" = "Jak ćma do światła schodek po schodku zbliżałem się do prawdy kryjącej się w blasku latarni. Prawdy okrutnej, brutalnej, drastycznej, bezlitosnej… Moja sąsiadka… Słodka Doti martwa leżała w kałuży krwi.",
		"sounds" = {
			"1.0" = "body_thud.wav"
		}
	},
	"6" = {
		"text" = "Nie, nie, nie… To nie może być prawda! Nie mogę… A może to tylko kolejny koszmar? Może jutro Doti znów przywita mnie serdecznie, odkrywając rząd swoich śnieżnobiałych zębów, a po klatce rozniesie się zapach świeżych truskawek… Może…",
		"sounds" = {
			"1.0" = "body_thud.wav"
		}
	},
	"7" = {
		"text" = "O Boże… To nie może być prawda. Jutro obudzę się trzeźwy, a ta groteskowa fatamorgana pozostanie w przeszłości. Jezu, serce zaraz wyskoczy mi z piersi…",
		"sounds" = {
			"1.0" = "body_thud.wav"
		}
	},
	"8" = {
		"text" = "Usnąć… Uspokoić się… Obudzić się, kiedy wszystko znów będzie normalne… Normalniejsze… Tak…",
		"sounds" = {
			"1.0" = "body_thud.wav"
		}
	},
	"9" = {
		"text" = "Nie mogę znowu przez to przechodzić…",
		"sounds" = {
			"1.0" = "body_thud.wav"
		}
	},
}

var current_frame : String
@onready var label: Label = $MarginContainer/Label


func _ready() -> void:
	current_frame = str(1)
	fade_out.texture = load(FRAME_PATH + FRAME_NAME + current_frame + FRAME_EXTENSION)
	label.text = frame_data[current_frame]["text"]

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed == true and event.button_index == MOUSE_BUTTON_LEFT:
		_switch_frame()

func _switch_frame():
	label.hide()
	current_frame = str(int(current_frame) + 1)
	if !frame_data.has(current_frame):
		get_tree().change_scene_to_file("res://game/game.tscn")
		print_debug("prolog_finished")
		return
	fade_in.texture = load(FRAME_PATH + FRAME_NAME + current_frame + FRAME_EXTENSION)
	
	for sound_offset in frame_data[current_frame]["sounds"]:
		var timer = Timer.new()
		$AudioStreamPlayer.add_child(timer)
		timer.connect("timeout", _play_sound.bind(timer, SOUND_PATH + frame_data[current_frame]["sounds"][sound_offset]))
		timer.start(float(sound_offset))
	label.text = frame_data[current_frame]["text"]
	
	var out_tween = fade_out.create_tween()
	var in_tween = fade_in.create_tween()
	const TWEEN_TIME = 1.0
	out_tween.tween_property(fade_out, "modulate", Color("ffffff00"), TWEEN_TIME)
	in_tween.tween_property(fade_in, "modulate", Color("ffffffff"), TWEEN_TIME)
	await get_tree().create_timer(TWEEN_TIME).timeout
	out_tween.kill()
	in_tween.kill()
	label.show()
	
	if !frame_data.has(current_frame):
		print_debug("!!prolog finished")
		return
	fade_out.texture = load(FRAME_PATH + FRAME_NAME + current_frame + FRAME_EXTENSION)
	fade_out.modulate = Color("ffffffff")
	fade_in.modulate = Color("ffffff00")

func _play_sound(timer : Timer, stream : String):
	timer.queue_free()
	$AudioStreamPlayer.stream = load(stream)
	$AudioStreamPlayer.play()
