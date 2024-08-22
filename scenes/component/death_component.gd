extends Node2D

@export var texture: Texture2D
@export var health_component: HealthComponent

@onready var animation_player = $AnimationPlayer
@onready var cpu_particles_2d = $CPUParticles2D


func _ready() -> void:
	health_component.died.connect(on_health_component_died)
	cpu_particles_2d.texture = texture


func on_health_component_died() -> void:
	if owner == null:
		return
	var owner_parent: Node2D = owner.get_parent()
	var owner_global_position: Vector2 = owner.global_position
	get_parent().remove_child(self)
	owner_parent.add_child(self)
	global_position = owner_global_position
	animation_player.play("default")
