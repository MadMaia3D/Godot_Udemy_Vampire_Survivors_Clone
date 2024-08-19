extends CanvasLayer

@onready var label = %Label

@export var arena_time_manager: ArenaTimerManager


func _physics_process(delta):
	if arena_time_manager == null:
		return
	var remaining_time: float = arena_time_manager.get_time_elapsed()
	
	label.text = format_seconds_to_string(remaining_time)


func format_seconds_to_string(seconds: float):
	var minutes: int = floor(seconds / 60)
	var remaining_seconds: int = floor(fmod(seconds, 60))
	return (str(minutes)) + ":" + ("%02d" % remaining_seconds)
