extends Area2D
class_name HurtboxComponent

signal hit

@export var health_component: HealthComponent

var floating_text_scene: PackedScene = preload("res://scenes/UI/floating_text.tscn") as PackedScene


func _ready():
	area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D) -> void:
	if not other_area is HitboxComponent:
		return	
	if health_component == null:
		return
	
	var hitbox_component = other_area as HitboxComponent
	health_component.damage(hitbox_component.damage)
	
	var floating_text: Node2D = floating_text_scene.instantiate() as Node2D
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text)
	floating_text.global_position = global_position + 20 * Vector2.UP
	floating_text.start(str(hitbox_component.damage));
	
	hit.emit()
