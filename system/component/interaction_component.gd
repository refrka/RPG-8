class_name InteractionComponent extends Component






func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS







func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	var input_component = entity.get_component(InputComponent)

	if input_component:

		input_component.interact_pressed.connect(_on_interact_input_pressed)

		input_component.interact_released.connect(_on_interact_input_released)






func start_interaction(target_entity: EntityNode) -> void:

	var interactable_component = target_entity.get_interactable_component()

	if interactable_component:

		pass

	else:

		pass




func end_interaction() -> void:

	pass




func complete_interaction() -> void:

	pass



func is_interacting() -> bool:

	return entity.state_machine.current_body_state is BodyInteractingState







func _on_interact_input_pressed() -> void:

	pass



func _on_interact_input_released() -> void:

	pass