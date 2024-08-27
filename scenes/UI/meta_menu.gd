extends CanvasLayer

@export var meta_upgrades_list: Array[MetaUpgrade] = []

@onready var meta_card_scene = preload("res://scenes/UI/meta_upgrade_card.tscn")
@onready var grid_container = $MarginContainer/GridContainer
@onready var back_button = $MarginContainer/BackButton


func _ready():
	back_button.pressed.connect(on_back_button_pressed)
	
	for placeholder in grid_container.get_children():
		placeholder.queue_free()
	
	for upgrade in meta_upgrades_list:
		var meta_card_instance: MetaUpgradeCard = meta_card_scene.instantiate() as MetaUpgradeCard
		grid_container.add_child(meta_card_instance)
		meta_card_instance.set_meta_upgrade(upgrade)


func on_back_button_pressed() -> void:
	ScreenTransition.transition_to_scene("res://scenes/UI/main_menu.tscn")
