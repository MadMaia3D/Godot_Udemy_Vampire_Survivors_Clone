extends Node

@export var sword_ability: PackedScene

var player: Node2D

func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	player = get_tree().get_first_node_in_group("player") as Node2D


func on_timer_timeout():
	if player:
		var sword_instance = sword_ability.instantiate() as Node2D
		player.get_parent().add_child(sword_instance)
		sword_instance.global_position = player.global_position
