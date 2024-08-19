extends Node
class_name HealthComponent

signal died

@export var max_health: int = 10
var current_health


func _ready():
	current_health = max_health


func damage(value: int) -> void:
	current_health = max(0, current_health - value)
	Callable(check_death).call_deferred()


func check_death() -> void:
	if current_health == 0:
		died.emit()
		owner.queue_free()
	
