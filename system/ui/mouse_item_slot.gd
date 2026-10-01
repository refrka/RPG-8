class_name MouseItemSlot extends ItemSlot



var held_slot: ItemSlot





func _ready() -> void:

	clear()






func hold_slot(item_slot: ItemSlot) -> void:

	held_slot = item_slot





func _process(_delta: float) -> void:

	if held_slot:

		global_position = get_global_mouse_position()