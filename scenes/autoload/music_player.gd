extends AudioStreamPlayer


@onready var timer: Timer = $Timer as Timer


func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	finished.connect(on_music_finished)


func on_timer_timeout() -> void:
	play()
	

func on_music_finished() -> void:
	timer.start()
