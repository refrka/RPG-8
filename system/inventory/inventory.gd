class_name Inventory extends Resource


signal slot_updated(slot_index: int)


@export var slots: Array[ItemStack]

@export var size:= 9



@export var weapon: WeaponData






func _initialize() -> void:

	resize(size)




func resize(_size:= -1) -> void:

	size = size if _size == -1 else _size

	slots.resize(size)





func add_item(item_def: ItemDef, count:= 1, item_data: ItemData = null) -> int:

	var remaining = count

	for i in range(size):

		var stack = slots[i]

		if stack != null:

			if stack.item_def == item_def and stack.can_stack():

				remaining = stack.add_amount(remaining)

				slot_updated.emit(i)

				if remaining == 0:

					break

	if remaining > 0:

		var index = get_first_empty_slot_index()

		if index != -1:

			var stack = ItemStack.new()

			stack.set_item_def(item_def)

			stack.set_count(remaining)

			remaining = 0

			stack.set_item_data(item_data)

			set_slot_stack(index, stack)

	return remaining





func add_stack(item_stack: ItemStack) -> void:

	if item_stack.item_data:

		var index = get_first_empty_slot_index()

		if index != -1:

			set_slot_stack(index, item_stack)

	else:

		add_item(item_stack.item_def, item_stack.count)





func get_first_empty_slot_index() -> int:

	for i in range(size):

		var stack = slots[i]

		if !is_instance_valid(stack):

			return i

	return -1




func get_slot_index_with_data(item_data: ItemData) -> int:

	for i in range(size):

		var stack = slots[i]

		if is_instance_valid(stack) and stack.item_data == item_data:

			return i

	return -1




func get_slot_index_with_def(item_def: ItemDef, count:= -1) -> int:

	for i in range(size):

		var stack = slots[i]

		if is_instance_valid(stack) and stack.item_def == item_def:

			if count == -1 or stack.count >= count:

				return i

	return -1




func get_slot_stack(index: int) -> ItemStack:

	if index <= size:

		return slots[index]

	return null





func set_slot_stack(index: int, stack: ItemStack) -> void:

	if slots[index] == stack:

		return

	slots[index] = stack

	slot_updated.emit(index)


	