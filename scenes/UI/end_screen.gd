extends CanvasLayer


func _ready():
	GameEvents.pause_game()
	%RestartButton.pressed.connect(on_restart_button_pressed)
	%QuitButton.pressed.connect(on_quit_button_pressed)

	var panel_container:PanelContainer = %PanelContainer
	panel_container.pivot_offset = panel_container.size/2
	var tween: Tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)


func set_defeat():
	%TitleLabel.text = "Game Over"
	%DescriptionLabel.text = "We are sorry!"


func play_victory_jingle() -> void:
	$VictoryAudioStreamPlayer.play()


func play_defeat_jingle() -> void:
	$DefeatAudioStreamPlayer.play()


func on_restart_button_pressed() -> void:
	MetaProgression.save_game()
	ScreenTransition.transition_to_scene_and_unpause("res://scenes/main/main.tscn")


func on_quit_button_pressed() -> void:
	MetaProgression.save_game()
	ScreenTransition.transition_to_scene_and_unpause("res://scenes/UI/main_menu.tscn")
