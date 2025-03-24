extends CharacterBody2D

var speed: float = 900.0
var distance: float = 640.0
var direction: int = 1
var leftmost_position: Vector2
var rightmost_position: Vector2
var moving_left = false
var moving_right = true


func _on_ready() -> void:
	leftmost_position = position
	rightmost_position = Vector2(position.x + distance, position.y)
	
func _process(delta: float) -> void:
	# calculate new position
	position.x += speed * direction * delta
	
	# check if ladle has reached set distance
	if (moving_right == true and position.x >= rightmost_position.x):
		direction *= -1 # change direction
		moving_left = true
		moving_right = false
		# print("moving left now")
		
	if (moving_left == true and position.x <= leftmost_position.x):
		direction *= -1 # change direction
		moving_left = false
		moving_right = true
		# print("moving right now")
