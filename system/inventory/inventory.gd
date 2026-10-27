class_name Inventory extends Resource



signal slot_updated(slot_index: int)

signal items_added(item_def: ItemDef, amount: int)

signal items_removed(item_def: ItemDef, amount: int)

signal weapon_updated

signal armor_updated

signal accessory_updated

signal tool_updated


@export var stacks: Array[ItemStack]

@export var size:= 9

@export var loot_table: LootTable

@export var weapon: WeaponData

@export var armor: ArmorData

@export var accessory: EquipmentData

@export var tool_equipment: EquipmentData



func _initialize() -> void:

	resize(size)



func clear() -> void:

	stacks.clear()

	weapon = null

	armor = null




func resize(_size:= -1) -> void:

	size = size if _size == -1 else _size

	stacks.resize(size)





func add_item(item_def: ItemDef, count:= 1, item_data: ItemData = null, with_notif:= false) -> int:

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




func remove_item(item_def: ItemDef, count:= 1, _item_data: ItemData = null) -> void:

	items_removed.emit(item_def, count)





func add_stack(item_stack: ItemStack, with_notif:= false) -> void:

	if item_stack.item_data:

		var index = get_first_empty_slot_index()

		if index != -1:

			set_slot_stack(index, item_stack)

	else:

		add_item(item_stack.item_def, item_stack.count, null, with_notif)




func add_item_slot_contents(item_slot: ItemSlot, with_notif:= false) -> void:

	var item_stack = item_slot.item_stack

	add_stack(item_stack, with_notif)




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





func set_accessory(_accessory: EquipmentData) -> void:

	if accessory == _accessory:

		return

	accessory = _accessory

	accessory_updated.emit()





func set_tool(_tool: EquipmentData) -> void:

	if tool_equipment == _tool:

		return

	tool_equipment = _tool

	tool_updated.emit()







func is_equipment_equipped(equipment_def: EquipmentDef) -> bool:

	match equipment_def.get_script():

		WeaponDef:

			if !weapon or weapon.item_def != equipment_def:

				return false

		ArmorDef:

			if !armor or armor.item_def != equipment_def:

				return false

		ToolDef:

			if !tool_equipment or tool_equipment.item_def != equipment_def:

				return false

	return true






func to_dict() -> Dictionary:

	var dict = {}

	dict["size"] = size

	dict["stacks"] = []

	dict["weapon"] = null

	dict["armor"] = null

	if weapon:

		dict["weapon"] = weapon.to_dict()
		
	if armor:

		dict["armor"] = armor.to_dict()

	for item_stack in stacks:

		if item_stack:

			dict["stacks"].append(item_stack.to_dict())

		else:

			dict["stacks"].append(null)

	return dict



