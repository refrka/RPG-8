class_name ItemNotice extends Notice



@export var item_def: ItemDef

@export var amount: int

@export var added:= true





static func generate_notice(_item_def: ItemDef, _amount: int, _added: bool) -> ItemNotice:

	var item_notice = ItemNotice.new()

	item_notice.item_def = _item_def

	item_notice.amount = _amount

	item_notice.added = _added

	return item_notice