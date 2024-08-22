extends Node2D

@onready var animation_player = $AnimationPlayer
@export var health_component: HealthComponent

func _ready() -> void:
	health_component.died.connect(on_health_component_died)


func on_health_component_died() -> void:
	var owner_parent: Node2D = owner.get_parent()
	var owner_global_position: Vector2 = owner.global_position
	get_parent().remove_child(self)
	owner_parent.add_child(self)
	global_position = owner_global_position
	animation_player.play("default")
