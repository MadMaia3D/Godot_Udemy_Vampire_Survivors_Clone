extends CanvasLayer

@onready var start_button = %StartButton
@onready var options_button = %OptionsButton
@onready var quit_button = %QuitButton

var options_scene: PackedScene = preload("res://scenes/UI/options_menu.tscn")

func _ready():
	start_button.pressed.connect(on_start_button_pressed)
	options_button.pressed.connect(on_options_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)


func on_start_button_pressed() -> void:
	ScreenTransition.play_transition()
	await ScreenTransition.transition_halfway
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_options_button_pressed() -> void:
	ScreenTransition.play_transition()
	await ScreenTransition.transition_halfway
	var options_instance: OptionsMenu = options_scene.instantiate() as OptionsMenu
	add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))
	

func on_quit_button_pressed() -> void:
	ScreenTransition.play_transition()
	await ScreenTransition.transition_halfway
	get_tree().quit()


func on_options_closed(options_instance: Node) -> void:
	ScreenTransition.play_transition()
	await ScreenTransition.transition_halfway
	options_instance.queue_free()
