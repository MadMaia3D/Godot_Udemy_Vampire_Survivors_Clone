extends PanelContainer

signal selected

@onready var animation_player = $AnimationPlayer
@onready var hover_animation_player = $HoverAnimationPlayer

var disabled: bool = false

func _ready():
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)


func play_enter_animation(delay: float = 0) -> void:
	modulate = Color.TRANSPARENT
	await get_tree().create_timer(delay).timeout
	animation_player.play("enter")


func set_ability_upgrade(upgrade: AbilityUpgrade) -> void:
	%NameLabel.text = upgrade.name
	%DescriptionLabel.text = upgrade.description


func select_card() -> void:	
	var cards = get_tree().get_nodes_in_group("upgrade_card")
	for card in cards:
		card.disabled = true
		card.hover_animation_player.pause()
		if card == self:
			card.animation_player.play("selected")
		else:
			card.animation_player.play("exit")
	
	await animation_player.animation_finished	
	selected.emit()

func on_gui_input(event: InputEvent):
	if disabled:
		return
	if event.is_action_pressed("left_click"):
		select_card()


func on_mouse_entered() -> void:
	if disabled:
		return
	hover_animation_player.play("hover_in")


func on_mouse_exited() -> void:
	if disabled:
		return
	hover_animation_player.play("hover_out")
