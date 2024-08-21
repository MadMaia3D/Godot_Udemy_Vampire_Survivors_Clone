
extends Node

@export var axe_ability_scene: PackedScene

var player: Node2D
var foreground_layer: Node2D
var damage: float = 5.0

@onready var timer = $Timer


func _ready():
	player = get_tree().get_first_node_in_group("player") as Node2D
	foreground_layer = get_tree().get_first_node_in_group("foreground_layer") as Node2D
	timer.timeout.connect(on_timer_timeout)


func on_timer_timeout() -> void:
	if player == null:
		push_warning("Can't get player reference")
		return
	if foreground_layer == null:
		push_warning("Can't get foreground_layer reference")
		return
	if axe_ability_scene == null:
		push_warning("Can't get foreground_layer reference")
		return
	
	var axe_instance: Node2D = axe_ability_scene.instantiate() as Node2D
	foreground_layer.add_child(axe_instance)
	axe_instance.global_position = player.global_position
	axe_instance.hitbox_component.damage = damage
