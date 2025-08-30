extends Node2D  # Assuming Playership1 is a Node2D

# Speed of the ship's movement
var speed: int = 400

# Screen width to keep the ship inside the frame
var screen_width: int = 1024  # Adjust according to your resolution
var screen_height: int = 600  # Adjust according to your resolution

# Laser variables
var laser_scene = preload("res://bullet.tscn")  # Path to your Laser scene
var laser_cooldown: float = 0.2  # Cooldown time between shots (in seconds)
var last_shot_time: float = 0  # Time of the last shot

func _process(delta):
	# Movement input (Arrow keys and WASD)
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("move_right"):
		position.x += speed * delta  # Move right
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("move_left"):
		position.x -= speed * delta  # Move left
	
	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("move_up"):
		position.y -= speed * delta  # Move up
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("move_down"):
		position.y += speed * delta  # Move down

	# Keep Playership1 inside the screen bounds
	position.x = clamp(position.x, 0, screen_width)  # Clamp X position to the screen width
	position.y = clamp(position.y, 0, screen_height - 100)  # Clamp Y position to the screen height

	# Fire laser when Spacebar is pressed, with cooldown management
	if Input.is_action_just_pressed("ui_accept") and last_shot_time >= laser_cooldown:
		fire_laser(delta)

	# Handle laser firing cooldown
	last_shot_time += delta  # Increment cooldown timer by delta time
	if last_shot_time >= laser_cooldown:
		last_shot_time = laser_cooldown  # Clamp to the cooldown value


# Laser firing function
func fire_laser(delta):
	last_shot_time = 0  # Reset cooldown

	# Check if laser scene is loaded properly
	if laser_scene == null:
		print_debug("Laser scene failed to load!")
		return

	# Create an instance of the laser
	var laser = laser_scene.instance()

	# Check if the laser instance is valid
	if laser == null:
		print_debug("Failed to instantiate laser!")
		return

	# Set the laser's starting position just above the Playership1
	laser.position = position + Vector2(0, -20)  # Adjust offset if needed

	# Add the laser to the scene
	get_parent().add_child(laser)
	print_debug("Laser fired at position: ", laser.position)  # Debugging

	# Ensure laser doesn't move off-screen by limiting its movement
	laser.connect("tree_entered", self, "_on_laser_entered")

# This function will ensure laser is removed once it's off-screen
func _on_laser_entered():
	var laser = get_parent().get_node("Laser")  # Assuming your laser node is named Laser
	if laser.position.y < 0 or laser.position.y > screen_height:
		laser.queue_free()  # Free the laser node if it goes off-screen
