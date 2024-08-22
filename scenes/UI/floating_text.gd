extends Node2D

@onready var label = $Label


func start(display_text: String):
	label.text = display_text
	var tween: Tween = create_tween()
	scale = Vector2.ZERO
	
	tween.set_parallel()
	tween.tween_property(self, "global_position", global_position + 8 * Vector2.UP, 0.5)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", Vector2.ONE, 0.25)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.chain()	

	tween.tween_property(self, "global_position", global_position + 16 * Vector2.UP, 0.25)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.25)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
	tween.chain()
	tween.tween_callback(queue_free)

