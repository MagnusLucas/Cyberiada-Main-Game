extends Node

func play_sfx(path = "res://UI/shared/button_click.wav"):
	$SFX.stream = load(path)
	$SFX.play()
	

func play_music(path = "res://UI/shared/audio/menu.mp3"):
	$Music.stream = load(path)
	$Music.play()
	$Music.stream.loop = true
