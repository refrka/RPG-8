class_name EquipmentSlot extends ItemSlot





@export var equipment_type: EquipmentDef.EquipmentType






func _can_accept_slot_contents(incoming_slot: ItemSlot) -> bool:

	var incoming_def = incoming_slot.item_stack.get_item_def()

	if not incoming_def is EquipmentDef or incoming_def.equipment_type != equipment_type:

		return false

	return true