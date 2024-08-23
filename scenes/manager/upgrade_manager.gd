extends Node

@export var experience_manager: ExperienceManager
@export var upgrade_scene: PackedScene

var current_upgrades = {}
var upgrade_pool: WeightedTable = WeightedTable.new()

var upgrade_axe: AbilityUpgrade = preload("res://resources/upgrades/axe.tres")
var upgrade_axe_damage: AbilityUpgrade = preload("res://resources/upgrades/axe_damage.tres")
var upgrade_sword_damage: AbilityUpgrade = preload("res://resources/upgrades/sword_damage.tres")
var upgrade_sword_rate: AbilityUpgrade = preload("res://resources/upgrades/sword_rate.tres")

func _ready():
	experience_manager.level_up.connect(on_level_up)
	
	upgrade_pool.add_item(upgrade_axe, 10)
	upgrade_pool.add_item(upgrade_sword_damage, 10)
	upgrade_pool.add_item(upgrade_sword_rate, 10)


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
			upgrade_pool.remove(upgrade)
	if upgrade.id == "axe":
		upgrade_pool.remove(upgrade)
		upgrade_pool.add_item(upgrade_axe_damage, 10)

	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func pick_upgrades(quantity: int) -> Array[AbilityUpgrade]:
	var chosen_upgrades: Array[AbilityUpgrade] = []
	
	var quantity_to_pick = min(quantity, upgrade_pool.items.size())
	for i in quantity_to_pick:
		var chosen: AbilityUpgrade = upgrade_pool.pick_item(chosen_upgrades) as AbilityUpgrade
		chosen_upgrades.append(chosen)
#
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
