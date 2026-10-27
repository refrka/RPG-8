extends Node


signal construction_mode_state_updated(state: bool)

signal construction_entity_updated

var mouse_constructor: MouseConstructor

var construction_mode_enabled:= false


var construction_entity: EntityDef

var construction_entity_slot: ConstructionEntitySlot





func _ready() -> void:

	mouse_constructor = get_tree().get_first_node_in_group("mouse_constructor")






func set_construction_mode(state: bool) -> void:

	construction_mode_enabled = state

	construction_mode_state_updated.emit(state)

	if state == false:

		set_construction_entity(null, null)




func set_construction_entity(entity_def: EntityDef, _construction_entity_slot: ConstructionEntitySlot) -> void:

	if construction_entity and construction_entity_slot:

		construction_entity_slot.set_selected_state(false)

	construction_entity = entity_def

	construction_entity_slot = _construction_entity_slot

	construction_entity_updated.emit()




func _unhandled_input(event: InputEvent) -> void:

	if not Game.active:

		return

	if event.is_action_pressed("construction_mode"):

		set_construction_mode(not construction_mode_enabled)