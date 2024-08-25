extends Node

signal experience_vial_collected(exp_value: float)
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)
signal player_damaged
signal game_paused
signal game_unpaused


func emit_experience_vial_collected(exp_value: float):
	experience_vial_collected.emit(exp_value)


func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	ability_upgrade_added.emit(upgrade, current_upgrades)


func emit_player_damaged() -> void:
	player_damaged.emit()


func pause_game() -> void:
	get_tree().paused = true
	game_paused.emit()


func unpause_game() -> void:
	get_tree().paused = false
	game_unpaused.emit()
