class_name Inventory extends Resource



signal slot_updated(slot_index: int)

signal weapon_updated

signal armor_updated


@export var stacks: Array[ItemStack]

@export var size:= 9

@export var loot_table: LootTable

@export var weapon: WeaponData

@export var armor: ArmorData






func _initialize() -> void:

	resize(size)




func resize(_size:= -1) -> void:

	size = size if _size == -1 else _size

	stacks.resize(size)





func add_item(item_def: ItemDef, count:= 1, item_data: ItemData = null) -> int:

	var remaining = count

	for i in range(size):

		var stack = stacks[i]

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






func get_item_list() -> Dictionary[ItemDef, int]:

	var item_list: Dictionary[ItemDef, int] = {}

	for stack in stacks:

		if is_instance_valid(stack) and !stack.is_empty():

			item_list[stack.item_def] = stack.count

	return item_list





func get_first_empty_slot_index() -> int:

	for i in range(size):

		var stack = stacks[i]

		if !is_instance_valid(stack):

			return i

	return -1




func get_slot_index_with_data(item_data: ItemData) -> int:

	for i in range(size):

		var stack = stacks[i]

		if is_instance_valid(stack) and stack.item_data == item_data:

			return i

	return -1




func get_slot_index_with_def(item_def: ItemDef, count:= -1) -> int:

	for i in range(size):

		var stack = stacks[i]

		if is_instance_valid(stack) and stack.item_def == item_def:

			if count == -1 or stack.count >= count:

				return i

	return -1




func get_slot_stack(index: int) -> ItemStack:

	if index <= size:

		return stacks[index]

	return null





func set_slot_stack(index: int, stack: ItemStack) -> void:

	if stacks[index] == stack:

		return

	stacks[index] = stack

	slot_updated.emit(index)


	







func set_weapon(_weapon: WeaponData) -> void:

	if weapon == _weapon:

		return

	weapon = _weapon
	
	weapon_updated.emit()





func set_armor(_armor: ArmorData) -> void:

	if armor == _armor:

		return

	armor = _armor

	armor_updated.emit()