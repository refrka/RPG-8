class_name ItemNoticePanel extends NoticePanel




@export var item_slot: ItemSlot

@export var primary_label: Label

@export var secondary_label: Label



var added: bool





func _load_notice(_notice: Notice) -> void:

	super(_notice)

	added = notice.added

	var item_stack = ItemStack.create_new(notice.item_def, notice.amount)

	item_slot.set_stack(item_stack)

	var primary_text = notice.item_def.display_name

	primary_label.text = primary_text

	_update_secondary_text()





func _update_secondary_text() -> void:

	var secondary_text = "%s ( %s )" % [

		"added" if added else "removed",

		item_slot.item_stack.count

	]

	secondary_label.text = secondary_text

	



func update_notice_count(amount: int) -> void:

	item_slot.item_stack.add_amount(amount)

	_update_secondary_text()

	_reset_timer()


