class_name Player
extends CharacterBody2D

var number_colliding_bodies: int = 0
var base_speed: float

@onready var velocity_component: VelocityComponent = $VelocityComponent as VelocityComponent
@onready var damage_interval_timer: Timer = $DamageIntervalTimer as Timer
@onready var health_component: HealthComponent = $HealthComponent as HealthComponent
@onready var health_bar: ProgressBar = $HealthBar as ProgressBar
@onready var abilities: Node = $Abilities as Node
@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer
@onready var visuals: Node2D = $Visuals as Node2D


func _ready():
	base_speed = velocity_component.speed
	connect_signals()
	update_health_display()


func connect_signals() -> void:
	var damage_area_2d: Area2D = $DamageArea2D
	damage_area_2d.body_entered.connect(on_body_entered)
	damage_area_2d.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
	health_component.health_changed.connect(on_health_changed)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func _process(delta):
	var movement_vector = get_input_vector()
	var direction = movement_vector.normalized()
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)


func get_input_vector() -> Vector2:
	var movement_vector = Vector2.ZERO
	movement_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	movement_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return movement_vector


func update_animations(movement_vector: Vector2) -> void:
	if movement_vector == Vector2.ZERO:
		animation_player.play("RESET")
	else:
		animation_player.play("walk")
		var direction = sign(movement_vector.x)
		if direction != 0:
			visuals.scale.x = direction


func check_deal_damage():
	if number_colliding_bodies == 0 or not damage_interval_timer.is_stopped():
		return
	health_component.damage(0.5)
	damage_interval_timer.start()


func update_health_display() -> void:
	health_bar.value = health_component.get_health_percent()


func on_body_entered(body: Node2D) -> void:
	number_colliding_bodies += 1
	check_deal_damage()


func on_body_exited(body: Node2D) -> void:
	number_colliding_bodies -= 1


func on_damage_interval_timer_timeout():
	check_deal_damage()


func on_health_changed() -> void:
	GameEvents.player_damaged.emit()
	update_health_display()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if upgrade is Ability:
		var new_ability: Ability = upgrade as Ability
		abilities.add_child(new_ability.ability_controller_scene.instantiate())
	elif upgrade.id == "move_speed":
		velocity_component.speed = base_speed * (1 + current_upgrades[upgrade.id]["quantity"] * 0.1)
	
