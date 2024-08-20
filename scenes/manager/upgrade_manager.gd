extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: ExperienceManager
@export var upgrade_scene: PackedScene

var current_upgrades = {}

func _ready():
	experience_manager.level_up.connect(on_level_up)


func on_level_up(new_level: int) -> void:
	var chosen_upgrade: AbilityUpgrade = upgrade_pool.pick_random()	as AbilityUpgrade
	if chosen_upgrade == null:
		return
	
	var upgrade_scene_instance = upgrade_scene.instantiate()
	add_child(upgrade_scene_instance)
	upgrade_scene_instance.set_ability_upgrades([chosen_upgrade] as Array[AbilityUpgrade])
	upgrade_scene_instance.upgrade_selected.connect(on_upgrade_selected)


func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)


func apply_upgrade(upgrade: AbilityUpgrade):
	if not current_upgrades.has(upgrade.id):
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
			}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
