extends Resource
class_name AbilityUpgrade

@export var id: String
@export_range(0,999) var max_quantity: int = 0
@export var name: String
@export_multiline var description: String
