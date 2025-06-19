extends Node

func play_sfx(path = "res://audio/lethal_company_mine_sfx.wav"):
	$SFX.stream = load(path)
	$SFX.play()
	

func play_music(path = "res://audio/muzyka-zapychacz1.mp3"):
	$Music.stream = load(path)
	$Music.play()
	$Music.stream.loop = true
