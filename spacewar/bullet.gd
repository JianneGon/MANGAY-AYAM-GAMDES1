extends Node2D  # Assuming the Laser is a Node2D

# Speed of the laser
var speed: float = 500  # Speed of the laser's movement

func _process(delta):
	# Move the laser upwards
	position.y -= speed * delta

	# If the laser goes off the top of the screen, remove it
	if position.y < -10:
		queue_free()  # Free the laser node
