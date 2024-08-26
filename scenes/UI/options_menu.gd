class_name OptionsMenu
extends CanvasLayer

signal back_pressed

@onready var sound_slider = %SoundSlider
@onready var music_slider = %MusicSlider
@onready var fullscreen_check_box = %FullscreenCheckBox
@onready var back_button = %BackButton


func _ready():
	sound_slider.value_changed.connect(on_slider_value_changed.bind("sfx"))
	music_slider.value_changed.connect(on_slider_value_changed.bind("music"))
	fullscreen_check_box.toggled.connect(on_fullscreen_check_box_toggled)
	back_button.pressed.connect(on_back_button_pressed)
	update_ui()


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		get_tree().root.set_input_as_handled()
		back_pressed.emit()


func update_ui() -> void:
	sound_slider.value = get_bus_volume_percent("sfx")
	music_slider.value = get_bus_volume_percent("music")
	fullscreen_check_box.button_pressed = DisplayServer.window_get_mode() == 3


func get_bus_volume_percent(bus_name: String) -> float:
	var bus_index: int = AudioServer.get_bus_index(bus_name)
	var volume_db: float = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(volume_db)


func set_bus_volume_percent(percent: float, bus_name: String) -> void:
	var bus_index: int = AudioServer.get_bus_index(bus_name)
	var db_volume = linear_to_db(percent)
	AudioServer.set_bus_volume_db(bus_index, db_volume)


func on_slider_value_changed(value: float, bus_name: String) -> void:
	set_bus_volume_percent(value, bus_name)


func on_fullscreen_check_box_toggled(button_pressed: bool) -> void:
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func on_back_button_pressed() -> void:
	back_pressed.emit()
