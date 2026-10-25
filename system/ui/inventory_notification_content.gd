class_name InventoryNotificationContentPanel extends NotificationContentPanel


@export var item_slot: ItemSlot

@export var message_label: Label



var added:= true



func load_content(item_def: ItemDef, amount_change: int, _added:= true) -> void:

	added = _added

	if !item_slot.is_empty():

		var item_stack = item_slot.item_stack

		item_stack.add_amount(amount_change)

	item_slot.set_stack(ItemStack.create_new(item_def, count_change))