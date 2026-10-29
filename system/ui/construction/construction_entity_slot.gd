class_name ConstructionEntitySlot extends MarginContainer


@export var texture_rect: TextureRect

@export var panel: PanelContainer

@export var default_stylebox: StyleBoxFlat

@export var hovered_stylebox: StyleBoxFlat

@export var selected_stylebox: StyleBoxFlat

@export var hovered_selected_stylebox: StyleBoxFlat

@export var disabled_stylebox: StyleBoxFlat



var entity_def: EntityDef





var hover_enabled:= true

var select_enabled:= true



var hovered:= false

var selected:= false

var disabled:= false





func _ready() -> void:

	mouse_entered.connect(_on_mouse_entered_slot)

	mouse_exited.connect(_on_mouse_exited_slot)

	gui_input.connect(_on_gui_input)




func set_disabled(state: bool) -> void:

	disabled = state

	_update_panel_visuals()




func set_entity_def(_entity_def: EntityDef) -> void:

	entity_def = _entity_def

	texture_rect.texture = entity_def.icon_texture





func set_hover_enabled(state: bool) -> void:

	hover_enabled = state

	_update_panel_visuals()




func set_select_enabled(state: bool) -> void:

	select_enabled = state

	_update_panel_visuals()



func set_hovered_state(state: bool) -> void:

	hovered = state

	_update_panel_visuals()

	# if hovered and !is_empty():

	# 	show_tooltip()

	# else:

	# 	hide_tooltip()



func set_selected_state(state: bool) -> void:

	selected = state

	_update_panel_visuals()







func _update_panel_visuals() -> void:

	var chosen_stylebox:= default_stylebox

	if disabled:

		chosen_stylebox = disabled_stylebox
		
	else:

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







func _on_mouse_entered_slot() -> void:

	if hover_enabled and not disabled:

		set_hovered_state(true)




func _on_mouse_exited_slot() -> void:

	if hover_enabled and not disabled:

		set_hovered_state(false)




func _on_gui_input(event: InputEvent) -> void:

	if disabled:

		return

	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:

		if not selected:

			set_selected_state(true)

			Constructor.set_construction_entity(entity_def, self)
