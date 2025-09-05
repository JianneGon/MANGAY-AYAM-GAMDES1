extends Node2D

# 1. load the scene
var enemy_scene: PackedScene = load("res://enemy.tscn")
func _on_meteor_timer_timeout() -> void:
#2. create an instance
	var enemy = enemy_scene.instantiate()
#3. attach the node to the scene tree
	$Meteors.add_child(enemy)
# print('peow! peow! peow! ') # Replace with function body.
