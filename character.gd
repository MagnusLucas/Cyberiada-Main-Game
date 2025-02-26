extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


var the_pickable_item
var item_area = false

#do sortowania itemów
func sort_by_index(a, b):
			return a[1] < b[1]


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Interact/take items
	if Input.is_action_just_pressed("interact"):
		#tworzy tabelę z itemami w zasięgu i sortuje je od najbliższego do najdalszego
		var item_tab = []
		
		#print($interactable_area.get_overlapping_bodies())
		for i in $interactable_area.get_overlapping_bodies():
			if i.is_in_group("pickable"):
				item_tab.append([i,position.distance_to(i.position)])
		item_tab.sort_custom(sort_by_index)
		#print(item_tab)
		#sprawdza czy w tej tabeli coś jest bo jak nie to sie wykrzacza
		if len(item_tab) >0:
			the_pickable_item = item_tab[0][0]
			#print(the_pickable_item)
			#nie pamiętam już czym było can take ale było w poprzedniej wersji so
			if the_pickable_item.can_take:
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
	
	#testowa animacja żeby działała w otworzeniu
