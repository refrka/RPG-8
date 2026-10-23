class_name EntityDebugPanel extends MarginContainer


@export var entity_id_label: Label

@export var panel: PanelContainer

@export var hover_stylebox: StyleBoxFlat


var active:= false

var selected:= false

var hovered:= false

var entity: EntityNode






func _ready() -> void:

	mouse_entered.connect(_on_mouse_entered)

	mouse_exited.connect(_on_mouse_exited)

	gui_input.connect(_on_gui_input)

	entity = get_parent()

	entity_id_label.text = entity.entity_def.entity_id

	entity_id_label.visible = false

	Debug.debug_state_changed.connect(_on_debug_state_changed)

	mouse_filter = MOUSE_FILTER_IGNORE




func select() -> void:

	selected = true



func deselect() -> void:

	selected = false

	if !hovered:

		_on_mouse_exited()




func _on_mouse_entered() -> void:

	if !active:

		return

	hovered = true

	entity_id_label.visible = true

	panel.add_theme_stylebox_override("panel", hover_stylebox)




func _on_mouse_exited() -> void:

	hovered = false

	if !selected:

		entity_id_label.visible = false

		panel.add_theme_stylebox_override("panel", StyleBoxEmpty.new())





func _on_gui_input(event: InputEvent) -> void:

	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():

		if !selected:

			Debug.select_entity(entity)

		else:

			Debug.deselect_entity(entity)
	



func _on_debug_state_changed(state: bool) -> void:

	active = state

	if active:

		mouse_filter = MOUSE_FILTER_STOP

	else:

		mouse_filter = MOUSE_FILTER_IGNORE

	if !active:

		_on_mouse_exited()

	if !state and selected:

		Debug.deselect_entity(entity)