extends Node

var current_experience: float = 0


func _ready():
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)


func increment_experience(value: float) -> void:
	current_experience += value


func on_experience_vial_collected(value: float) -> void:
	increment_experience(value)
