
class_name ItemStack extends Resource


signal item_updated

signal count_updated



@export var item_def: ItemDef

@export var item_data: ItemData

@export var count: int










func set_item_data(_item_data: ItemData) -> void:

	item_data = _item_data

	item_updated.emit()




func set_item_def(_item_def: ItemDef) -> void:

	item_def = _item_def

	item_updated.emit()




func set_count(new_count: int) -> void:

	count = new_count

	count_updated.emit()








func add_amount(amount: int) -> int:

	var space = item_def.max_stack - count

	var remaining = amount

	var new_count = count

	if space >= remaining:

		new_count += remaining

		remaining = 0

	else:

		new_count += space

		remaining -= space

	set_count(new_count)

	return remaining




func remove_amount(amount: int) -> int:

	var remaining = amount

	var new_count = count

	if count >= remaining:

		new_count -= remaining

		remaining = 0

	else:

		new_count = 0

		remaining -= count

	set_count(new_count)

	return remaining





func is_empty() -> bool:

	return !item_def or count <= 0




func can_stack() -> bool:

	return not is_instance_valid(item_data)





static func create_new(_item_def: ItemDef, _count: int, _item_data: ItemData = null) -> ItemStack:

	var stack = ItemStack.new()

	stack.item_def = _item_def

	stack.count = _count

	stack.item_data = _item_data

	return stack