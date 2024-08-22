extends CharacterBody2D

@onready var visuals = $Visuals
@onready var velocity_component: VelocityComponent = $VelocityComponent as VelocityComponent


func _process(delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	update_animation()


func update_animation() -> void:
	var flip: int = sign(velocity.x)
	if flip != 0:
		visuals.scale.x = flip
