extends CanvasLayer

signal transition_halfway

var skip_emit = false

@onready var animation_player = $AnimationPlayer


func play_transition() -> void:
	if skip_emit:
		return
	animation_player.play("default")
	await transition_halfway
	skip_emit = true
	animation_player.play_backwards("default")


func transition_to_scene(scene_path: String) -> void:
	play_transition()
	await transition_halfway
	get_tree().change_scene_to_file(scene_path)


func transition_to_scene_and_unpause(scene_path: String) -> void:
	play_transition()
	await transition_halfway
	GameEvents.unpause_game()
	get_tree().change_scene_to_file(scene_path)


func emit_transition_halfway() -> void:
	if skip_emit:
		skip_emit = false
		return
	transition_halfway.emit()
