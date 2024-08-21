extends Node


@export var basic_enemy_scene: PackedScene
@export var arena_time_manager: Node

var spawn_radius = 250
var timer_base_time: float

@onready var timer = $Timer


func _ready():
	connect_signals()
	timer_base_time = timer.wait_time


func connect_signals() -> void:
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)


func spawn_enemy() -> void:
	var player: Node2D = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var spawn_position: Vector2 = get_spawn_position(player)
	while spawn_position == Vector2.ZERO:
		spawn_position = get_spawn_position(player)
	
	var enemy_instance: Node2D = basic_enemy_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy_instance)
	enemy_instance.global_position = spawn_position


func get_spawn_position(player: Node2D) -> Vector2:
	var random_angle: float = randf_range(-PI, PI)
	var random_direction: Vector2 = Vector2.RIGHT.rotated(random_angle)
	var spawn_position: Vector2 = player.global_position + (random_direction * spawn_radius)
	
	var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1)
	var intersection: Dictionary = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)
	
	if intersection.is_empty():
		return spawn_position
	else:
		return Vector2.ZERO


func on_timer_timeout():
	spawn_enemy()


func on_arena_difficulty_increased(arena_difficult: int):
	var next_difficulty_wait_time = timer_base_time - arena_difficult * 0.05
	timer.wait_time = max(next_difficulty_wait_time, 0.3)
