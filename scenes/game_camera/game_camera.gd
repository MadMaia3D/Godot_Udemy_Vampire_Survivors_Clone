extends Camera2D


var target : Node2D = null


func _ready():
	make_current()
	acquire_target()
	global_position = target.global_position


func _process(delta):
	global_position = global_position.lerp(target.global_position, 1.0 - exp(-delta * 10))


func acquire_target():
	var player_nodes = get_tree().get_nodes_in_group("player")
	
	if player_nodes.size() > 0:
		target = player_nodes[0] as Node2D
