class_name WeightedTable

var items: Array[Dictionary] = []
var weight_sum: int = 0


func add_item(item: Variant, weight: int):
	items.append({"item": item, "weight": weight})
	weight_sum += weight


func remove(item_to_remove) -> void:
	items = items.filter(func(item): return item["item"].id != item_to_remove.id)
	weight_sum = 0
	weight_sum = calculate_weight(items)

func calculate_weight(container: Array[Dictionary]) -> int:
	var sum: int = 0
	for item in container:
		sum += item["weight"]
	return sum


func pick_item(filter: Array[Variant] = []) -> Variant:
	var items_temp: Array[Dictionary] = items.duplicate()
	var weight_sum_temp: int = weight_sum
	if filter.size() > 0:
		items_temp = []
		weight_sum_temp = 0
		for item in items:
			if not item["item"] in filter:
				items_temp.append(item)
				weight_sum_temp += item["weight"]
	
	var chosen_weight = randi_range(1, weight_sum_temp)
	var iteration_sum: int = 0
	for item in items_temp:
		iteration_sum += item["weight"]
		if chosen_weight <= iteration_sum:
			return item["item"]
	if items_temp.size() > 0:
		return items_temp.back()["item"]
	else:
		return null
