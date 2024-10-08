extends Node

@export var sprite_2d: Sprite2D
@export var health_component: HealthComponent
@export var hit_material: Material

var hit_flash_tween: Tween


func _ready():
	health_component.health_changed.connect(on_health_changed)
	sprite_2d.material = hit_material


func on_health_changed() -> void:
	if hit_flash_tween != null && hit_flash_tween.is_valid():
		hit_flash_tween.kill()
	
	(sprite_2d.material as ShaderMaterial).set_shader_parameter("lerp_percent", 1.0)
	hit_flash_tween = create_tween()
	hit_flash_tween.tween_property(sprite_2d.material, "shader_parameter/lerp_percent", 0.0, 0.2)
