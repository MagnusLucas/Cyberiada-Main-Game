extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5


#zmienne służące do sprawdzania ruchu postaci na osi z żeby dostosowywać się do ruchu
var do_kam_1 = position.z 
var do_kam_2
var kamz = position.z
var kam_fov : float = 75
var SceneCameraOffset = Vector3(0,0,4)

#do sortowania itemów
func sort_by_index(a, b):
	return a[1] < b[1]

var inv : Array[String] = []
var sound_timer : Timer

var dialogues_state : Dictionary = {}

func _ready() -> void:
	sound_timer = Timer.new()
	sound_timer.autostart = true
	sound_timer.set_one_shot(true)
	add_child(sound_timer)
	
func _get_closest_interactable() -> Area3D:
	var interactable_tab = []
	for i in $interactable_area.get_overlapping_areas(): 
		interactable_tab.append([i,position.distance_to(i.position)])
	interactable_tab.sort_custom(sort_by_index)
	if interactable_tab.size() > 0:
		return interactable_tab[0][0]
	return null

func reset_camera(z_offset : float) -> void:
	$Camera_control/Camera_pos.position.z = z_offset

func try_to_interact(interactable : Area3D) -> void:
	if interactable is Item:
		interactable.take()
	elif interactable is NPC:
		if dialogues_state.has(interactable.name):
			interactable.start_dialog(dialogues_state[interactable.name])
		interactable.start_dialog()
	elif interactable is Passage:
		interactable.use(inv)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
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
	
	# Saving position before movement
	do_kam_1 = position.z 
	
	# Moving the character
	if is_inside_tree():
		move_and_slide()
	
	# Adjusting camera
	#to wszystko wyłapuje jak daleko ruszałaby się kamera gdyby ruszała się z kamerą
	do_kam_2 = position.z
	var do_kam_diff = do_kam_1 - do_kam_2 
	#mnożnik żeby ogarnąć jak mały ma być efekt kamery ruchem do przodu i do tyłu 
	kamz = kamz - (do_kam_diff * 0.25)
	#Camera smoothing based on a yt tutorialsssssss/
	const CAMERA_WEIGHT = 0.06
	$Camera_control/Camera_pos/Camera3D.fov = lerp($Camera_control/Camera_pos/Camera3D.fov, kam_fov ,CAMERA_WEIGHT)
	$Camera_control.position.z = lerp($Camera_control.position.z, kamz, CAMERA_WEIGHT)
	$Camera_control.position.x = lerp($Camera_control.position.x, position.x, CAMERA_WEIGHT)
	$Camera_control.position.y = lerp($Camera_control.position.y, position.y, CAMERA_WEIGHT)
	#ps: the other camera in camera control is purely for "hey this is kinda cool" purpose
	#Camera control is for this to be linked to camera, Camera pos is for offset, and cameras are to see
	
	
	
	
	# Character animation
	if not is_on_floor():
		$Detektyw/AnimationPlayer.play("Tpose")
	elif velocity.x !=0 or velocity.z != 0:
		$Detektyw/AnimationPlayer.play("Walking")
		if $AudioStreamPlayer.playing == false and sound_timer.time_left == 0:
			var audio_path = "res://game/audio/SFX/footsteps/krok_"+str(randi_range(1,4))+".wav"
			$AudioStreamPlayer.stream = load(audio_path)
			sound_timer.start(randf_range(0.5,0.5)) 
			$AudioStreamPlayer.play()
	else:
		$Detektyw/AnimationPlayer.play("Standing")
	
	
	# Interact/take items
	if Input.is_action_just_pressed("interact"):
		try_to_interact(_get_closest_interactable())
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			const MIN_ZOOM = 100
			const MAX_ZOOM = 20
			
			var zoom_scale:float = 5 * (event.factor if event.factor else 1.0)
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if kam_fov + zoom_scale < MIN_ZOOM:
					kam_fov += zoom_scale

			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				#jeżeli zoom jest większy od limitu
				if kam_fov - zoom_scale > MAX_ZOOM:
					#zmniejsza zooma aka przybliża
					kam_fov -= zoom_scale
