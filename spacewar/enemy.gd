extends Node2D  # Assuming meteors are of type Node2D

# Meteor speed (can be randomized for variety)
var speed: float = 200  # Speed of the meteor's fall
var screen_height: int = 600  # Screen height (adjust this based on your game resolution)

func _ready():
	# You can initialize a random speed or direction if desired
	speed = randf_range(150.0, 300.0)  # Randomize speed between 150 and 300 units per second

func _process(delta):
	# Move the meteor downwards
	position.y += speed * delta

	# If the meteor goes off the bottom of the screen, reset it to the top
	if position.y > screen_height:
		position.y = -10  # Set it slightly above the screen
		position.x = randf_range(0.0, get_viewport().size.x)  # Randomize the X position to spread the meteors
