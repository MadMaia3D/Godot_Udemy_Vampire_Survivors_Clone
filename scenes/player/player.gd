extends CharacterBody2D

const MAX_SPEED : float = 40.0


func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_movement_vector() -> Vector2:
	var movement_vector = Vector2.ZERO
	movement_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	movement_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return movement_vector
