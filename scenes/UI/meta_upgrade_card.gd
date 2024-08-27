extends PanelContainer

@onready var animation_player = $AnimationPlayer
@onready var name_label = %NameLabel
@onready var description_label = %DescriptionLabel
@onready var purchase_button = %PurchaseButton


func _ready():
	purchase_button.gui_input.connect(on_gui_input)


func set_meta_upgrade(upgrade: MetaUpgrade) -> void:
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func select_card() -> void:	
	animation_player.play("selected")
	

func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		select_card()
