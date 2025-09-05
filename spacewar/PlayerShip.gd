extends CharacterBody2D

# Exported variable for easy adjustment in the editor
@export var speed: int = 500

# Screen dimensions
var screen_width: int = 1024
var screen_height: int = 600

# Laser variables
var laser_scene = preload("res://bullet.tscn")
var laser_cooldown: float = 0.2
var last_shot_time: float = 0.0

# Called when the node enters the scene tree for the first time
func _ready():
	# Starting position
	position = Vector2(200, 500)
	# Ship scale
	scale = Vector2(0.5, 0.5)

# Called every frame, delta is the elapsed time since the last frame
func _process(delta):
	# Get input vector (WASD/arrow keys must be mapped in InputMap: "left","right","up","down")
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()

	# Clamp ship inside screen
	position.x = clamp(position.x, 0, screen_width)
	position.y = clamp(position.y, 0, screen_height - 100)

	# Fire laser with cooldown
	last_shot_time += delta
	if Input.is_action_pressed("ui_accept") and last_shot_time >= laser_cooldown:
		fire_laser()

# Laser firing function
func fire_laser():
	
	last_shot_time = 0.0
		
	if laser_scene == null:
		print_debug("Laser scene failed to load!")
		return

	var laser = preload("res://bullet.tscn").instantiate()
	laser.position = position + Vector2(0, -20)
	get_parent().add_child(laser)
	if laser == null:
		print_debug("Failed to instantiate laser!")
		return

	# Start laser just above the ship
	laser.position = position + Vector2(0, -20)
	get_parent().add_child(laser)
	print_debug("Laser fired at position: ", laser.position)

	# Optional: connect to cleanup if bullet goes off-screen
	laser.connect("tree_entered", Callable(self, "_on_laser_entered"))

# Cleanup when laser leaves screen
func _on_laser_entered():
	for child in get_parent().get_children():
		if child.name == "Laser" and (child.position.y < 0 or child.position.y > screen_height):
			child.queue_free()
