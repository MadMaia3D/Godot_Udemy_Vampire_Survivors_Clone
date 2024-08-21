# @tool
# class_name
class_name AxeAbility
# extends
extends Node2D
# signals
# enums
# constants
const MIN_RADIUS: float = 10
const MAX_RADIUS: float = 100
const N_ROTATIONS: float = 3.0
const TWEEN_DURATION: float = 3.0
# export variables
# variables
var player: Node2D
var base_rotation: Vector2 = Vector2.RIGHT
# onready variables
@onready var hitbox_component: HitboxComponent = $HitboxComponent
# methods
func _ready():
	player = get_tree().get_first_node_in_group("player") as Node2D
	base_rotation = Vector2.RIGHT.rotated(randf_range(-PI, PI))
	var tween = create_tween()
	tween.tween_method(tween_method, 0.0, N_ROTATIONS, TWEEN_DURATION)
	tween.tween_callback(queue_free)


func tween_method(current_rotation: float):
	if player == null:
		push_warning("Can't get player reference")
		return
	
	var percent : float = current_rotation / N_ROTATIONS
	var current_radius: float = MIN_RADIUS + (MAX_RADIUS - MIN_RADIUS) * percent
	var current_direction: Vector2 = base_rotation.rotated(current_rotation * TAU)
	rotation =  current_rotation * TAU * 2
	global_position = player.global_position + current_direction * current_radius
