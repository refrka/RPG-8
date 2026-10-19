class_name DebugBehaviorPanel extends PanelContainer



@export var entity_id_label: Label

@export var current_behavior_label: Label



var selected_entity: EntityNode

var behavior_component: BehaviorComponent







func select_entity(entity_node: EntityNode) -> void:

	selected_entity = entity_node

	_update()





func clear() -> void:

	entity_id_label.text = "[ n/a ]"

	current_behavior_label.text = "[ no behavior ]"

	if behavior_component:

		behavior_component.behavior_changed.disconnect(_on_behavior_changed)

		behavior_component = null






func _update() -> void:

	clear()

	if selected_entity:

		entity_id_label.text = selected_entity.entity_def.entity_id

		behavior_component = selected_entity.get_component(BehaviorComponent)

		if !behavior_component or behavior_component.disabled:

			current_behavior_label.text = "[ no behavior ]"

			return

		behavior_component.behavior_changed.connect(_on_behavior_changed)

		current_behavior_label.text = behavior_component.current_behavior.display_name




func _on_behavior_changed() -> void:

	current_behavior_label.text = behavior_component.current_behavior.display_name