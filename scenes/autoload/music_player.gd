extends AudioStreamPlayer


var base_volume: float

@onready var timer: Timer = $Timer as Timer


func _ready():
	base_volume = volume_db
	$Timer.timeout.connect(on_timer_timeout)
	finished.connect(on_music_finished)
	GameEvents.game_paused.connect(on_game_paused)
	GameEvents.game_unpaused.connect(on_game_unpaused)


func on_timer_timeout() -> void:
	play()
	

func on_music_finished() -> void:
	timer.start()


func on_game_paused() -> void:
	volume_db = base_volume - 10


func on_game_unpaused() -> void:
	volume_db = base_volume
