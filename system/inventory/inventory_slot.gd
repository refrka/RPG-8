class_name InventorySlot extends Resource


signal stack_updated



@export var item_stack: ItemStack








func _initialize() -> void:

	if !item_stack:

		item_stack = ItemStack.new()

	item_stack.item_updated.connect(_on_stack_item_updated)

	item_stack.count_updated.connect(_on_stack_count_updated)




func is_empty() -> bool:

	return not item_stack or item_stack.count <= 0




func _on_stack_item_updated() -> void:

	stack_updated.emit()



func _on_stack_count_updated() -> void:
	
	stack_updated.emit()




