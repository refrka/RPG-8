class_name InventoryGrid extends GridContainer


@onready var item_slot_scene = preload("res://system/ui/item_slot.tscn")



var inventory: Inventory





func load_inventory(_inventory: Inventory) -> void:

	inventory = _inventory

	for i in range(inventory.size):

		var stack = inventory.get_slot_stack(i)

		var item_slot = item_slot_scene.instantiate() as ItemSlot

		item_slot.set_stack(stack)

		add_child(item_slot)






