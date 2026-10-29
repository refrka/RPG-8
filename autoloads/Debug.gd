extends Node



signal debug_state_changed(state: bool)



var debug_root: Control

var debug_behavior_panel: DebugBehaviorPanel


var active:= false

var select_multiple:= false

var selected_entities: Array[EntityNode]




func _ready() -> void:

	debug_root = get_tree().get_first_node_in_group("debug_root")

	debug_behavior_panel = get_tree().get_first_node_in_group("debug_behavior_panel")

	_set_debug_state(false)





func select_entity(entity: EntityNode) -> void:

	if !select_multiple and !selected_entities.is_empty():

		for _entity in selected_entities:

			_entity.debug_panel.deselect()

		selected_entities.clear()

	selected_entities.append(entity)

	entity.debug_panel.select()

	debug_behavior_panel.select_entity(entity)




func deselect_entity(entity: EntityNode) -> void:

	if selected_entities.has(entity):

		selected_entities.erase(entity)

	entity.debug_panel.deselect()

	debug_behavior_panel.clear()





func _set_debug_state(state:= false) -> void:

	if !debug_root:

		return

	active = state

	if active:

		debug_root.show()

	else:

		debug_root.hide()

	debug_state_changed.emit(state)




func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("debug"):

		_set_debug_state(!active)