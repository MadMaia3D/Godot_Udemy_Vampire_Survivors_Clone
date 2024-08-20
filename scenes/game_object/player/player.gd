extends CharacterBody2D

const MAX_SPEED: float = 40.0
const ACCELERATION_SMOOTHING: float = 10

var number_colliding_bodies: int = 0

@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent


func _ready():
	var damage_area_2d = $DamageArea2D
	damage_area_2d.body_entered.connect(on_body_entered)
	damage_area_2d.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)


func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	var target_velocity = direction * MAX_SPEED
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()


func get_movement_vector() -> Vector2:
	var movement_vector = Vector2.ZERO
	movement_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	movement_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return movement_vector


func check_deal_damage():
	if number_colliding_bodies == 0 or not damage_interval_timer.is_stopped():
		return
	health_component.damage(1)
	damage_interval_timer.start()
	print(health_component.current_health)


func on_body_entered(body: Node2D) -> void:
	number_colliding_bodies += 1
	check_deal_damage()


func on_body_exited(body: Node2D) -> void:
	number_colliding_bodies -= 1


func on_damage_interval_timer_timeout():
	check_deal_damage()
