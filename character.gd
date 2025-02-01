extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

#Item area mówi czy jakiś item jest w area iterakcji
var item_area = false

var the_pickable_item

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Interact/take items
	if Input.is_action_just_pressed("interact"):
		if item_area:
			if the_pickable_item.is_in_group("pickable") and the_pickable_item.can_take:
				the_pickable_item.taken()
		
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("go_left", "go_right", "go_up", "go_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	#Camera smoothing based on a yt tutorialsssssss
	$Camera_control.position = lerp($Camera_control.position, position, 0.08)
	#ps: the other camera in camera control is purely for "hey this is kinda cool" purpose
	#Camera control is for this to be linked to camera, Camera pos is for offset, and cameras are to see
	

func item_area_entered(body: Node3D) -> void:
	the_pickable_item = body
	item_area = true

func item_area_exit(_body: Node3D) -> void:
	item_area = false
	
	
