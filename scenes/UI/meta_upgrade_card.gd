class_name MetaUpgradeCard
extends PanelContainer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var progress_label: Label = %ProgressLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var purchase_button: Button = %PurchaseButton

var upgrade: MetaUpgrade


func _ready():
	purchase_button.pressed.connect(on_purchase_button_pressed)


func set_meta_upgrade(upgrade: MetaUpgrade) -> void:
	self.upgrade = upgrade
	name_label.text = upgrade.title
	description_label.text = upgrade.description
	upgrade_progress_info()


func upgrade_progress_info() -> void:
	var user_current_currency: int = MetaProgression.save_data["meta_upgrades_currency"]
	var percent: float = float(user_current_currency) / upgrade.experience_cost
	progress_label.text = str(user_current_currency) + " / " + str(upgrade.experience_cost)
	progress_bar.value = min(percent, 1)
	purchase_button.disabled = percent < 1


func on_purchase_button_pressed() -> void:
	if upgrade == null:
		return
	animation_player.play("selected")
	MetaProgression.add_meta_upgrade(upgrade)
	MetaProgression.save_data["meta_upgrades_currency"] -= upgrade.experience_cost
	MetaProgression.save()
	get_tree().call_group("meta_upgrade_cards", "upgrade_progress_info")
