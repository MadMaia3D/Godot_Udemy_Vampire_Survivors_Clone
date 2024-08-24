class_name VelocityComponent
extends Node

@export var speed: float = 40
@export var acceleration: float = 5

var velocity: Vector2 = Vector2.ZERO


func accelerate_to(target: Node2D) -> void:
	var ownner_node2d = owner as Node2D
	var direction: Vector2 = ownner_node2d.global_position.direction_to(target.global_position)
	accelerate_in_direction(direction)


func accelerate_to_player() -> void:
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node:
		accelerate_to(player_node)


func accelerate_in_direction(direction: Vector2) -> void:
	var desired_velocity = direction * speed
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time()))


func move(character_body: CharacterBody2D) -> void:
	character_body.velocity = velocity
	character_body.move_and_slide()
	velocity = character_body.velocity
