class_name RestrainedPassiveEffect extends PassiveEffect





func _apply() -> void:

	super()

	var body_restrained_state = entity.state_machine.get_state(BodyRestrainedState)

	if body_restrained_state:

		body_restrained_state.restraint_broken.connect(_on_restraint_broken, CONNECT_ONE_SHOT)

		entity.state_machine.request_state(BodyRestrainedState)




func _remove() -> void:

	super()

	entity.state_machine.request_state(BodyIdleState)





func _on_restraint_broken() -> void:

	_expire()