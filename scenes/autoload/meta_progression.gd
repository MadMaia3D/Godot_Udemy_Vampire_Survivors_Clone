extends Node

var save_data: Dictionary = {
	"meta_upgrades_currency": 0,
	"meta_upgrades": {}
}

func _ready():
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)


func add_meta_upgrade(upgrade: MetaUpgrade) -> void:
	if not save_data["meta_upgrades"].has(upgrade.id):
		save_data["meta_upgrades"][upgrade.id] = {
			"quantity": 0
			}
	save_data["meta_upgrades"][upgrade.id]["quantity"] += 1


func on_experience_vial_collected(exp_value: float) -> void:
	save_data["meta_upgrades_currency"] += exp_value
