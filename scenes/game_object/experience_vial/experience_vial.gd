extends Node2D


func _ready():
	$Area2D.area_entered.connect(on_area_2d_area_entered)


func on_area_2d_area_entered(area: Area2D) -> void:
	GameEvents.experience_vial_collected.emit(10)
	queue_free()
