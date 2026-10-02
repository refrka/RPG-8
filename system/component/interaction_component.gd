class_name InteractionComponent extends Component




var current_interactable_entity: EntityNode



func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS







func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.interact_pressed.connect(_on_interact_input_pressed)

		input_component.interact_released.connect(_on_interact_input_released)

	entity.interaction_area.interactable_entity_entered_area.connect(_on_interactable_entity_entered_area)

	entity.interaction_area.interactable_entity_exited_area.connect(_on_interactable_entity_exited_area)





func start_interaction(target_entity: EntityNode) -> void:

	entity.state_machine.request_state(BodyInteractingState)

	current_interactable_entity = target_entity

	var interactable_component = target_entity.get_interactable_component()

	if interactable_component:

		interactable_component.interaction_overlay_closed.connect(_on_interaction_overlay_closed)

		interactable_component._start()

	else:

		pass




func end_interaction() -> void:

	entity.state_machine.request_state(BodyIdleState)

	var interactable_component = current_interactable_entity.get_interactable_component()

	interactable_component.interaction_overlay_closed.disconnect(_on_interaction_overlay_closed)

	interactable_component._end()

	current_interactable_entity = null




func complete_interaction() -> void:

	pass



func is_interacting() -> bool:

	return entity.state_machine.current_body_state is BodyInteractingState







func _on_interact_input_pressed() -> void:

	if !is_interacting():

		var nearest_interactable_entity = entity.interaction_area.get_nearest_interactable_entity()

		if nearest_interactable_entity:

			start_interaction(nearest_interactable_entity)

	else:

		end_interaction()




func _on_interact_input_released() -> void:

	pass



func _on_interactable_entity_entered_area(entity_node: EntityNode) -> void:

	pass



func _on_interactable_entity_exited_area(entity_node: EntityNode) -> void:

	if entity_node == current_interactable_entity:

		end_interaction()



func _on_interaction_overlay_closed() -> void:

	end_interaction()