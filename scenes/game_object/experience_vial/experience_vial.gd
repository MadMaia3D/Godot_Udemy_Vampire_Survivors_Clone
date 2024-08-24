extends Node2D

var collecting: bool = false


func _ready():
	$Area2D.area_entered.connect(on_area_2d_area_entered)


func start_collecting() -> void:
	if collecting:
		return
	collecting = true
	var temp_timer: SceneTreeTimer = get_tree().create_timer(0.1)
	await temp_timer.timeout;
	
	var tween: Tween = create_tween()	
	tween.set_parallel()
	
	tween.tween_method(tween_collect_animation.bind(global_position), 0.0, 1.0, 0.5)\
	.set_ease(Tween.EASE_IN)\
	.set_trans(Tween.TRANS_BACK)
	
	tween.tween_property(self, "scale", Vector2.ZERO, 0.2).set_delay(0.4)
	
	tween.chain()
	tween.tween_callback(collect)


func collect() -> void:
	$RandomStreamPlayer2DComponent.play_random()
	GameEvents.experience_vial_collected.emit(10)
	await $RandomStreamPlayer2DComponent.finished
	queue_free()


func tween_collect_animation(tween_value: float, start_position: Vector2) -> void:
	var player: Node2D = get_tree().get_first_node_in_group("player") as Node2D
	if player != null:
		global_position = start_position.lerp(player.global_position, tween_value)


func on_area_2d_area_entered(area: Area2D) -> void:
	start_collecting()
