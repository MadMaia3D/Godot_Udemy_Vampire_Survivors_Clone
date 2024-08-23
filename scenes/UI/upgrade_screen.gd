extends CanvasLayer

signal upgrade_selected(upgrade: AbilityUpgrade)

@export var upgrade_card_scene: PackedScene

@onready var card_container: VBoxContainer = %CardContainer


func _ready() -> void:
	get_tree().paused = true


func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	var delay: float = 0.0
	for upgrade in upgrades:
		var card_instance = upgrade_card_scene.instantiate()
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		card_instance.selected.connect(on_upgrade_selected.bind(upgrade))
		card_instance.play_enter_animation(delay)
		delay += 0.1


func on_upgrade_selected(upgrade: AbilityUpgrade):
	var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer
	animation_player.play("fade_out")
	await animation_player.animation_finished

	upgrade_selected.emit(upgrade)
	get_tree().paused = false
	queue_free()
