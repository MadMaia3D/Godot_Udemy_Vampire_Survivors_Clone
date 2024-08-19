extends Node

signal experience_vial_collected(exp_value: float)

func emit_experience_vial_collected(exp_value: float):
#	emit_signal("experience_vial_collected", exp_value)
	experience_vial_collected.emit(exp_value)

