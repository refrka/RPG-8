class_name InventoryNotification extends Notification



@export var item_slot: ItemSlot

@export var message_label: Label



var item_def: ItemDef

var count: int

var added: bool





func set_notification(_item_def: ItemDef, _count: int, _added: bool) -> void:

	item_def = _item_def

	count = _count

	added = _added

	item_slot.set_stack(ItemStack.create_new(item_def, count))

	_update_message()

	

func update_count(amount: int) -> void:

	count += amount

	_reset_timer()

	_update_message()



func _update_message() -> void:

	message_label.text = "%s %s ( %s )" % [

		item_def.display_name,

		"added" if count > 0 else "removed",

		count

	]