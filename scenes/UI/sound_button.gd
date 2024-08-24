class_name SoundButton
extends Button

func _ready() -> void:
	pressed.connect(on_pressed)


func on_pressed() -> void:
	$RandomStreamPlayerComponent.play_random()
