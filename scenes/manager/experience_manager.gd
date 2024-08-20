extends Node
class_name ExperienceManager

signal experience_updated(current_experience: float, target_experience: float)

const TARGET_EXPERIENCE_GROWTH = 5

var current_experience: float = 0
var current_level: int = 1
var target_experience: float = 5


func _ready():
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)



func increment_experience(value: float) -> void:
	current_experience += value
	experience_updated.emit(current_experience, target_experience)
	while current_experience >= target_experience:
		current_experience -= target_experience
		current_level +=1
		target_experience += TARGET_EXPERIENCE_GROWTH
		experience_updated.emit(current_experience, target_experience)



func on_experience_vial_collected(value: float) -> void:
	increment_experience(value)
