extends CharacterBody2D

const MAX_SPEED : float = 30.0

@onready var health_component: HealthComponent = $HealthComponent
@onready var visual = $Visual


func _process(delta):
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()
	update_animation(direction)


func update_animation(direction) -> void:
	var flip = sign(direction.x)
	if direction.x != 0.0:
		visual.scale.x = flip


func get_direction_to_player() -> Vector2:
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node:
		return global_position.direction_to(player_node.global_position)
	return Vector2.ZERO
