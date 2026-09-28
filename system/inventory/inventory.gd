class_name Inventory extends Resource





@export var slots: Array[ItemSlot]

@export var size:= 9



@export var weapon_slot: ItemSlot






func _initialize() -> void:

	resize()











func resize() -> void:

	while slots.size() > size:

		slots.pop_back()

	while slots.size() < size:

		slots.append(ItemSlot.new())

	for slot in slots:

		if !slot.stack_updated.is_connected(_on_slot_stack_updated):

			slot.stack_updated.connect(_on_slot_stack_updated.bind(slot))












func get_slot(index: int) -> ItemSlot:

	if slots.size() - 1 >= index:

		return slots[index]

	return null











func _on_slot_stack_updated(item_slot: ItemSlot) -> void:

	pass