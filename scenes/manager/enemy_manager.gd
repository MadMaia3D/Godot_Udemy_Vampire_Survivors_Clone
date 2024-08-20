extends Node

var spawn_radius = 250

@export var basic_enemy_scene: PackedScene


func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player: Node2D = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var random_angle: float = randf_range(-PI, PI)
	var random_direction: Vector2 = Vector2.RIGHT.rotated(random_angle)
	var spawn_position: Vector2 = player.global_position + (random_direction * spawn_radius)
	
	var enemy_instance: Node2D = basic_enemy_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy_instance)
	enemy_instance.global_position = spawn_position
