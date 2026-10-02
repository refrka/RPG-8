class_name InventoryGrid extends GridContainer


@onready var item_slot_scene = preload("res://system/ui/item_slot.tscn")



var inventory: Inventory




func load_inventory(_inventory: Inventory) -> void:

	if inventory:

		clear()

	inventory = _inventory

	inventory.slot_updated.connect(_on_slot_updated)

	for i in range(inventory.size):

		var stack = inventory.get_slot_stack(i)

		var item_slot = item_slot_scene.instantiate() as ItemSlot

		add_child(item_slot)

		item_slot.contents_updated.connect(_on_slot_contents_updated.bind(i))

		item_slot.parent_inventory = inventory

		item_slot.set_stack(stack)




	
func clear() -> void:

	if !inventory:

		return

	for i in range(inventory.size):

		var child = get_child(i)

		child.queue_free()

	inventory.slot_updated.disconnect(_on_slot_updated)

	inventory = null








func _on_slot_updated(index: int) -> void:

	var slot = get_child(index)

	var stack = inventory.get_slot_stack(index)

	if slot.item_stack == stack:

		return

	slot.set_stack(stack)





func _on_slot_contents_updated(index: int) -> void:

	var item_slot = get_child(index)

	inventory.set_slot_stack(index, item_slot.item_stack)