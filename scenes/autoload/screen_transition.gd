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


func emit_transition_halfway() -> void:
	if skip_emit:
		skip_emit = false
		return
	transition_halfway.emit()
