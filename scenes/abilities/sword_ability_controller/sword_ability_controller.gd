extends Node

const MAX_RANGE: float = 150.0

@export var sword_ability: PackedScene

var player: Node2D



func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	player = get_tree().get_first_node_in_group("player") as Node2D



func on_timer_timeout():
	if player == null: return
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	enemies = enemies.filter(filter_near_enemies)
	
	if enemies.size() == 0: return
	
	enemies.sort_custom(sort_by_distance)
	
	var sword_instance = sword_ability.instantiate() as Node2D
	player.get_parent().add_child(sword_instance)
	sword_instance.global_position = enemies[0].global_position



func filter_near_enemies(enemy: Node2D):
	var distance_squared_to_player = enemy.global_position.distance_squared_to(player.global_position)
	return distance_squared_to_player < pow(MAX_RANGE, 2)



func sort_by_distance(a: Node2D, b: Node2D) -> bool:
	var distance_a = a.global_position.distance_squared_to(player.global_position)
	var distance_b = b.global_position.distance_squared_to(player.global_position)
	return distance_a < distance_b
