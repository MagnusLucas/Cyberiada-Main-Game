extends Node3D
var t = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	add_child(t)
	t.one_shot = false
	t.wait_time = 1 #2137
	t.timeout.connect(dive)
	t.autostart = true
	t.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func dive():
	#print('uwu', t.wait_time)
	#THE ANANAS IS HEREEE
	if position.y < -3:
		for i in range(20):
			await get_tree().create_timer(0.1).timeout
			self.position.y = lerp(self.position.y,-0.623,0.5)
		t.wait_time = 2137
	elif position.y > -0.7: 
		for i in range(20):
			await get_tree().create_timer(0.1).timeout
			self.position.y = lerp(self.position.y,-3.363,0.5)
		t.wait_time = 3
	
	
