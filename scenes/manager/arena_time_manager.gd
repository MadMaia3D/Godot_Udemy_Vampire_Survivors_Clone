class_name ArenaTimerManager
extends Node

signal arena_difficulty_increased(arena_difficult: int)

const DIFFICULT_INTERVAL: int = 5

@export var end_screen_scene: PackedScene

var arena_difficult: int = 0
var next_difficult_time: float = 0

@onready var timer: Timer = $Timer


func _ready():
	timer.timeout.connect(on_timer_timeout)
	next_difficult_time = calculate_next_difficult_time()


func _physics_process(delta):
	if timer.time_left <= next_difficult_time:
		arena_difficult += 1
		next_difficult_time = calculate_next_difficult_time()
		arena_difficulty_increased.emit(arena_difficult)


func get_time_elapsed() -> float:
	return timer.wait_time - timer.time_left


func on_timer_timeout() -> void:
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)


func calculate_next_difficult_time() -> float:
	return timer.wait_time - ((arena_difficult + 1) * DIFFICULT_INTERVAL)
