extends Node2D


# Declare variables for movement
var speed: float = 400  # Rocket movement speed
var screen_width: int = 1024  # Screen width (adjust to match your game resolution)

func _ready():
	# Set up any initial values if needed
	pass

func _process(delta):
	# Handle movement input (left and right)
	var move_direction = Vector2.ZERO
	
	# Player input for left and right movement (arrow keys or WASD)
	if Input.is_action_pressed("ui_right"):  # Right arrow or "d"
		move_direction.x += 1
	if Input.is_action_pressed("ui_left"):  # Left arrow or "a"
		move_direction.x -= 1

	# Normalize movement to prevent faster diagonal movement (not needed here but good practice)
	if move_direction.length() > 0:
		move_direction = move_direction.normalized()

	# Move the rocket based on the direction
	position += move_direction * speed * delta

	# Ensure the rocket doesn't go off the screen
	if position.x < 0:
		position.x = 0  # Prevent moving left beyond the screen
	if position.x > screen_width:
		position.x = screen_width  # Prevent moving right beyond the screen
