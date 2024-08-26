extends CanvasLayer

var is_closing = false

@onready var options_menu_scene: PackedScene = preload("res://scenes/UI/options_menu.tscn")
@onready var animation_player = $AnimationPlayer
@onready var panel_container = $MarginContainer/PanelContainer


func _ready() -> void:
	GameEvents.pause_game()
	%ResumeButton.pressed.connect(on_resume_pressed)
	%OptionsButton.pressed.connect(on_options_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)
	
	animation_player.play("fade_in")
	
	panel_container.pivot_offset += panel_container.size / 2
	var tween: Tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)


func _unhandled_input(event) -> void:
	if event.is_action_pressed("pause"):
		close()
	get_tree().root.set_input_as_handled()


func close() -> void:
	if is_closing:
		return
	
	is_closing = true
	animation_player.play_backwards("fade_in")
	var tween: Tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.0)
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0.2)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	
	GameEvents.unpause_game()
	tween.tween_callback(queue_free)


func on_resume_pressed() -> void:
	close()


func on_options_pressed() -> void:
	var options_menu_instance: OptionsMenu = options_menu_scene.instantiate() as OptionsMenu
	add_child(options_menu_instance)
	options_menu_instance.back_pressed.connect(on_options_back_pressed.bind(options_menu_instance))


func on_quit_pressed() -> void:
	GameEvents.unpause_game()
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")


func on_options_back_pressed(options_menu: Node) -> void:
	options_menu.queue_free()
