class_name ItemSlot extends MarginContainer


signal contents_updated


@export var default_stylebox: StyleBoxFlat

@export var hovered_stylebox: StyleBoxFlat

@export var selected_stylebox: StyleBoxFlat

@export var hovered_selected_stylebox: StyleBoxFlat





@export_group("Node Exports")

@export var panel: PanelContainer

@export var count_label: Label

@export var texture_rect: TextureRect



var parent_inventory: Inventory

var item_stack: ItemStack






var hover_enabled:= true

var select_enabled:= true



var hovered:= false

var selected:= false






func _ready() -> void:

	if default_stylebox:

		panel.add_theme_stylebox_override("panel", default_stylebox)

	mouse_entered.connect(_on_mouse_entered_slot)

	mouse_exited.connect(_on_mouse_exited_slot)

	gui_input.connect(_on_slot_gui_input)




func update() -> void:

	_update_item_visuals()

	_update_item_texture()

	_update_panel_visuals()




func set_stack(_item_stack: ItemStack) -> void:

	if item_stack:

		if item_stack == _item_stack:

			return

		item_stack.count_updated.disconnect(_on_stack_count_updated)

	item_stack = _item_stack

	if item_stack:

		item_stack.count_updated.connect(_on_stack_count_updated)

	contents_updated.emit()

	update()




func set_hover_enabled(state: bool) -> void:

	hover_enabled = state

	_update_panel_visuals()



func set_select_enabled(state: bool) -> void:

	select_enabled = state

	_update_panel_visuals()



func set_hovered_state(state: bool) -> void:

	hovered = state

	_update_panel_visuals()



func set_selected_state(state: bool) -> void:

	selected = state

	_update_panel_visuals()

	_update_item_texture()




func clear() -> void:

	set_stack(null)

	count_label.text = ""

	texture_rect.texture = null




func swap(target_slot: ItemSlot) -> void:

	var temp_stack = target_slot.item_stack

	target_slot.set_stack(item_stack)

	set_stack(temp_stack)





func is_empty() -> bool:

	return !item_stack or item_stack.is_empty()






func _update_panel_visuals() -> void:

	var chosen_stylebox:= default_stylebox

	match [selected, hovered]:

		[true, true]:

			chosen_stylebox = hovered_selected_stylebox

		[true, false]:

			chosen_stylebox = selected_stylebox

		[false, true]:

			chosen_stylebox = hovered_stylebox

		[false, false]:

			chosen_stylebox = default_stylebox

	panel.add_theme_stylebox_override("panel", chosen_stylebox)






func _update_item_visuals() -> void:

	if item_stack and !item_stack.is_empty():

		count_label.text = str(item_stack.count)

		texture_rect.texture = item_stack.item_def.sprite_texture

	else:

		count_label.text = ""

		texture_rect.texture = null





func _update_item_texture() -> void:

	if selected:

		texture_rect.modulate = Color.BLACK

	else:

		texture_rect.modulate = Color.WHITE






func _on_mouse_entered_slot() -> void:

	if hover_enabled:

		set_hovered_state(true)




func _on_mouse_exited_slot() -> void:

	if hover_enabled:

		set_hovered_state(false)




func _on_slot_gui_input(event: InputEvent) -> void:

	if event is InputEventMouseButton:

		UI.mouse_item_slot.handle_slot_input(self, event)




func _on_stack_item_updated() -> void:

	_update_item_visuals()





func _on_stack_count_updated() -> void:

	_update_item_visuals()