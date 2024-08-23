extends Node

const MAX_RANGE: float = 150.0

@export var sword_ability: PackedScene

var player: Node2D
var base_wait_time: float
var base_damage: float = 5.0
var damage_multiplier: float = 1.0

@onready var timer: Timer = $Timer


func _ready():
	timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	player = get_tree().get_first_node_in_group("player") as Node2D
	base_wait_time = timer.wait_time


func on_timer_timeout():
	spawn_sword_ability()


func spawn_sword_ability() -> void:
	if player == null: return
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	enemies = enemies.filter(filter_near_enemies)
	
	if enemies.size() == 0: return
	
	enemies.sort_custom(sort_by_distance)
	var target_enemy: Node2D = enemies[0]
	
	var sword_instance: SwordAbility = sword_ability.instantiate() as SwordAbility
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	foreground_layer.add_child(sword_instance)
	sword_instance.hitbox_component.damage = base_damage * damage_multiplier
	sword_instance.global_position = target_enemy.global_position
	var enemy_direction: Vector2 = target_enemy.global_position - player.global_position
	sword_instance.rotation = enemy_direction.angle()
	sword_instance.move_local_x(-30.0)


func filter_near_enemies(enemy: Node2D):
	var distance_squared_to_player = enemy.global_position.distance_squared_to(player.global_position)
	return distance_squared_to_player < pow(MAX_RANGE, 2)


func sort_by_distance(a: Node2D, b: Node2D) -> bool:
	var distance_a = a.global_position.distance_squared_to(player.global_position)
	var distance_b = b.global_position.distance_squared_to(player.global_position)
	return distance_a < distance_b


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "sword_rate":
		timer.wait_time *= 0.9
		var percent_reduction = current_upgrades["sword_rate"]["quantity"] * 0.1
		var new_wait_time = max(base_wait_time * (1 - percent_reduction), 0.1)
		timer.wait_time = new_wait_time
		timer.start()
	elif upgrade.id == "sword_damage":
		damage_multiplier = 1 + current_upgrades["sword_damage"]["quantity"] * 0.2
		print("sword damage increased to " + str(damage_multiplier))

