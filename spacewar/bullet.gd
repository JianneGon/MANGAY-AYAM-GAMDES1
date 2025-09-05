extends Node2D  # Assuming the Laser is a Node2D

# Speed of the laser
var speed: float = 500  # Speed of the laser's movement

func _ready():
	# Connect the signal for collision
	connect("area_entered", Callable(self, "_on_area_entered"))

func _process(delta: float) -> void:
	# Move the bullet upward
	position.y -= speed * delta

	# If off-screen, remove it
	if position.y < -10:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		print("Bullet hit Enemy:", area.name)
		area.queue_free()   # destroy enemy
		queue_free()        # destroy bullet
