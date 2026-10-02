class_name MouseItemSlot extends ItemSlot



var selected_slot: ItemSlot

var held_slot: ItemSlot





func _ready() -> void:

	clear()





func handle_slot_input(target_slot: ItemSlot, event: InputEvent) -> void:

	match [event.button_index, event.is_pressed(), target_slot.is_empty(), is_empty()]:

		[1, true, true, true]: # Left click (down), empty slot, nothing held

			selected_slot = target_slot

			target_slot.set_selected_state(true)

		[1, true, true, false]: # Left click (down), empty slot, something held

			target_slot.swap(held_slot)

			drop_slot()

		[1, true, false, false]: # Left click (down), occupied slot, something held

			if target_slot == held_slot:

				drop_slot()

			else:

				if target_slot.item_stack.can_stack(held_slot.item_stack):

					target_slot.item_stack.merge_stack(held_slot.item_stack)

				else:

					target_slot.swap(held_slot)

					drop_slot()

		[2, true, true, false]: # Right click (down), empty slot, something held

			drop_slot()

		[1, false, true, true]: # Left click (up), empty slot, nothing held

			if selected_slot:

				selected_slot.set_selected_state(false)

		[1, true, false, true]: # Left click (down), occupied slot, nothing held

			hold_slot(target_slot)

			





func hold_slot(item_slot: ItemSlot) -> void:

	selected_slot = item_slot

	held_slot = item_slot

	held_slot.set_selected_state(true)

	set_stack(held_slot.item_stack)




func drop_slot() -> void:

	held_slot.set_selected_state(false)

	held_slot = null

	selected_slot = null

	set_stack(null)




func is_empty() -> bool:

	return !held_slot or held_slot.is_empty()





func _unhandled_input(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.button_index == 2 and event.is_pressed():

		if !is_empty():

			drop_slot()





func _process(_delta: float) -> void:

	if held_slot:

		global_position = get_global_mouse_position()