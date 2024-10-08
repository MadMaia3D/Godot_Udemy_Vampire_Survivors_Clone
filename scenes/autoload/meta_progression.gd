extends Node

var SAVE_FILE_PATH: String = "user://game.save"

var save_data: Dictionary = {
	"meta_upgrades_currency": 0,
	"meta_upgrades": {}
}


func _ready():
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)
	load_save_file()
	tree_exiting.connect(save_game)


func save_game():
	var file: FileAccess = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(save_data)


func load_save_file():
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return
	var file: FileAccess = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	save_data = file.get_var()


func add_meta_upgrade(upgrade: MetaUpgrade) -> void:
	if not save_data["meta_upgrades"].has(upgrade.id):
		save_data["meta_upgrades"][upgrade.id] = {
			"quantity": 0
			}
	save_data["meta_upgrades"][upgrade.id]["quantity"] += 1
	save_game()


func get_upgrade_quantity(upgrade_id: String) -> int:
	var current_quantity = 0
	if save_data["meta_upgrades"].has(upgrade_id):
		current_quantity = save_data["meta_upgrades"][upgrade_id]["quantity"]
	return current_quantity


func on_experience_vial_collected(exp_value: float) -> void:
	save_data["meta_upgrades_currency"] += exp_value
