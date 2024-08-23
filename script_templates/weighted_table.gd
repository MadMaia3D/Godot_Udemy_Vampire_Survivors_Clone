class_name WeightedTable

var items: Array[Dictionary] = []
var weight_sum: int = 0


func add_item(item: Variant, weight: int):
	items.append({"item": item, "weight": weight})
	weight_sum += weight


func remove_item(item_to_remove) -> void:
	items = items.filter(func(item): return item["item"].id != item_to_remove.id)
	weight_sum = 0
	weight_sum = calculate_weight(items)


func calculate_weight(container: Array[Dictionary]) -> int:
	var sum: int = 0
	for item in container:
		sum += item["weight"]
	return sum


func pick_item(exclude: Array[Variant] = []) -> Variant:
	var adjusted_items: Array[Dictionary] = items.duplicate()
	var adjusted_weight_sum: int = weight_sum
	if exclude.size() > 0:
		adjusted_items = []
		adjusted_weight_sum = 0
		for item in items:
			if not item["item"] in exclude:
				adjusted_items.append(item)
				adjusted_weight_sum += item["weight"]
	
	var chosen_weight = randi_range(1, adjusted_weight_sum)
	var iteration_sum: int = 0
	for item in adjusted_items:
		iteration_sum += item["weight"]
		if chosen_weight <= iteration_sum:
			return item["item"]
	if adjusted_items.size() > 0:
		return adjusted_items.back()["item"]
	else:
		return null
