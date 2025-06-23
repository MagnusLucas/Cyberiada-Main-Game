extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5


var the_pickable_item
var item_area = false
#zmienne służące do sprawdzania ruchu postaci na osi z żeby dostosowywać się do ruchu
var start_kam
var do_kam_1 = position.z 
var do_kam_2
var do_kam_diff
var kamz = position.z
var zoom = 0
#do sortowania itemów
func sort_by_index(a, b):
	return a[1] < b[1]

var inv : Array[String] = []
#dźwięk
var audio_path = "res://audio/krok_"+str(randi_range(1,4))+".wav"
var sound_timer : Timer

var dialogues_state : Dictionary = {}

func _ready() -> void:
	sound_timer = Timer.new()
	sound_timer.autostart = true
	sound_timer.set_one_shot(true)
	add_child(sound_timer)
	start_kam = $Camera_control.position.z
	
func _get_closest_interactable() -> Area3D:
	#tworzy tabelę z itemami w zasięgu i sortuje je od najbliższego do najdalszego
	var npc_tab = []
	for i in $interactable_area.get_overlapping_areas(): #these are the human bodies (NPCs)
		npc_tab.append([i,position.distance_to(i.position)])
	npc_tab.sort_custom(sort_by_index)
	if npc_tab.size() > 0:
		return npc_tab[0][0]
	return null


func try_to_interact(interactable : Area3D) -> void:
	if interactable is Item:
		interactable.taken()
	elif interactable is NPC:
		interactable.start_dialog()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Interact/take items
	if Input.is_action_just_pressed("interact"):
		try_to_interact(_get_closest_interactable())
	
	
	do_kam_1 = position.z 
	# Handle jump.
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$AudioStreamPlayer.play()
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("go_left", "go_right", "go_up", "go_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction != Vector3(0,0,0):
		#detektyw kręci się kinda smooth
		$Detektyw.rotation = Vector3(0 , lerp_angle($Detektyw.rotation[1],Vector2(direction[2],direction[0]).angle(),0.2) , 0)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if not is_on_floor():
		#warunek do pierwszej pozycji skoku
		#if velocity.y >0:
		$Detektyw/AnimationPlayer.play("Tpose")
	elif velocity.x !=0 or velocity.z != 0:
		$Detektyw/AnimationPlayer.play("Walking")
		#dźwięk contuwued
		#print($AudioStreamPlayer.playing, sound_timer.time_left == 0, sound_timer.time_left)
		if $AudioStreamPlayer.playing == false and sound_timer.time_left == 0:
			audio_path = "res://audio/krok_"+str(randi_range(1,4))+".wav"
			$AudioStreamPlayer.stream = load(audio_path)
			sound_timer.start(randf_range(0.5,0.5)) 
			$AudioStreamPlayer.play()
		
	else:
		$Detektyw/AnimationPlayer.play("Standing")
			
	
		
		
	
	if is_inside_tree():
		move_and_slide()
	
	#to wszystko wyłapuje jak daleko ruszałaby się kamera gdyby ruszała się z kamerą
	do_kam_2 = position.z
	do_kam_diff = do_kam_1 - do_kam_2 
	#mnożnik żeby ogarnąć jak mały ma być efekt kamery ruchem do przodu i do tyłu 
	kamz = kamz - (do_kam_diff * 0.25)
	$Camera_control.position.z = lerp($Camera_control.position.z, kamz + 6 + zoom, 0.08)
	#Camera smoothing based on a yt tutorialsssssss/
	$Camera_control.position.x = lerp($Camera_control.position.x, position.x, 0.08)
	$Camera_control.position.y = lerp($Camera_control.position.y, position.y, 0.08)
	#ps: the other camera in camera control is purely for "hey this is kinda cool" purpose
	#Camera control is for this to be linked to camera, Camera pos is for offset, and cameras are to see

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var zoom_limit = (self.position.z - start_kam) * (-1)
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				print(zoom_limit, ' ',zoom)
				var zoom_scale:float = 2.0 ** (-event.factor if event.factor else 1.0)
				if zoom <= zoom_limit:
					zoom += zoom_scale
				

			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				var zoom_scale:float = 2.0 ** (-event.factor if event.factor else -1.0)
				#jeżeli zoom jest większy od limitu
				if zoom >= zoom_limit * (-2):
					#zmniejsza zooma aka przybliża
					zoom -= zoom_scale
