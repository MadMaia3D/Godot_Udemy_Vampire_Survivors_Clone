extends CharacterBody2D


@onready var visual = $Visual
@onready var velocity_component: VelocityComponent = $VelocityComponent


func _process(delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	update_animation()


func update_animation() -> void:
	var flip = sign(velocity.x)
	if velocity.x != 0.0:
		visual.scale.x = flip
