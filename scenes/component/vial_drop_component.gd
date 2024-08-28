extends Node

@export_range(0, 1) var drop_chance_base: float = 0.5
@export var health_component: HealthComponent
@export var experience_vial_scene: PackedScene

func _ready():
	health_component.died.connect(on_died)


func on_died():
	var experience_chance_upgrade_count = MetaProgression.get_upgrade_quantity("experience_chance")
	var modified_drop_chance = drop_chance_base + 0.05 * experience_chance_upgrade_count
	
	if experience_vial_scene == null:
		return
		
	if not owner is Node2D:
		return
	
	if randf() > modified_drop_chance:
		return
	
	var spawn_position = (owner as Node2D).global_position
	var vial_instance = experience_vial_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(vial_instance)
	vial_instance.global_position = spawn_position
