extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: ExperienceManager
@export var upgrade_scene: PackedScene

var current_upgrades = {}

func _ready():
	experience_manager.level_up.connect(on_level_up)


func apply_upgrade(upgrade: AbilityUpgrade):
	if not current_upgrades.has(upgrade.id):
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
			}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
	
	if upgrade.max_quantity > 0:
		var current_quantity: int = current_upgrades[upgrade.id]["quantity"]
		if current_quantity == upgrade.max_quantity:
			upgrade_pool = upgrade_pool.filter(func (pool_upgrade): return pool_upgrade.id != upgrade.id)

	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func pick_upgrades(quantity: int) -> Array[AbilityUpgrade]:
	var filtered_upgrades: Array[AbilityUpgrade] = upgrade_pool.duplicate()
	filtered_upgrades.shuffle()
	var chosen_upgrades: Array[AbilityUpgrade] = filtered_upgrades.slice(0, 2)
	
	return chosen_upgrades


func on_level_up(new_level: int) -> void:	
	var chosen_upgrades: Array[AbilityUpgrade] = pick_upgrades(2)
	if chosen_upgrades.size() > 0:
		var upgrade_scene_instance = upgrade_scene.instantiate()
		add_child(upgrade_scene_instance)
		upgrade_scene_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
		upgrade_scene_instance.upgrade_selected.connect(on_upgrade_selected)


func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)
