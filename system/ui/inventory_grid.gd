class_name InventoryGrid extends GridContainer


@onready var item_slot_scene = preload("res://system/ui/item_slot.tscn")



var inventory: Inventory




func load_inventory(_inventory: Inventory) -> void:

	inventory = _inventory

	inventory.slot_updated.connect(_on_slot_updated)

	for i in range(inventory.size):

		var stack = inventory.get_slot_stack(i)

		var item_slot = item_slot_scene.instantiate() as ItemSlot

		item_slot.set_stack(stack)

		add_child(item_slot)




func _on_slot_updated(index: int) -> void:

	var slot = get_child(index)

	var stack = inventory.get_slot_stack(index)

	slot.set_stack(stack)